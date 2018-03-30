Import-Module ActiveDirectory 
$DCDNS = (Get-addomaincontroller -discover).Name  
$DomainSID = 'S-1-5-21-1275210071-1078081533-725345543'
$FSPCN = CN=ForeignSecurityPrincipals,DC=denverco,DC=gov
$RDID1 = 'S-1-5-21-1275210071'
#$RID1 = '74124'
#$RID2 = '104333'

CLS 
  
(Get-ADObject -LDAPFilter "(objectClass=foreignSecurityPrincipal)" -SearchBase  "CN=ForeignSecurityPrincipals,DC=denverco,DC=gov" | 
foreach {$_.DistinguishedName, $_.Name, $_.ObjectClass, $_.ObjectGUID})
{ 

 Foreach ($Member in $Group.Member) 
 { 
  if ($Member -like "*74124*") 
  { 
   $FSPReadableName = $null 
   $FSPReadableName = (Get-ADObject -Identity $Member -Server  $DCDNS> -Properties "msDS-PrincipalName")."msDS-PrincipalName" 
   $Object = New-Object PSObject 
   $Object | add-member Noteproperty GroupName $Group.Name 
   $Object | add-member Noteproperty FSP $FSPReadableName 
   Export-Csv -Path ".\exportfile.csv>" -Append -InputObject $Object   
  } 
 } 
} 