param (
    $Username,
	$Password,
    $Credentials,
	$OperationType,
    [bool] $usepagedimport,
	$pagesize
    )


# **************  Configuration *******************
# 'All' for all user types, 'Member' for Azure AD Users and 'Guest' for B2B users
$usersType = "Guest"
$restrictImmutableId = $true 


# **************  Loading Sotered Azure AD Global Admin Credentials *******************
# Should be set for Functions-PSStoredCredentials.ps1
$KeyPath = "$PSScriptRoot" 
. "$PSScriptRoot\Functions-PSStoredCredentials.ps1"

$DebugFilePath = "$PSScriptRoot\Debug\AADImport.txt"

if(!(Test-Path $DebugFilePath))
    {
        $DebugFile = New-Item -Path $DebugFilePath -ItemType File
    }
    else
    {
        $DebugFile = Get-Item -Path $DebugFilePath
    }
    
"Starting Import as : " + $OperationType + (Get-Date) | Out-File $DebugFile -Append

# ******************************************************************



# ********************** Connect to Azure Msol ***************************
# The username must be Azure AD Global Admin
# Should be ser for Functions-PSStoredCredentials.ps1
# Crednitials should be saved in the same directory follow those intructions https://practical365.com/blog/saving-credentials-for-office-365-powershell-scripts-and-scheduled-tasks/
$creds = Get-StoredCredential -UserName $Username

Connect-MsolService -Credential $creds

# *********************** IMPORT **********************************

# Get results
if($usersType -eq "Guest" -or $usersType -eq "Member"){
    $users = Get-MsolUser -All | ? {$_.UserType -eq $usersType}
}
else{
    $users = Get-MsolUser -All
}

"Retrieved Azure Users with type'" + $usersType + "' :" + $users.Count | Out-File $DebugFile -Append

# An Array for the retuned objects to go into 
if($restrictImmutableId){
    $tenantObjects = $users | ? {$_.ImmutableId -ne $null}

    "Total Azure Users with type'" + $usersType + "' and ImmutableId set: " + $tenantObjects.count | Out-File $DebugFile -Append 
}
else {
    $tenantObjects = $users

    "Total Azure Users with type'" + $usersType + "': " + $tenantObjects.count | Out-File $DebugFile -Append
}

# ********************* Process users into the MA *******************
 ForEach($user in $tenantObjects) 
    {
        if ($user.ValidationStatus -eq "Healthy")
        {           
            $obj = @{}
            $obj.Add("ID", $user.ObjectId.toString())
            $obj.Add("objectID", $user.ObjectId.toString())
            $obj.Add("objectClass", "AzureADUser")
            $obj.Add("AADDisplayName",$user.DisplayName)
            $obj.Add("AADGivenName",$user.FirstName)
            $obj.Add("AADImmutableId",$user.ImmutableId)

            # setting user e-mail by using his alternate e-mail address
            if($user.AlternateEmailAddresses -ne $null -and $user.AlternateEmailAddresses.Count > 0){
                $obj.Add("AADMail",$user.AlternateEmailAddresses[0])
            }
            else{
                # setting user e-mail by using his alternate sign-in name as alternate e-mail was not set
                $obj.Add("AADMail",$user.SignInName)
            }
            

            if ($user.ProxyAddresses)
            {
                $proxyAddresses = @()
                foreach($address in $user.proxyAddresses) {
                   $proxyAddresses += $address
                }
                $obj.Add("AADProxyAddresses",($proxyAddresses))
            }

            $obj.Add("AADSurname",$user.LastName)
            $obj.Add("AADUserPrincipalName",$user.UserPrincipalName)
            $obj.Add("AADSignInName",$user.SignInName)
            $obj.Add("AADTelephoneNumber",$user.PhoneNumber)

            $obj.Add("AADCountry",$user.Country)
            $obj.Add("AADPhysicalDeliveryOfficeName",$user.Office)   
            $obj.Add("AADUsageLocation",$user.UsageLocation)
            $obj.Add("AADJobTitle",$user.Title)
            $obj.Add("AADDepartment",$user.Department)
            $obj.Add("AADMobile",$user.Mobile)  
            $obj.Add("AADSipProxyAddress",$user.SIPProxyAddress)       
                       
            $obj.Add("AADCity",$user.city)

            if($obj.AADSignInName -ne $null -and $obj.AADSignInName -ne ''){
                $signInNameParts =  $obj.AADSignInName.Split('@')
                if($signInNameParts.Length -eq 2){
                    
                    $accountName = $signInNameParts[0]
                    $FQDN = $signInNameParts[1]
                    
                    $dn = "CN="+$obj.AADDisplayName

                    foreach($subDomain in $FQDN.Split('.')){
                        $dn = $dn + ",DC=" + $subDomain
                    }

                    $obj.Add("AADDistinguishedName",$dn)
                    $obj.Add("[DN]", $dn) 
                    $obj.Add("AADAccountName",$accountName) 
                }
                else{
                    $obj.Add("[ErrorName]", "read-error")
                    $obj.Add("[ErrorDetail]", "AzurePSMA - Cannot add user's data, Distinguished Name cannot be constructed - Azure AD Property SignInName is not well formatted")
                }
            }
            else{
                $obj.Add("[ErrorName]", "read-error")
                $obj.Add("[ErrorDetail]", "AzurePSMA - Cannot add user's data, Distinguished Name cannot be constructed - Azure AD Property SignInName is null or empty")  
            }

            if($user.AlternativeSecurityIds -ne $null -and $user.AlternativeSecurityIds.Length -gt 0){
                $BinarySid = $user.AlternativeSecurityIds[0].Key

                #Add the SID to the user in the connector space
                $obj.Add("AADSID",$BinarySid)
            }
            else {
                $obj.Add("[ErrorName]", "read-error")
                $obj.Add("[ErrorDetail]", "AzurePSMA - Cannot add user's data, User SID object is missing") 
            }

            
            # Pass the User Object to the MA
            $obj
        }
     }


# ***********************************************************



 "Finished Import as : " + $OperationType + (Get-Date) | Out-File $DebugFile -Append

#endregion