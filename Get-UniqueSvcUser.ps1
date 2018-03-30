#Get the Domain Controller of the local domain
#$DC = Get-ADDomainController -Discover
$DC = Get-ADDomainController -Discover

$ObjectResults = @()
$ADservers = (Get-ADComputer -LDAPFilter "(objectClass=computer)" -SearchBase 'DC=qa,DC=denverco,DC=gov' -Server $DC).Name
#$ADServers = (Get-ADComputer -Identity GOVADMT1).Name
foreach($ADServer in $ADServers){

write-host
$ServerName = $ADServer
$WMISvc = gwmi -Class Win32_Service -ComputerName $ADServer -Filter "State='Running'" | 
? {$_.StartName -NotMatch "NT-AUTHORIT.*|.*-Admins|.*Administrators|.*Manage.*|.*Local.*|.*Network.*"} | select StartName, Description, ServerName

$Output = @{'StartName' = $WMISvc.StartName;
            'Description' = $WMISvc.Description;
            'DisplayName' = $WMISvc.DisplayName;
            'ServerName' = $ServerName;
            }

$Obj = New-Object PSObject -Property $Output
$ObjectResults += $Obj
Write-Output $Obj.ServerName
}

$ObjectResults | Out-File -FilePath '.\UniqueSvcUser.csv'
$ObjectResults = $null
