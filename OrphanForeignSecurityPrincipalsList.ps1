Import-Module -Name OrphanForeignSecurityPrincipals
 
$MyCompanyTurnover = 20
$OrphanFSPListFilePath ='c:\temp\OFSP.txt'
 
$OrphanForeignSecurityPrincipalsList = Get-OrphanForeignSecurityPrincipal ‑TabDelimitedFile $OrphanFSPListFilePath
 
If ($OrphanForeignSecurityPrincipalsList)
{
    If ($OrphanForeignSecurityPrincipalsList.Count -gt $MyCompanyTurnover)
    {
        $MailParameters = @{
            SmtpServer = 'mail.mycompany.com'
            From       = 'NoReply@mycompany.com'
            To         = 'Administrator@mycompany.com'
            Subject    = "Orphan Foreign Security Principals found"
            Body       = 'Please check attached file.'
            Attachment = $OrphanFSPListFilePath
        }
 
        Send-MailMessage @MailParameters
    }
    else {
        Remove-OrphanForeignSecurityPrincipal -TabDelimitedFile $OrphanFSPListFilePath
    }
}