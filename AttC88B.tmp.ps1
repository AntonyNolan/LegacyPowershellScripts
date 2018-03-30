$adminCreds = Get-Credential -Message "Enter privileged credentials"

nslookup PKIINF001Q.qa.denverco.gov #Subordinate Ent CA
nslookup ADFIAA001Q.qa.denverco.gov #Identity & Access
nslookup ADFIAA002T.tst.denverco.gov #Identity & Access
nslookup MIMSIAA001Q.qa.denverco.gov #Identity & Access
nslookup MIMSIAA002Q.qa.denverco.gov #Identity & Access
nslookup MPPIAA001QT.qa.denverco.gov #Identity & Access
nslookup MPSIAA001Q.qa.denverco.gov #Identity & Access
nslookup ADSADC001Q.qa.denverco.gov #Domain Controller
nslookup ADSADC002Q.qa.denverco.gov #Domain Controller
nslookup MIMDBS001Q.qa.denverco.gov #MS SQL DB Server
nslookup MIMDBS002Q.qa.denverco.gov #MS SQL DB Server
nslookup MIMDBS003Q.qa.denverco.gov #MS SQL DB Server
nslookup MIMDBS004Q.qa.denverco.gov #MS SQL DB Server
nslookup govdcq1.tst.denverco.gov #Domain Controller
nslookup govadfs1q.tst.denverco.gov #Identity & Access
nslookup govadfs2q.tst.denverco.gov #Identity & Access
nslookup govaadsync1q.tst.denverco.gov #Identity & Access
nslookup govadmt1q.tst.denverco.gov #Migration Tool

tracert 10.5.20.25
tracert 10.5.20.26
tracert 10.6.20.35
tracert 10.6.20.36
tracert 10.5.20.27
tracert 10.5.20.28
tracert 10.5.20.29
tracert 10.5.20.30
tracert 10.6.20.37
tracert 10.5.20.31
tracert 10.6.20.38
tracert 10.5.20.32
tracert 10.6.20.39
tracert 10.6.20.13
tracert 10.6.20.10
tracert 10.5.20.10
tracert 1.6.20.11
tracert 10.6.20.12

# SQL Alias: MIMDBSQ
# SQL Instance: TSQATMIM

mstsc /v:10.5.20.25 # Subordinate Ent CA PKIINF001Q
mstsc /v:10.5.20.26 # Identity & Access ADFIAA001Q
mstsc /v:10.6.20.35 # Identity & Access ADFIAA002T
mstsc /v:10.6.20.36 /admin # MIM Service Identity & Access MIMSIAA001Q Done: Alias
mstsc /v:10.5.20.27 /admin # MIM Service Identity & Access MIMSIAA002Q Done: Alias
mstsc /v:10.5.20.28 /admin # MIM Portal Identity & Access MPPIAA001Q Done: Alias
mstsc /v:10.5.20.29 /admin # MIM Sync Identity & Access MPSIAA001Q Done: Alias
mstsc /v:10.5.20.30 /admin # Domain Controller ADSADC001Q
mstsc /v:10.6.20.37 # Domain Controller ADSADC002Q
mstsc /v:10.5.20.31 # MS SQL DB Server MIMDBS001Q
mstsc /v:10.6.20.38 /admin # MIMDB MS SQL DB Server MIMDBS002Q
mstsc /v:10.5.20.32 # MS SQL DB Server MIMDBS003Q
mstsc /v:10.6.20.39 # MS SQL DB Server MIMDBS004Q
mstsc /v:10.6.20.13 # Domain Controller GOVDCQ1
mstsc /v:10.6.20.10 /admin # Identity & Access GOVADFS1Q (2012) Done: Alias 
mstsc /v:10.5.20.10 /admin # Identity & Access GOVADFS2Q
mstsc /v:1.6.20.11 # Identity & Access GOVAADSYNC1Q
mstsc /v:10.6.20.12 /admin # Migration Tool GOVADMT1Q


Enter-PsSession -ComputerName PKIINF001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName ADFIAA001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName ADFIAA002T.tst.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMSIAA001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMSIAA002Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MPPIAA001QT.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MPSIAA001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName ADSADC001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName ADSADC002Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMDBS001Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMDBS002Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMDBS003Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName MIMDBS004Q.qa.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName govdcq1.tst.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName govadfs1q.tst.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName govadfs2q.tst.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName govaadsync1q.tst.denverco.gov -Credential $adminCreds
Enter-PsSession -ComputerName govadmt1q.tst.denverco.gov -Credential $adminCreds
