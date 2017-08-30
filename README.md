# Azure AD PowerShell Managment Agent
This is a custom MIM Managment agent to import Azure AD users using Msol module,users could be either Member or Guest (B2B), then send them back in SharePoint 2016 User Profiles

## Prerequisites

### SharePoint Managment Agent installed and configured

* [Step by Step: Installation of Microsoft Identity Manager for SharePoint 2016 User profile Service](http://krossfarm.com/?p=145)
* [Step by Step: Configuration of Microsoft Identity Manager for SharePoint 2016 User profile Service](http://krossfarm.com/?p=148)

### Enable Msol on MIM Server
* Install required software
These steps are required once on your computer, not every time you connect. However, you'll likely need to install newer versions of the software periodically.
1. Install the 64-bit version of the Microsoft Online Services Sign-in Assistant: [Microsoft Online Services Sign-in Assistant for IT Professionals RTW](https://go.microsoft.com/fwlink/p/?LinkId=286152).
2. Install the 64-bit version of the Windows Azure Active Directory Module for Windows PowerShell with these steps:
    1.  Open the [Azure Active Directory Connection](http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185) web page.
    2.  In Files in Download at the bottom of the page, click Download for the AdministrationConfig-V1.1.166.0-GA.msi file, and then install it.

### Store Azure AD Global Admin in a secure file 
* Get latest PowerShell script file from [PowerShell-Stored-Credentials](https://github.com/cunninghamp/PowerShell-Stored-Credentials)
* For full steps follow the following link (https://practical365.com/blog/saving-credentials-for-office-365-powershell-scripts-and-scheduled-tasks/)
* Save the generated file i.e. azure.admin@yourdomain.onmicrosoft.com.cred

### Install The Granfeldt PowerShell Management Agent (MA)
* [Full GitHub Repo](https://github.com/sorengranfeldt/psma)
* [Installation Steps](https://github.com/sorengranfeldt/psma/wiki/Installing)  

## AzureADPSMA Installation 

> Before Begining, Please first read [How to create an AzureAD Microsoft Identity Manager Management Agent using the MS GraphAPI and Differential Queries](https://blog.darrenjrobinson.com/how-to-create-an-azuread-microsoft-identity-manager-management-agent-using-the-ms-graphapi-and-differential-queries/), to get overview of the idea we are intoducing here as it is based on the same idea

* Create a folder 'AzurePSADMA' for example that will contain mainly the following files

File Name | Description
------------- | -------------
Import.ps1 | The main import sequence script
azure.admin@yourdomain.onmicrosoft.com.cred  | Azure Admin Cred file
Password.ps1  | Password PowerShell File, You must have a Password.ps1 file. Even though we’re not doing password management on this MA, the PS MA configuration requires a file for this field. The .ps1 doesn’t need to have any logic/script inside it. It just needs to be present
Export.ps1  | Export PowerShell File, You must have a Export.ps1 file. Even though we’re not doing Export on this MA, the PS MA configuration requires a file for this field. The .ps1 doesn’t need to have any logic/script inside it. It just needs to be present
Functions-PSStoredCredentials.ps1 | Creditial Manager
Schema.ps1 | The schema of the AzureADUser that will be imported to MIM

* Management Agent Configuration

    * With the Granfeldt PowerShell Management Agent installed on your FIM/MIM Synchronisation Server, in the Synchronisation Server Manager select Create Management Agent and choose "PowerShell" from the list of Management Agents to create.
    As this example is for Users, I’ve named my MA accordingly "AzureADUsers"
    ![picture alt](https://i1.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-1.PNG?resize=525%2C392&ssl=1)
    
    * For the schema script add your schema.ps1 file full path and the azure ad amdin account, the password will not be used from this screen as well use the stored cred file instead
    ![picture alt](https://i0.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-2.PNG?resize=525%2C394&ssl=1)
    
    * Paths to the Import, Export and Password scripts. Note: the Export and Password PS1 scripts files exist but are empty.
    ![picture alt](https://i1.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-3.PNG?resize=525%2C393&ssl=1)
    
    * Object Type as configured in the Schema.ps1 file.
    ![picture alt](https://i2.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-4.PNG?resize=525%2C392&ssl=1)
    
    * Attributes as configured in the Schema.ps1 file.
    ![picture alt](https://i2.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-5.PNG?resize=525%2C393&ssl=1)
    
    * Anchor as per the Schema.ps1 file.
    ![picture alt](https://i0.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-6.PNG?resize=525%2C392&ssl=1)
    
    * Project the output to person object
    ![picture alt](https://i0.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-6.PNG?resize=525%2C392&ssl=1)
    
    * Configure Attribute flow 
    ![picture alt](https://i0.wp.com/dl.dropboxusercontent.com/u/76015/BlogImages/AzureADMA/AzureADMA-6.PNG?resize=525%2C392&ssl=1)
    
 * Add two Run Profiles to your Managment Agent [FullImport - FullSync], You can use any configurations as you needs this is just for the sake of the demo
 * Run AzureADUsers MA Full Import Profile
 * Run AzureADUsers MA Full Sync Profile
 * Run SPMA MA Full Import Profile
 * Run SPMA MA Full Sync Profile
 * Run SPMA MA Export Profile
 
 ## Verify the results
