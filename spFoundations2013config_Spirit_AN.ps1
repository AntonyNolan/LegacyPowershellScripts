##NOTE:For all Prompts type "Yes" or "No" and for all Verification Type "1" for Yes or "2" for No.

#When copying and pasting the following script be sure to verify that all " quotes copy correctly as well as the following "STS#0" is not converted with other characters.

 

### Script Updated 15 March 2015 ###
##This first line only needs to be run if you’re not running the SharePoint 2013 Management Console.
Add-PSSnapin Microsoft.SharePoint.PowerShell -EA SilentlyContinue
## to Verify if Microsoft.Sharepoint.Powershell has been added
# Get-PSSnapin
function Prompt-ForInput
{
Param($message)
$success = "n"
while($success -ne "" -and $success.ToLower() -ne "1")
{
$val = Read-Host $message
$success = Read-Host "You entered: $val. Is this correct? Enter the #1 for Yes or the # 2 for No"
}
return $val
}
##All sections highlighted in Pink are currently not in use
##This next block of code sets your variables the script will need to build your SharePoint Site
## Below you will need to know the following information
## NetBIOS Domain name
## The account that will be used run the actual website
## An account that will be used as a Farm Administrator
$Domain = $(Get-ADDomain).Name
$Prep = Prompt-ForInput "Was the MIMPrep tool used to create Service Accounts Yes or No"
$MIMPrep = $Prep.ToLower()

if($MIMPrep -eq "yes")
{
#### Import Feeder File
##########################################################################
#[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
Add-Type -assemblyName "System.Windows.Forms" #use this instead of loadwithpartialname
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
#return
Exit 1 #exit is more appropriate in this case and then you can also give a non-zero return code
}
$accts = Import-Csv $dialog.FileName
$svcFIMPool = ($accts | where-object{$_.variable -eq "MIMSPPool"}).SamAccountName
if(!$svcFIMPool)
{
$svcFIMPool = Prompt-ForInput "Enter the SharePoint Application Pool Service Account"
}
$FarmAdminUser = ($accts | where-object{$_.variable -eq "MIMAdmin"}).SamAccountName
if(!$FarmAdminUser)
{
$FarmAdminUser = Prompt-ForInput "Enter the Primary Site Collection Administrator Account"
}
$Site = "http://" + $($accts | where-object{$_.variable -eq "Site" -and $_.Type -eq "MIM"}).DisplayName
if(!$Site)
{
$Site = "http://" + $(Prompt-ForInput "Enter the site Url, Note: what ever is entered here will be used when Installing the FIM Portal")
}
$SecFarmAdmin = ($accts | where-object{$_.variable -eq "MIMSecAdmin"}).SamAccountName
if(!$SecFarmAdmin)
{
$SecFarmAdmin = Prompt-ForInput "Enter the Secondary Site Administrator Account"
}
$Port = ($accts | where-object{$_.variable -eq "Site"}).Value
if(!$Port)
{
$Port = Prompt-ForInput "Enter the Port Number to be set for the FIM Portal"
}
}
elseif($MIMPrep -eq "no")
{
# $svcFIMPool = "svcFIMSPPOOL"
$svcFIMPool = Prompt-ForInput "Enter the SharePoint Application Pool Service Account"
# $FarmAdminUser = "svcFIMAdmin"
$FarmAdminUser = Prompt-ForInput "Enter the Primary Site Collection Administrator Account"
# $Site = "FIMPortal"
$Site = "http://" + $(Prompt-ForInput "Enter the site Url, Note: what ever is entered here will be used when Installing the FIM Portal")
# $SecFarmAdmin = "Administrator"
$SecFarmAdmin = Prompt-ForInput "Enter the Secondary Site Administrator Account"
# $Port = 80
$Port = Prompt-ForInput "Enter the Port Number to be set for the FIM Portal"
}

##The next block of code sets the credentials being used to create the site
New-SPManagedAccount -Credential (Get-Credential -Message "FIMSPFPoolAccount" -UserName "$Domain\$svcFIMPool")
##A pop up will appear for you to type in the Password of the account that was set as the variable of $svcFIMPool
##You may need to correct the user name in the following format DOMAIN\ACCOUNT NAME
##Enter the Password in the window
##The next block of code will create the application pool
New-SPServiceApplicationPool -Name FIMSPFPool -Account $svcFIMPool
##This next block of code This creates a Web application that uses classic mode windows authentication
New-SPWebApplication -Name "FIM" -Url $site -Port $port -SecureSocketsLayer:$false -ApplicationPool "FIMSPFPool" -ApplicationPoolAccount (Get-SPManagedAccount $($svcFIMPool)) -AuthenticationMethod "Kerberos" -DatabaseName "FIM_SPF_Content"
##This block of code creates the creates the SP Site
New-SPSite -Name "FIM" -Url $Site -CompatibilityLevel 14 -Template "STS#0" -OwnerAlias $FarmAdminUser
##This next block of code sets Secondary Site Administrator
Set-SPSite -Identity $Site -SecondaryOwnerAlias "$Domain\$SecFarmAdmin"
##This block of code disables server side view state which is required for FIM
$contentService = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.ViewStateOnServer = $false
$contentService.Update()

#AN NOTE DO NOT CONFIGURE THIS BEFORE RuNNING SCRIPT OR ELSE

##This last block of code disables self-service upgrade to 2013 Experience mode
#2013 Experience mode is not supported by FIM
##Old Block of Code $SPSite = SPSite("http://FIMPortal")
$SPSite = Get-SPSite $Site

$SPSite.AllowSelfServiceUpgrade = $false

 

