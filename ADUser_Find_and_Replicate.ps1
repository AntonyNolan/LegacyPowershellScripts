#Parameters
$MemberOf = ()@
$SamAccountName = ()@
$Password = ()@
$AccountDisabled = ()@
$NewAdminOU = 'Red Forest Admin OU'
$Path = '.\CCD AllPrivUsers.csv'

#Import Existing Users for Red Forest Replication
Import-CSV -Path $Path | foreach 
{
        $samAccountName += $_.SamAccountName
        $MemberOf += $_.MemberOf
        $Password += $_.Password
        $AccountDisabled += $_."Account Disabled"

        if (Get-ADuser -Filter {SamAccountName -eq "$SamAccountName"}) {
        #Check for Existing AD User then create Identity using exiting attributes
            $NewIdentity = Get-AdUser -Identity
            $DN = $NewIdentity.distinguishedName
            $OU = $NewAdminOU
            $RFSAM0 = "$SamAccountName"+"-T0" #samAccountName with Suffix Tier 0
            $RFSAM1 = "$SamAccountName"+"-T1" #samAccountName with Suffix Tier 1
            $RFSAM2 = "$SamAccountName"+"-T2" #samAccountName with Suffix Tier 2
            $firstname = $NewIdentity.firstname
            $Lastname = $NewIdentity.lastname
            $NewName = "$firstname $lastname"
            $UPN = "$NewName" + "@UPNSuffix"
        #Create new user *remove -whatif appended for non-destructive execution
            New-ADUser -SamAccountName $RFSAM0 -Name $NewName -GivenName $firstname -Surname $lastname `
                -Path $OU -UserPrincipleName $UPN -AccountPassword 'P@ssw0rd' -whatif
            New-ADUser -SamAccountName $RFSAM1 -Name $NewName -GivenName $firstname -Surname $lastname `
                -Path $OU -UserPrincipleName $UPN -AccountPassword 'P@ssw0rd' -whatif
            New-ADUser -SamAccountName $RFSAM2 -Name $NewName -GivenName $firstname -Surname $lastname `
                -Path $OU -UserPrincipleName $UPN -AccountPassword 'P@ssw0rd' -whatif    
        
        }
        else {
            Write-Warning "The account $SamAccountName1 already exists on the domain. A new account has not been created."
        }
    
}