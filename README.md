# Azure AD PowerShell Managment Agent
This is a custom MIM Managment agent to import Azure AD users using Msol module,users could be either Member or Guest (B2B), then send them back in SharePoint 2016 User Profiles

This agent is tested on the following scenario:
* SharePoint 2016 On-Prem Farm (Aug 2017 PU) - With User Profile Service Configured and Syncronization Service Configured using MIM 2016
* Azure AD with Guest (B2B) users added and immutible id set

> Import PowerShell File Configurations
* $usersType variable - 'All' for all user types, 'Member' for Azure AD Users and 'Guest' for B2B users
* $restrictImmutableId - Imports only users with ImmutableId property set
* $DebugFilePath - Outputs powershell messages

> Import PowerShell File Changes
* You can update the properties and mappings to fit your scenario
* Any changes in the import.ps1 should reflect in the schema.ps1 file as well

> User photos is still not implemented

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
    
    ![picture alt](https://2fg1qq.bn1303.livefilestore.com/y4m96vo6cOs6GA02WpDLT6C5oQROmpd1A9YVR9t3_BY9XEne_EU4TeA1SmMRmEFE-GMI2im0vvfeXOTe8yihT_faua7YMTr2GVcqB9-qIpEVw9ohWzH22UNW5YJ_0BG9_9Au_IBDljPc4K3f6NJxsIA3IWQyRoGWx4RlTRM_X9T5R5lMxKVNeuxfQo-ekNzsh5i6nnaKh-ubGkCBmDSMEY9xg?width=666&height=501&cropmode=none)
    
    * For the schema script add your schema.ps1 file full path and the azure ad amdin account, the password will not be used from this screen as well use the stored cred file instead
    
    ![picture alt](https://2fhrkg.bn1303.livefilestore.com/y4mSYglgr6LSm-p8RTCpWiRTAJOAOn92WLMD8cA-o_mnujpN6tmKwPnfw2FrP9cJp5BhmIVFPM3K2W9uM84PVGTqntw-AcXu5bdbxRofxSGY9sWrSFXcyuduKxcwmF-bTQOrwwEDYb889GDssg1OiXSdC3cJk78elzO0r8I5x0smiOthafOD-qDbx-oJiL4t7-CnAIMMbCvHzDbjnots_gyFA?width=664&height=498&cropmode=none)
    
    * Paths to the Import, Export and Password scripts. Note: the Export and Password PS1 scripts files exist but are empty.
    
    ![picture alt](https://2fjqhq.bn1303.livefilestore.com/y4mX5WzcssydVwq_636oE2P0muKg_GffGb3gs65m-iwZcXCVKeTmW_6FNiSUP9Lb4GQbI22p7HFiIGvvtj4NSAjMGUBPse9D3J0uN1JBjZW19c3GfPWDceeZowtgkI5inzWdQ6NoS-Lbd0fcKersJhR7adXscDvIzR0ybWOdm3IzcIj24QkFFJqsSs1F90vAQUQMPzubfaf-iYXljqqy77TKQ?width=666&height=501&cropmode=none)
    
    * Object Type as configured in the Schema.ps1 file.
    
    ![picture alt](https://poryhq.bn1303.livefilestore.com/y4muXdmruxWUIpS0yg9dmM-IhiOJeNjj_Qev1QKQfBC3Suy1hatoCAygRSmM_sYn28O1fdPRJSrbrEaaNOUPYMGviDT-Z28g4c_rSgdir0HkHdiNLMCzs4Al2qsjSu-XCGhXEKlpE83aQ9B1X4ZNHrJVLKQBtL6PyGhEqL6jDTMMxMrzJWh1aSfqrAUyuTRHJYO8eJ9tBSjo0SEKb8Acr_ymw?width=666&height=500&cropmode=none)
    
    * Attributes as configured in the Schema.ps1 file
    
    ![picture alt](https://pos9qa.bn1303.livefilestore.com/y4mgwV_9m2OG6KJPltd1x7Jx9pxjXkA3fT2ykpseEQXWfwFkL7zcVYoPhHPyp9qGHxPFxvJjua4svc_qp_TJpvdYRnekj4IR6M6FmAdICZ97Zs-ezXssbtZWW-WPRNAt8vAGBvwAtB-RnIE8PTAV3KXHwxcZIuCj4w8z-YU8B3wGvdYiL-1UyU1QJnFeLv4SliuHOHJasbh89KdmF-T_XEWHg?width=665&height=499&cropmode=none)
    
    * Anchor as per the Schema.ps1 file.
    
    ![picture alt](https://poqina.bn1303.livefilestore.com/y4mNNLELUcKbp7E0yh1FlGC5--ZukWY2EJMyOxVRXOpjLs3HO6F0wWWLQgVcmWdJE3OkRHJ2QNgvmuBenWgazBVnzb2NbwkSbp-mjgbLf5k9OM8iNQEewjSyKuCS_Fy9EfuhTBKHOkKOtqhG3WISGqOcBK1iUcs6iRW_j9LsA9aSm3lzRGCeVD6t0U_-5cxWmekDB9WVJIW3L3mrgmuc_VP_Q?width=666&height=500&cropmode=none)
    
    * Project the output to person object
    
    ![picture alt](https://2fimpg.bn1303.livefilestore.com/y4mDZuSPcWx-TRFfSj2n6CExUv05X8PjBMwq7LG3Ou7O75dXxkLgS2J-Iy_rLZZY5SD9Ati2j6oEScmoazOhGwhqJwnMJOis2f3ZerkhI6SiZmQ_-O1zJDaU3AqqbwbnnvVhKdxmEbOCcSl0ZtwqpkOuOar-Ix4rlbau9Fvr9fOt-FKM2jWghTYp7N7YGvPqbj1D3fKJY5OKfrkllGW1keO8Q?width=668&height=498&cropmode=none)
    
    * Configure Attribute flow
    
    ![picture alt](https://2fjxmq.bn1303.livefilestore.com/y4mnBShVEUyygGPrJ75sr-oOwGI71FjrYITCXdMPusgSQxJIG-ufJIjeeFStnd5Kb56Jbh1oUIK7lVmnooufqaJJQfq3Lco5qrNcON2C8L9nJ1uU8BQQLmNsw57p0afyVjaUm-SKBMKcxO1fbfkPLa-Fp597RUbP3scaw96LfDazfE7JazJYnun8dPbHtSipKBNMs7bXSvOYeTmRIiHfC_6lA?width=957&height=705&cropmode=none)
    
 * Add two Run Profiles to your Managment Agent [FullImport - FullSync], You can use any configurations as you needs this is just for the sake of the demo
 
 ![picture alt](https://posobg.bn1303.livefilestore.com/y4mq5HKQef_XRaRMbnKA1KrhxEXFY0R-Eq4CNR1ktV9UBWZh6U90x9y3Hsq8q7BAtu8z9O0AqbxqVGrznr6i4V46X_Lib8Yc6d_rga4DTiPTfARvKYd7nb3X5Vnrf84TqE0iXDVnN1iQpkP2buEG0KpiVvzQLzrG8f2ZmcFlmVuOUfGXSZsiulKTLdc8sGSbvfJP0n7kpxG6iWKPE8n7PL-kQ?width=638&height=491&cropmode=none)
 
 
 * Run AzureADUsers MA Full Import Profile
 * Run AzureADUsers MA Full Sync Profile
 * Run SPMA MA Full Import Profile
 * Run SPMA MA Full Sync Profile
 * Run SPMA MA Export Profile
 
 ## Verify the results
 
 * After a successfull AzureADUsers MA Full import run, you should find additions according to the users type found on Azure AD
 
 ![picture alt](https://poqpew.bn1303.livefilestore.com/y4mZUaVmay8Aldu6iTLFaaZmsOtwAU0ZBcd5LnKOBKpQC6Ory-imSdUWXwhzat3IEy2rbnY6Ho4z0U_5HRm1-NLc_OEYxMS3I1llZvEcNxyKaw1cv7V3cbI8qHbNzP_8RQ-RVopOjcrqxHV-TQ3BbVqBvKw7t8fRw7HkZlFjeIx-f7Xl0e4iCs9pUqPm846sGVB5CT8FeBExEHz163e4RhMeA?width=590&height=397&cropmode=none)
 
 * An example of user properties imported
 
 ![picture alt](https://pote7w.bn1303.livefilestore.com/y4ma6ZJ8WwXdXCsa4zGbabPvQEza7SKM56u6Xc7pzs1Q9hRuwY_PDyw1eKyhaXn7fhw-ou4s2M9o1ugQQVLmRnOBiqEuXH71wN2k6PQb86WrcTzhbQyXfO1hPFpibCLSqKRnJIqWE5rPC8XSXvr1A8JzLR7-SCGb0CZiTlhSKZqVKNR0TuJS04xS14S8HEDTTiR5uSS_jkCXz4AzPe636Fdbg?width=908&height=621&cropmode=none)
 
 * After AzureADUser MA Full Sync
 
 ![picture alt](https://porfza.bn1303.livefilestore.com/y4mkQ7FJjqYK7o3T4BWfBErSW3PxOIRxRWSMMAJc_Bc7f4y0ZA_Zi7LxD3pBlXmGx11JGsVhxA0otox8PW-8tfeKbH_BDagkYfQMPdE_QAsmFjiJPypNn6nDiTM2ZcS-cdxrQ-AF91FZvss5yVQqrLzvFK58cDByeCwzTxiFnWskI1ypiY1e_j7OGjaobLwKnqwEtHq2FbF1DGNCHEIbfL7CQ?width=583&height=492&cropmode=none)
 
 * Azure User Profile
 
 ![picture alt](https://porkjw.bn1303.livefilestore.com/y4mshvrTcQRjAua322v9nMKj-cSaaFxKUDWVZtMwA1QwApJ_WEWl5gqiraeQooL4d2ioxaFtH13pF21wfzhfc9oSKo-Mf85sAtZtSvgvDtb4KSJrgWKxfHF5EahgpXUL7oAPS1oe3xePdlea0dZXjieJdecXzQGz5qx9edFRoAEMrFOK5d5sWGGXJTSnLps3vVzBcR_1LnzZYYCGUfNE67ycg?width=879&height=699&cropmode=none)
 
 * SharePoint 2016 on-prem User Profile
 
 ![picture alt](https://potlaw.bn1303.livefilestore.com/y4m96QAR2lIypuLXILTfBWjRkE_RY6pNujEhOs3MnwPBkjWDJj7tVrXy4ssZMgup2gV7ReB731O8fwgiDdNi2O6R4Q3JnJZ6AowwPak9dqMeuz5qdVADkJzwFYlVI8zOQPA3TdxEM6BEWvNXWn3wUD8_egyNrfbvjXYSuY8K86zDUKK6QpfaZPROSyXNvt5_trMO1mPLs6aJNFKUIexlAsfQg?width=876&height=654&cropmode=none)
 
 
