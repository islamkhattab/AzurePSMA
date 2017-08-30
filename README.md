# AzurePSMA
This is a custom MIM Managment agent to sync Azure AD users either Member or Guest (B2B) and send them back in SharePoint 2016 User Profiles

## Prerequisites

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

