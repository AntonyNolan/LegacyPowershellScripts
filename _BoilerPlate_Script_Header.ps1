<#
.Synopsis
    ADACLScan.ps1
     
    AUTHOR: Robin Granberg (robin.granberg@microsoft.com)
    
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED 
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR 
    FITNESS FOR A PARTICULAR PURPOSE.
    
    This sample is not supported under any Microsoft standard support program or service. 
    The script is provided AS IS without warranty of any kind. Microsoft further disclaims all
    implied warranties including, without limitation, any implied warranties of merchantability
    or of fitness for a particular purpose. The entire risk arising out of the use or performance
    of the sample and documentation remains with you. In no event shall Microsoft, its authors,
    or anyone else involved in the creation, production, or delivery of the script be liable for 
    any damages whatsoever (including, without limitation, damages for loss of business profits, 
    business interruption, loss of business information, or other pecuniary loss) arising out of 
    the use of or inability to use the sample or documentation, even if Microsoft has been advised 
    of the possibility of such damages.
.DESCRIPTION
    A tool with GUI or command linte used to create reports of access control lists (DACLs) and system access control lists (SACLs) in Active Directory.
    See https://github.com/canix1/ADACLScanner
.EXAMPLE
    .\ADACLScan.ps1
    Start in GUI mode.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM"
    Create a CSV file with the permissions of the object CORP.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Output HTML
    Create a HTML file with the permissions of the object CORP.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Output EXCEL
    Create a Excel file with the permissions of the object CORP.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Output HTML -Show
    Opens the HTML (HTA) file with the permissions of the object CORP.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Output HTML -Show -SDDate
    Opens the HTML (HTA) file with the permissions of the object CORP including the modified date of the security descriptor.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -OutputFolder C:\Temp
    Create a CSV file in the folder C:\Temp, with the permissions of the object CORP.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Scope subtree
    Create a CSV file with the permissions of the object CORP and all child objects of type OrganizationalUnit.
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Scope subtree -EffectiveRightsPrincipal joe"
    Create a CSV file with the effective permissions of all the objects in the path for the user "joe".
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Scope subtree -Filter "(objectClass=user)"
    Create a CSV file with the permissions of all the objects in the path and below that matches the filter (objectClass=user).
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Scope subtree -Filter "(objectClass=user)" -Server DC1
    Targeted search against server "DC1" that will create a CSV file with the permissions of all the objects in the path and below that matches the filter (objectClass=user).
.EXAMPLE
    .\ADACLScan.ps1 -Base "OU=CORP,DC=CONTOS,DC=COM" -Scope subtree -Filter "(objectClass=user)" -Server DC1 -Port 389
    Targeted search against server "DC1" on port 389 that will create a CSV file with the permissions of all the objects in the path and below that matches the filter (objectClass=user).
.OUTPUTS
    The output is an CSV,HTML or EXCEL report.
.LINK
    https://github.com/canix1/ADACLScanner