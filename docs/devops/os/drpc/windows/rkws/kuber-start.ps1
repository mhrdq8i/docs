function kill_code {
    Write-Host -ForegroundColor red "vscode is terminated due to previous error"
    taskkill /IM 'code.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_vlc {
    Write-Host -ForegroundColor red "VLC is terminated due to previous error"
    taskkill /IM 'vlc.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_mobaxterm {
    Write-Host -ForegroundColor red "mobaxterm is terminated due to previous error"
    taskkill /IM 'mobaxterm.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_vm_machines {
    vmrun -T ws stop "E:\VirtualMachines\k8s\master-1\master-1.vmx"
    Write-Host -ForegroundColor blue "Master-1 has been shutdown successfully"

    vmrun -T ws stop "E:\VirtualMachines\k8s\master-2\master-2.vmx"
    Write-Host -ForegroundColor blue "Master-2 has been shutdown successfully"

    vmrun -T ws stop "E:\VirtualMachines\k8s\master-3\master-3.vmx"
    Write-Host -ForegroundColor blue "Master-3 has been shutdown successfully"
}

function kill_vmware {
    taskkill /IM 'vmware.exe' /T /F
    Write-Host -ForegroundColor blue "VMWare has been terminated successfully"
}

function run_code {
    code 'E:\sb\d\devops'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "vscode is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "vscode has been crashed"
        kill_code
        kill_vlc
        kill_mobaxterm
        kill_vmware
        exit 1
    }
}

function run_vlc {
    vlc 'E:\sb\t\devops\Kuber\Kuber - Babaei'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "VLC is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "VLC has been crashed"
        kill_vlc
        kill_code
        kill_mobaxterm
        kill_vmware
        exit 1
    }
}
function run_mobaxterm {
    MobaXterm -openfolder 'kuber cluster'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "MobaXterm is started successfully"
    }
    else {
        Write-Host -ForegroundColor red "mobaxter has been crashed"
        kill_mobaxterm
        kill_vlc
        kill_code
        kill_vmware
        exit 1
    }
}

function run_vmware_machines {
    vmrun -T ws start "E:\VirtualMachines\k8s\master-2\master-2.vmx"
    vmrun -T ws start "E:\VirtualMachines\k8s\master-3\master-3.vmx"
    vmrun -T ws start "E:\VirtualMachines\k8s\master-1\master-1.vmx"
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Master-1 is started successfully"
        Write-Host -ForegroundColor green "Master-2 is started successfully"
        Write-Host -ForegroundColor green "Master-3 is started successfully"
        Start-Sleep -Second 5
    }
    else {
        Write-Host -ForegroundColor red "vmware has been crashed"
        kill_mobaxterm
        kill_vlc
        kill_code
        kill_vm_machines
        Start-Sleep -Seconds 10
        kill_vmware
        exit 1
    }
}

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "would you like to start 'kubernetes' session? [ Y | n ]"
}

switch ( $result ) {
    y { run_code; run_vlc; run_vmware_machines; run_mobaxterm }
    n { exit 0 }
    default { run_code; run_vlc; run_vmware_machines; run_mobaxterm }
}