Import Active Directory Module
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

#MIM User Accounts
#Monitoring User Account
$UserMIMMonitor = "MIMMonitor"
$UserMIMComponent = "MIMComponent"
#MIM Sync
$UserMIMSync = "MIMSync"
$UserMIMService = "MIMService"
$UserMIMSharePoint = "MIMSharePoint"
$UserMIMSqlServer = "MIMSqlServer"
$UserMIMBackupAdmin = "MIMBackupAdmin"

##### MIM Service Accounts #######
#Management Agent Administrator Account
$UserMIMMA = "MIMMA"
$UserMIMAdmin = "MIMAdmin"
#SharePoint App Pool Administrator
$UserMIMSPPool =  "MIMSPPool"
$UserMIMSecAdmin= "MIMSecAdmin"
#Password Registration Portal Admin
$UserMIMPWDREG = "MIMPWDREG"
$UserMIMPWDRST = "MIMPWDRST"

#MIM OU Taxonomy
$RootDN  = (Get-ADRootDSE).defaultnamingcontext
$MIMOUObject = "OU=MIM Objects," + $RootDN
$RootDomain = '@' + (Get-ADDomain).dnsroot
$Domain = (Get-ADDomain).dnsroot
#Manually Define Default OU
$UserOU = "OU=Users,OU=MIM Objects,DC=spirit,DC=rov"
$SvcOU  = "OU=Service Accounts,OU=MIM Objects,DC=spirit,DC=rov"
$GrpOU = "OU=Groups,OU=MIM Objects,DC=spirit,DC=rov"

try {
    If((Read-host -Prompt "Would you like to create default MIM OU structure. Yes or No") -eq "Yes") {
        Write-Host "Creating OU Structure for MIM Objects in Root......." -ForegroundColor Green
        New-ADOrganizationalUnit -Name "MIM Objects" -Path $RootDN
        New-ADOrganizationalUnit -Name "Users"-Path $MIMOUObject
        New-ADOrganizationalUnit -Name "Groups"-Path $MIMOUObject
        New-ADOrganizationalUnit -Name "Service Accounts" -Path $MIMOUObject 
    } 
       }Catch {
                Write-Host "Error: An attempt was made to add an object to the directory with a name that is already in use. Not created" -ForegroundColor Green
    }

