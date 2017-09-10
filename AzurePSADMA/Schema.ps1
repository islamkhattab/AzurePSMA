$obj = New-Object -Type PSCustomObject
$obj | Add-Member -Type NoteProperty -Name "Anchor-ID|String" -Value "08572d0c-e5e6-4b9a-bdf1-576de90aa1d9"
$obj | Add-Member -Type NoteProperty -Name "objectID|String" -Value "08572d0c-e5e6-4b9a-bdf1-576de90aa1d9"
$obj | Add-Member -Type NoteProperty -Name "AADSID|Binary" -Value 0x10
$obj | Add-Member -Type NoteProperty -Name "AADPicture|Binary" -Value 0x10
$obj | Add-Member -Type NoteProperty -Name "objectClass|String" -Value "AzureADUser"
$obj | Add-Member -Type NoteProperty -Name "AADDisplayName|String" -Value "Mary Jay Bligh"
$obj | Add-Member -Type NoteProperty -Name "AADGivenName|String" -Value "Mary"
$obj | Add-Member -Type NoteProperty -Name "AADImmutableId|String" -Value "dbJRmSjG7USE++q42Wk34g=="
$obj | Add-Member -Type NoteProperty -Name "AADMail|String" -Value "maryjb@customer.com.au"
$obj | Add-Member -Type NoteProperty -Name "AADProxyAddresses|String[]" -Value ("smtp:user1@customer.com.au", "smtp:user1@customer.co.nz") 
$obj | Add-Member -Type NoteProperty -Name "AADSurname|String" -Value "Bigh"
$obj | Add-Member -Type NoteProperty -Name "AADUserPrincipalName|String" -Value "maryjb@customer.com.au"
$obj | Add-Member -Type NoteProperty -Name "AADSignInName|String" -Value "maryjb@customer.com.au"
$obj | Add-Member -Type NoteProperty -Name "AADTelephoneNumber|String" -Value "02 1234 5678"
$obj | Add-Member -Type NoteProperty -Name "AADCountry|String" -Value "Australia"
$obj | Add-Member -Type NoteProperty -Name "AADPhysicalDeliveryOfficeName|String" -Value "The Big Building"
$obj | Add-Member -Type NoteProperty -Name "AADUsageLocation|String" -Value "AU"
$obj | Add-Member -Type NoteProperty -Name "AADJobTitle|String" -Value "BOSS"
$obj | Add-Member -Type NoteProperty -Name "AADDepartment|String" -Value "BOSS"
$obj | Add-Member -Type NoteProperty -Name "AADMobile|String" -Value "0400 123 456" 
$obj | Add-Member -Type NoteProperty -Name "AADSipProxyAddress|String" -Value "sip:maryjb@customer.com.au" 
$obj | Add-Member -Type NoteProperty -Name "AADOtherMails|String[]" -Value ("user@somewherelese.com","user@anothersomewhereelse.com")
$obj | Add-Member -Type NoteProperty -Name "AADCity|String" -Value "Sydney" 
$obj | Add-Member -Type NoteProperty -Name "AADDistinguishedName|String" -Value "CN=Azure User test,DC=islamnkhattaboutlook,DC=onmicrosoft,DC=com" 
$obj | Add-Member -Type NoteProperty -Name "AADAccountName|String" -Value "azure.user1" 
$obj | Add-Member -Type NoteProperty -Name "AADADFSClaimToken|String" -Value "i:05.t|adfs3|azure.user1@yourdomain.com" 
                                                      
$obj

