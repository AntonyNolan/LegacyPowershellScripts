$current = (get-item WSMan:\localhost\Client\TrustedHosts).value
$current += "S31570"
set-item WSMan:\localhost\Client\TrustedHosts –value $current
(get-item WSMan:\localhost\Client\TrustedHosts).value