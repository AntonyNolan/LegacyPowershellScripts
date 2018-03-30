$DenCoGroups = Get-ADGroup -Filter * -searchbase "dc=denverco,dc=gov" | select name, distinguishedname, groupcategory, samaccountname;

$DenCoDistroGrps = Get-ADGroup -Filter {(name -like "#*")} -searchbase "dc=denverco,dc=gov"
foreach($DenCoDistroGrp in $DenCoDistroGrps) {
    $UserCount = (Get-ADGroupMember $DenCoDistroGrps.DistinguishedName)
    Write-Host "Group $($group.name) has $UserCount users"
}


$DenCoDistroGrps.count

