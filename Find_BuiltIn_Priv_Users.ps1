'Domain Admins', 'Administrators', 'Enterprise Admins', 'Schema Admins', 'Server Operators', 'Backup Operators' | ForEach-Object {
    $groupName = $_
    Get-ADGroupMember -Identity $_ -Recursive | Get-ADUser | Select-Object Name, DisplayName, @{n='GroupName';e={ $groupName }}
}