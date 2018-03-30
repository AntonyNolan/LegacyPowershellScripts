#Username Array
$MIMLogins = "MIMMA",
            "MIMMonitor",
            "MIMComponent",
            "MIMSync",
            "MIMService",
            "SharePoint",
            "SqlServer",
            "BackupAdmin"
            ,"MIMAdmin"
;

#Create new user withought cleartext password - Remember to remove -WhatIf
new-aduser -Name "MIMMA" -SamAccountName "MIMMA" -Displayname "MIMMA" -Enabled 1 -Path 'OU=Service,OU=UserObjects,DC=denverco,DC=gov' -PasswordNeverExpires 1 `
 -AccountPassword (Read-Host -AsSecureString "Account Password") -PassThru | Enable-ADAccount -WhatIf


 $MIMLoginList = "MIMMA",
            "MIMMonitor",
            "MIMComponent",
            "MIMSync",
            "MIMService",
            "SharePoint",
            "SqlServer",
            "BackupAdmin"
            ,"MIMAdmin"
;

foreach($MIMLogin in $MIMLoginList) {

new-aduser -Name $MIMLogin -SamAccountName $MIMLogin -Displayname $MIMLogin -Enabled 1 -Path 'OU=Service,OU=UserObjects,DC=denverco,DC=gov' -PasswordNeverExpires 1 `
 -AccountPassword (Read-Host -AsSecureString "Account Password") -PassThru | Enable-ADAccount -WhatIf

write-host "User $MIMLogin has been created"

 }