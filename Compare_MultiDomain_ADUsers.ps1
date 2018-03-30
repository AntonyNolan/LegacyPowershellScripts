#Get Both Domain Creds
$Creds1 = Get-Credential ##Enter credentials for first domain
$Creds2 = Get-Credential ##Enter credentials for first domain

#Get the Domain Controller of the local domain

#Get Domain Users
$AdUsersDom1 = Get-ADUser -Filter * -SearchBase 'OU=Servers,DC=denverco,DC=gov' -Server (Get-ADDomainController).name -Credential $Creds1
$AdUsersDom2 = Get-ADUser -Filter * -SearchBase 'OU=Servers,DC=denverco,DC=gov' -Server ??? -Credential $Creds2

Foreach ( $user in $ADUsersDom1 ) {
    $userName = $user.SamAccountName
    $userGivenName = $user.GivenName

#Get Index and entry of user in the second domain array
    $dom2Index = $AdUsersDom2.SamAccountname.IndexOf($userName)
    $userCompare = $AdUsersDom2[$dom2Index]

#Compare Given name from domain1 to domain2
    if ($userGivenName -ne $userCompare.GivenName) {
        echo “$userName Given name is different in domain2”
    }
}