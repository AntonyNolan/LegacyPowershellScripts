#Set Parameters 
    $rg = 'RG_SANDBOX_DEFAULT'
    $vm = 'sw-ad01'

# Find AzureRmVm Size
#$vmsize = get-azurermvmsize -ResourceGroupName RG_SANDBOX_DEFAULT -VMName sb-ad1
 $vmsize | ? {$_.name -eq "Basic_A1"}

# Resize the VM
$vm = Get-AzureRmVM -ResourceGroupName $rg -Name $vm
$vm.HardwareProfile.VmSize = $vmsize   
Update-AzureRmVM -VM $vm -ResourceGroupName $rg 