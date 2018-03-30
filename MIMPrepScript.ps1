#### Load Modules
### Load Active Directory Module
##########################################################################
if(@(get-module | where-object {$_.Name -eq "ActiveDirectory"} ).count -eq 0) {import-module ActiveDirectory}

#### Import Feeder File
########################################################################## 
[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null 

$dialog = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$dialog.AddExtension = $true
$dialog.Filter = 'CSV file (*.csv)|*.csv|All Files|*.*'
$dialog.Multiselect = $false
$dialog.FilterIndex = 0
$dialog.InitialDirectory = "$HOME\Documents"
$dialog.RestoreDirectory = $true
$dialog.ShowReadOnly = $true
$dialog.ReadOnlyChecked = $false
$dialog.Title = 'Select Pre Req CSV file'
$result = $dialog.ShowDialog()
 
	if ($result -ne 'OK')
		{
			return
		}
 
 
$accts = Import-Csv $dialog.FileName

##Functions Prompt for input
function Prompt-ForInput

	{
		Param($message)
		$success = "n"
		#while($success -ne "" -and $success.ToUpper() -ne "YES")
        while($success -ne “” -and $success.ToLower() -ne “1”)
		{
			$val = Read-Host $message
			##$success = Read-Host "You entered: $val. Is this correct? Enter Yes or No"
            $success = Read-Host “You entered: $val. Is this correct? Enter the #1 for Yes or the # 2 for No”

		}
		return $val
	}

#### Questios that define configuration
### Questions
##########################################################################
	$OrganizationalUnits = Prompt-ForInput "Do You need OU's Created Type 'Yes' or 'No'"
	$SecurityGroups = Prompt-ForInput "Do you need the Synchronization Service Security Groups Installed Type 'Yes' or 'No'"
	$ServiceAccounts = Prompt-ForInput "Do you need Service Accounts Created Type 'Yes' or 'No'"
    if($ServiceAccounts.ToUpper() -eq "YES")
        {
            $SSPRConfiguration = Prompt-ForInput "Will you be Installing SSPR Features Type 'Yes' or 'No'"
            $PAMConfiguration = Prompt-ForInput "Will be be installing the PAM Features Type 'Yes' or 'No'"
        }
    If($PAMConfiguration.ToUpper() -eq "YES")
        {
            $SetRegistry = Prompt-ForInput "Do You set Registry for SID History Migration Type 'Yes' or 'No'"
        }
    if($OrganizationalUnits.ToUpper() -eq "NO" -and $ServiceAccounts.ToUpper() -eq "NO" -and $SecurityGroups.ToUpper() -eq "NO")
        {
            Exit
        }
    

### Variables
##########################################################################
## DOMAINVAR Gets reference to Domain Object to be referenced when needed as opposed to looking up each time.
 
$DomainVAR = Get-ADDomain
$Domain = $DomainVAR.NetBIOSName
$DomainDN = $DomainVAR.DistinguishedName
$DomainDNSR = $DomainVAR.DNSRoot
 
##Set Variables based on accts CSV
 
foreach($acct in $accts)
 
	{ 

		if($acct.variable -eq "MIMService")
            {
                $MIMService = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMSPPool")
            {
                $MIMSPPool = $acct.SamAccountName
            }
		elseif($acct.variable -eq "ADMA")
            {
                $ADMA = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMSync")
            {
                $MIMSSync = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMPWDRST")
            {
                $MIMPWDRST = $acct.SamAccountName
            }
        elseif($acct.variable -eq "MIMPWDREG")
            {
                $MIMPWDREG = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMAdmin")
            {
                $MIMAdmin = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMMA")
            {
                $MIMMA = $acct.SamAccountName
            }
        elseif($acct.variable -eq "MIMSQL")
            {
               $MIMSQLSVC = $acct.SamAccountName
            }
		elseif($acct.variable -eq "MIMServiceSVR")
            {
                $MIMServiceSVR = $acct.Value
            }
		elseif($acct.variable -eq "MIMPortalSVR")
            {
                $MIMPortalSVR = $acct.Value
            }
        elseif($acct.variable -eq "PWDRegSVR")
            {
                $PWDREGSite = $acct.DisplayName
                $PWDRegSVR = $acct.Value
                $PWDRegIP = $acct.IP
            }
        elseif($acct.variable -eq "PWDResetSVR")
            {
                $PWDResetSite = $acct.DisplayName
                $PWDResetSVR = $acct.Value
	            $PWDResetIP = $acct.IP
            }
		elseif($acct.variable -eq "MIMSyncSVR")
            {
                $SyncSVR = $acct.Value
            }
        elseif($acct.value -eq "BaseMIMDN")
            {
                $BASEMIMOU = $acct.DisplayName
                $BaseMIMDN = "OU="+$BASEMIMOU+","+$DomainDN
            }
        elseif($acct.value -eq "BaseServiceDN")
            {
                $BaseServiceOU = $acct.DisplayName
                $BaseServiceDN = "OU="+$BaseServiceOU+","+$DomainDN
            }
        elseif($acct.variable -eq "BaseUserDN")
            {
                $MIMUsersOU = $acct.DisplayName
                $MIMUsersDN = "OU="+$MIMUsersOU+","+$BaseMIMDN
            }
        elseif($acct.variable -eq "BaseGroupDN")
            {
                $MIMGroupsOU = $acct.DisplayName
                $MIMGroupsDN = "OU="+$MIMGroupsOU+","+$BaseMIMDN
            }
        elseif($acct.variable -eq "MIMSQLSVR")
            {
                $SQLSVR = $acct.DisplayName
            }         
        elseif($acct.value -eq "CORP")
            {
                $CorpDCIP = $acct.ip
                $CorpDC = $acct.DisplayName
            }
        elseif($acct.value -eq "PRIV")
            {
                $PrivDCIP = $acct.ip
                $PrivDC = $acct.DisplayName
            }


}	


#### Build Functions
##########################################################################
function Create-OUs
	{
        New-ADOrganizationalUnit -Name $BASEMIMOU -Path $DomainDN
        New-ADOrganizationalUnit -Name $BaseServiceOU -Path $DomainDN
        New-ADOrganizationalUnit -Name $MIMUserSOU -Path $BASEMIMDN
        New-ADOrganizationalUnit -Name $MIMGroupsOU -Path $BASEMIMDN


    }


		
function Create-ServiceAccountsBasic
	{
		foreach($acct in $accts)
        {
		    if($acct.Type -eq "Service Account Basic")
			    {
				    $sam = $acct.SamAccountName
				    $existingUser = Get-ADuser -Filter {SamAccountName -eq $sam}

					    if($existingUser -ne $null)
						    {
							    Write-Host "$($acct.SamAccountName) Already exists. Skipping account creation"
							    continue
						    }
				    $UserPrincipalName = $acct.SamAccountName + "@" + $domain
				    New-ADUser -SamAccountName $acct.SamAccountName -UserPrincipalName $UserPrincipalName  -Name $acct.DisplayName -DisplayName $acct.DisplayName -Path $BaseServiceDN -AccountPassword (ConvertTo-SecureString "Password@123" -AsPlainText -force) -Enabled $True -ChangePasswordAtLogon $True -PassThru  | Out-Null
			    }
        }
    }

function Create-ServiceAccountsSSPR
    {
        foreach($acct in $accts)
        {
            if($acct.Type -eq "Service Account SSPR")
                {
                    $sam = $acct.SamAccountName
				    $existingUser = Get-ADuser -Filter {SamAccountName -eq $sam}

					    if($existingUser -ne $null)
						    {
							    Write-Host "$($acct.SamAccountName) Already exists. Skipping account creation"
							    continue
						    }
				    $UserPrincipalName = $acct.SamAccountName + "@" + $domain
				    New-ADUser -SamAccountName $acct.SamAccountName -UserPrincipalName $UserPrincipalName  -Name $acct.DisplayName -DisplayName $acct.DisplayName -Path $BaseServiceDN -AccountPassword (ConvertTo-SecureString "Password@123" -AsPlainText -force) -Enabled $True -ChangePasswordAtLogon $True -PassThru  | Out-Null
                }
        }
    }

function Create-ServiceAccountsPAM
    {
        foreach($acct in $accts)
        {
            if($acct.Type -eq "Service Account PAM")
                {
                    $sam = $acct.SamAccountName
				    $existingUser = Get-ADuser -Filter {SamAccountName -eq $sam}

					    if($existingUser -ne $null)
						    {
							    Write-Host "$($acct.SamAccountName) Already exists. Skipping account creation"
							    continue
						    }
				    $UserPrincipalName = $acct.SamAccountName + "@" + $domain
				    New-ADUser -SamAccountName $acct.SamAccountName -UserPrincipalName $UserPrincipalName  -Name $acct.DisplayName -DisplayName $acct.DisplayName -Path $BaseServiceDN -AccountPassword (ConvertTo-SecureString "Password@123" -AsPlainText -force) -Enabled $True -ChangePasswordAtLogon $True -PassThru  | Out-Null
                }
        }
    }
            
	
function Create-SecurityGroups
	{
		#Param($CSGacct)
        foreach($acct in $accts)
        {
		    if($acct.Type -eq "Security Group")
			    {
				    $sam = $acct.SamAccountName
		#		    $existingUser = Get-ADGroup -Filter {SamAccountName -eq $sam}

		#		    if($existingUser -ne $null)
		#			    {
		#				    Write-Host "$($acct.SamAccountName) Already exists. Skipping account creation"
		#				    continue
		#			    }
				    ##New-ADGroup -SamAccountName $acct.SamAccountName -UserPrincipalName $UserPrincipalName  -Name $acct.DisplayName -DisplayName $acct.DisplayName -Path $BaseServiceDN -GroupScope Global  -GroupCategory Security 
				    New-ADGroup -Path $BaseServiceDN -Name $acct.DisplayName -GroupScope Global  -GroupCategory Security 
			    }
        }
	}

function Create-DNS-Records
	{
		foreach($acct in $accts)
            {

                if($acct.Type -eq "DNSRecord")
			        {
                    $DomainVAR = Get-ADDomain
                    $Domain = $DomainVAR.Name 
                    $DomainDN = $DomainVAR.DistinguishedName
                    $DomainDNSR = $DomainVAR.DNSRoot
                    $DNSName = $acct.DisplayName
                    $DNSServer = $PrivDC
                    $Zone = $DomainDNSR
                    $DNSRecord = 
                    $DNStype = "A"
                    $DNSRecordIP = $acct.IP
                    $Class = 1
                    $ttl = 3600
				
                    Add-DnsServerResourceRecordA -Name $DNSName -ZoneName $Zone -AllowUpdateAny -IPv4Address $DNSRecordIP -TimeToLive 01:00:00
                    }

			}
	}

function Set-Registry
    {
        New-ItemProperty –Path HKLM:SYSTEM\CurrentControlSet\Control\Lsa –Name TcpipClientSupport –PropertyType DWORD –Value 1
    }

function Set-Permissionsbasic
    {
        ### Delegate Permissions at the Root of the Domain
	    # Delegate Replicating Directory Changes
	    dsacls "$DomainDN" /G "$Domain\$($ADMA):CA;Replicating Directory Changes";
	    # Delegate access to the MIM Web Service in order to execute PowerShell scripts against AD directly
	    # Delegate Read/Write for userAccountControl
	    dsacls "$DomainDN" /G "$Domain\$($MIMService):RPWP;userAccountControl;user" /I:S
	    dsacls "$DomainDN" /G "$Domain\$($MIMService):RPWP;member;group" /I:S

	    ### Delegate Permissions fot OU's that will contain MIM Managed Objects
	    ##Delegat Permissions to the MIM Managed Users OU
	    # Delegate Create/Delete Users to the container that will manage Users
	    dsacls "$MIMUsersDN" /G "$Domain\$($ADMA):CCDC;user"
	    # Delegate Read/Write All Properties
	    dsacls "$MIMUsersDN" /G "$Domain\$($ADMA):RPWP;"
	    dsacls "$MIMUsersDN" /G "$Domain\$($ADMA):RPWP;userAccountControl;user" /I:S

	    ##Delegate Permissions to the MIM Managed Groups OU
	    # Delegate Create, Delete, and Manage Groups to the Container to allow the ADMA Service Account that will manage Groups
	    dsacls "$MIMGroupsDN" /G "$Domain\$($ADMA):CCDC;group"
	    # Delegate Modify Memberships of Groups to the Container to allow the ADMA Service Account that will manage Groups
	    dsacls "$MIMGroupsDN" /i:s /g "$Domain\$($ADMA):rpwp;member;group"
        
        ###Set Kerberos Delegations###

	    ##corp\ServiceAccounts Variables
	    $DomainMIMSVC = "$Domain\$MIMService"
	    $DomainMIMSPPool = "$Domain\$MIMSPPool"

	    ##MIMService/(Server MIM Service is installed on) Variables
	    $MIMServiceSPN = "$MIMService/$MIMServiceSVR"
	    $MIMServiceSPNFQDN = "$MIMServiceSPN.$DomainDNSR"
        
        ## HTTP//(Server MIM Service is installed on)
        $SPserviceSPN = "HTTP/$MIMServiceSVR"
        $SPserviceSPNFQDN = "$SPserviceSPN.$DomainDNSR"

        ## Password Registration Variables
        $PasswordRegDNS = "$PWDREGSite.$DomainDNSR"
        $PasswordRegDNSSPN = "HTTP/$PasswordRegDNS"
        $PWDRegSVRSPN = $PWDRegSVR+"$"
        $PRDRegSVRDOM = "$Domain\$PWDRegSVRSPN"

        ## Password Reset Variables
        $PasswordResetDNS = "$PWDResetSite.$DomainDNSR"
        $PasswordResetDNSSPN = "HTTP/$PasswordResetDNS"
        $PWDResetSVRSPN = $PWDResetSVR+"$"
        $PRDResetSVRDOM = "$Domain\$PWDResetSVRSPN"
        
        ## SQL Server Variables


	    #### Set SPN's
	    #### https://technet.microsoft.com/en-us/library/jj134299(v=ws.10).aspx
        ### Set the SPNs for CORP\SPService
        ##Setspn.exe  –S HTTP/fim1 CORP\SPService
        Setspn.exe -S $SPserviceSPN $DomainMIMSPPool

        ##Setspn.exe  –S HTTP/fim1.corp.contoso.com corp\SPService
        ##Setspn –S HTTP/FIM1.corp.contoso.com corp\SPService
        Setspn.exe -S $SPserviceSPNFQDN $DomainMIMSPPool
        
        ### Set the SPNs for CORP\FIMService
        ##Setspn.exe  –S FIMService/fim1 CORP\FIMService
        setspn.exe -S $MIMServiceSPN $DomainMIMSVC

        ##Setspn.exe  –S FIMService/fim1.corp.contoso.com CORP\FIMService
        setspn.exe -S $MIMServiceSPNFQDN $DomainMIMSVC

        ### Set the SPNs for CORP\SQLDatabase
        ## Get with your SQL ADMIN to verify this has been completed
        ##Setspn –S MSSQLsvc/app1.corp.contoso.com:1433 corp\sqldatabase
        ##Setspn –S MSSQLsvc/app1:1433 corp\sqldatabase

        ### Set the SPNs for CORP\FIM2$
        #$Setspn.exe –S HTTP/Passwordreset.corp.contoso.com CORP\FIM2$
        setspn.exe -S $PasswordRegDNSSPN $PRDRegSVRDOM
        #$Setspn.exe –S HTTP/Passwordregistration.corp.contoso.com CORP\FIM2$
        setspn.exe -S $PasswordResetDNSSPN $PRDResetSVRDOM
    }
  
    
#### Scripts
##########################################################################
 
##  Create Organizational Units  
	if($OrganizationalUnits.ToUpper() -eq "YES")
		{
			Create-OUs 	
		}
	
##  Create Service Accounts 
	if($ServiceAccounts.ToUpper() -eq "YES")
		{
			if($acct.Type -eq "Service Account Basic")
				{
				   Create-ServiceAccountsBasic 
				}
            if($SSPRConfiguration -eq "YES")
                {
                    Create-ServiceAccountsSSPR
                }
            if($PAMConfiguration -eq "YES")
                {
                    Create-ServiceAccountsPAM
                }
		} 
	
##  Create Security Groups 
	if($SecurityGroups.ToUpper() -eq "YES")
		{
			Create-SecurityGroups
				
		}

	
## Set up PAM
    if($PAMConfiguration.ToUpper() -eq "YES")
        {
            If($SetRegistry -eq "YES")
            {
                Set-Registry
            }
            
        }
## Set Permissions for Service Accounts
    if($ServiceAccounts.ToUpper() -eq "YES")
        {
            Set-Permissionsbasic
            if($SSPRConfiguration.ToUpper() -eq "YES")
                {
                    Create-DNS-Records
                }
        }

