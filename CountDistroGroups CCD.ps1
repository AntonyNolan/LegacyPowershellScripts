#Variables
$DenCoGroups = Get-ADGroup -Filter * -searchbase "dc=denverco,dc=gov" | select name, distinguishedname, groupcategory, samaccountname;
$ANScriptFile = 'C:\Users\500483\Desktop\scripts\Groups';

#Loop
$DenCoDistroGrps = Get-ADGroup -Filter {(name -like "#*")} -searchbase "dc=denverco,dc=gov";
foreach($DenCoDistro in $DenCoDistroGrps) {
    $UserCount = (Get-ADGroupMember $DenCoDistro.DistinguishedName).count
    Write-Host "Group $($DenCoDistro.name) has $UserCount users"get-0
} 
| Out-File $ANScriptFile\DistroGroupMembers.xml