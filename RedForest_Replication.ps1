#Parameters
$MemberOf = ()@
$SamAccountName = ()@
$Password = ()@
$AccountDisabled = ()@
$RFAdminOU = 'Red Forest Admin OU'
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
            $OU = $RFAdminOU
            $RFSAM = "$SamAccountName" + "-T1" #samAccountName with Suffix
            $firstname = $NewIdentity.firstname
            $Lastname = $NewIdentity.lastname
            $NewName = "$firstname $lastname"
            $UPN = "$NewName" + "@redforestUPNSuffix"
        #Create new user *remove -whatif appended for non-destructive execution
            New-ADUser -SamAccountName $RFSAM -Name $NewName -GivenName $firstname -Surname $lastname `
                -Path "$RFSAM" -UserPrincipleName $UPN -AccountPassword 'R3dP@ssw0rd' -whatif
        
        }
        else {
            Write-Warning "The account $SamAccountName1 already exists on the domain. A new account has not been created."
        }
    
}