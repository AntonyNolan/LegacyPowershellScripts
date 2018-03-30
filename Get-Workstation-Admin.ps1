#Parameters 
$FilePath = 'C:\Report\CCD_Local_Workstation.csv'
$SRLDap = 'LDAP://OU=Servers,DC=denverco,DC=gov'
$LDAPFil = "(objectClass=computer)"

#Import Active Directory Module
If (!(Get-module ActiveDirectory)) {Import-Module OperationsManager}

#Create ADSearcher Object and Set Object Filters 
$Searcher = New-Object DirectoryServices.DirectorySearcher([ADSI]"")
$Searcher.SearchRoot = $SRLDap
$Searcher.Filter = $LDAPFil
$Computers = ($Searcher.Findall())
$Results = @()

#Loop Through Objects in the OU and Find Local Admin Group Members
Foreach ($Wkst in $Computers){
	$Path=$Wkst.Path
	$Name=([ADSI]"$Path").Name
	$members =[ADSI]"WinNT://$Name/Administrators"
	$members = @($members.psbase.Invoke("Members"))
	
#Create object to group output and export values
$members | foreach {
		$LocalAdmins = $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)    
		$pubObject | add-member -membertype NoteProperty -name "Server" -Value $Name
		$pubObject | add-member -membertype NoteProperty -name "Administrators" -Value $LocalAdmins

		# Append this iteration of our for loop to our results array.
		$Results += $pubObject
	}
}

#Export results then clear results
$Results | Out-File -FilePath $FilePath
$Results = $Null


