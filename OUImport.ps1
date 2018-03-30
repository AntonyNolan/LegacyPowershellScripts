$adoufile = Import-Excel "path"

foreach ($ou in $adoufile)
{
    $ouname = $ou.ouname
    $oupath = $ou.oupath

        New-ADOrganizationalUnit -Name $ouname -Path $oupath
        Write-Host $ouname at $oupath
}