#Mim User Account Objects
try {
Write-Host "Creating User $UserMIMMonitor" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMMonitor -Name $UserMIMMonitor -DisplayName $UserMIMMonitor -GivenName $UserMIMMonitor `
-EmailAddress ($UserMIMMonitor + $RootDomain) -UserPrincipalName ($UserMIMMonitor + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMMonitor Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMMonitor. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMComponent" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMComponent -Name $UserMIMComponent -DisplayName $UserMIMComponent -GivenName $UserMIMComponent `
-EmailAddress ($UserMIMComponent + $RootDomain) -UserPrincipalName ($UserMIMComponent + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMComponent Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMComponent. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMSync" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMSync -Name $UserMIMSync -DisplayName $UserMIMSync -GivenName $UserMIMSync `
-EmailAddress ($UserMIMSync + $RootDomain) -UserPrincipalName ($UserMIMSync + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMSync Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMSync. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMSharePoint" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMSharePoint -Name $UserMIMSharePoint -DisplayName $UserMIMSharePoint -GivenName $UserMIMSharePoint `
-EmailAddress ($UserMIMSharePoint + $RootDomain) -UserPrincipalName ($UserMIMSharePoint + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMSharePoint Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMSharePoint. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMSqlServer" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMSqlServer -Name $UserMIMSqlServer -DisplayName $UserMIMSqlServer -GivenName $UserMIMSqlServer `
-EmailAddress ($UserMIMSqlServer + $RootDomain) -UserPrincipalName ($UserMIMSqlServer + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMSqlServer Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMSqlServer. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMBackupAdmin" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMBackupAdmin -Name $UserMIMBackupAdmin -DisplayName $UserMIMBackupAdmin -GivenName $UserMIMBackupAdmin `
-EmailAddress ($UserMIMBackupAdmin + $RootDomain) -UserPrincipalName ($UserMIMBackupAdmin + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $UserOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMBackupAdmin Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMBackupAdmin. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMMonitor" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMMonitor -Name $UserMIMMonitor -DisplayName $UserMIMMonitor -GivenName $UserMIMMonitor `
-EmailAddress ($UserMIMMonitor + $RootDomain) -UserPrincipalName ($UserMIMMonitor + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMMonitor Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMMonitor. This Account likely exists" -ForegroundColor Red
}


try {
Write-Host "Creating User $UserMIMMA" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMMA -Name $UserMIMMA -DisplayName $UserMIMMA -GivenName $UserMIMMA `
-EmailAddress ($UserMIMMA + $RootDomain) -UserPrincipalName ($UserMIMMA + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMMA Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMMA. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMAdmin" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMAdmin -Name $UserMIMAdmin -DisplayName $UserMIMAdmin -GivenName $UserMIMAdmin `
-EmailAddress ($UserMIMAdmin + $RootDomain) -UserPrincipalName ($UserMIMAdmin + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMAdmin Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMAdmin. This Account likely exists" -ForegroundColor Red
}


try {
Write-Host "Creating User $UserMIMSPPool" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMSPPool -Name $UserMIMSPPool -DisplayName $UserMIMSPPool -GivenName $UserMIMSPPool `
-EmailAddress ($UserMIMSPPool + $RootDomain) -UserPrincipalName ($UserMIMSPPool + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMSPPool Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMSPPool. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMSecAdmin" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMSecAdmin -Name $UserMIMSecAdmin -DisplayName $UserMIMSecAdmin -GivenName $UserMIMSecAdmin `
-EmailAddress ($UserMIMSecAdmin + $RootDomain) -UserPrincipalName ($UserMIMSecAdmin + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMSecAdmin Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMSecAdmin. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMPWDREG" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMPWDREG -Name $UserMIMPWDREG -DisplayName $UserMIMPWDREG -GivenName $UserMIMPWDREG `
-EmailAddress ($UserMIMPWDREG + $RootDomain) -UserPrincipalName ($UserMIMPWDREG + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMPWDREG Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMPWDREG. This Account likely exists" -ForegroundColor Red
}

try {
Write-Host "Creating User $UserMIMPWDRST" -ForegroundColor Green
New-ADUser -SamAccountName $UserMIMPWDRST -Name $UserMIMPWDRST -DisplayName $UserMIMPWDRST -GivenName $UserMIMPWDRST `
-EmailAddress ($UserMIMPWDRST + $RootDomain) -UserPrincipalName ($UserMIMPWDRST + $RootDomain) `
-Enabled $true -ChangePasswordAtLogon $false -Path $SvcOU -AccountPassword (Read-Host -Prompt "Please Input $UserMIMPWDRST Password" -AsSecureString)
} Catch 
        [System.Object]
{
Write-Host "Could not Create User $UserMIMPWDRST. This Account likely exists" -ForegroundColor Red
}

#AD Group Creation 
Write-Host "Creating Groups and Adding Members....."
New-ADGroup –name MIMSyncAdmins –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncAdmins -Path $GrpOU
New-ADGroup –name MIMSyncOperators –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncOperators -Path $GrpOU
New-ADGroup –name MIMSyncJoiners –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncJoiners -Path $GrpOU
New-ADGroup –name MIMSyncBrowse –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncBrowse -Path $GrpOU
New-ADGroup –name MIMSyncPasswordReset –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncPasswordReset -Path $GrpOU
#Add Members to AD Groups
Add-ADGroupMember -identity MIMSyncAdmins -Members $UserMIMAdmin
Add-ADGroupmember -identity MIMSyncAdmins -Members $UserMIMService

#Setup MIM OU Permission Delegation Permissions at the Root of the Domain
# Delegate Replicating Directory Changes
dsacls $SvcOU /G "$Domain\$($UserMIMMA):CA;Replicating Directory Changes";

# Delegate access to the MIM Web Service in order to execute PowerShell scripts against AD directly
# Delegate Read/Write for userAccountControl
dsacls "$SvcOU" /G "$Domain\$($MIMService):RPWP;userAccountControl;user" /I:S
dsacls "$SvcOU" /ssG "$Domain\$($MIMService):RPWP;member;group" /I:S

### Delegate Permissions for OU's that will contain MIM Managed Objects

##Delegate Permissions to the MIM Managed Users OU
# Delegate Create/Delete Users to the container that will manage Users
dsacls "$SvcOU" /G "$Domain\$($UserMIMMA):CCDC;user"

# Delegate Read/Write All Properties
dsacls "$UserOU" /G "$Domain\$($UserMIMMA):RPWP;"
dsacls "$UserOU" /G "$Domain\$($UserMIMMA):RPWP;userAccountControl;user" /I:S

##Delegate Permissions to the MIM Managed Groups OU

# Delegate Create, Delete, and Manage Groups to the Container to allow the ADMA Service Account that will manage Groups
dsacls "$GrpOU" /G "$Domain\$($UserMIMMA):CCDC;group"

# Delegate Modify Memberships of Groups to the Container to allow the ADMA Service Account that will manage Groups
dsacls "$GrpOU" /i:s /g "$Domain\$($UserMIMMA):rpwp;member;group" 
sssssss
