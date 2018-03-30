import-csv -Path .\computernames.txt | `
select -Property *, @{name='TestColumn'; expression={$_.computername}}

$tstcomp = @(
'localhost'
'PKIINF001T.win.tst.denverco.gov',
'ADFIAA001T.win.tst.denverco.gov',
'ADFIAA002T.win.tst.denverco.gov',
'MIMISAA001T.win.tst.denverco.gov',
'MIMSIAA001T.win.tst.denverco.gov',
'MPPIAA001T.win.tst.denverco.gov',
'MPSIAA001T.win.tst.denverco.gov',
'ADSADC001T.tst.denverco.gov',
'ADSADC002T.tst.denverco.gov',
'MIMDBS001T.win.tst.denverco.gov',
'MIMDBS002Pwin.denverco.gov',
'MIMDBS003T.win.tst.denverco.gov',
'MIMDBS004T.win.tst.denverco.gov'
)

foreach($comp in $tstcomp)
{
    $CompConn = (Test-connection -Quiet -computername $comp)
    write-host "connect to" "$comp" "But Does it respond????" "$compConn"
}