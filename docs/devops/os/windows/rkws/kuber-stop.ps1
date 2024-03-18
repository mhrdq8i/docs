function kill_code {
    Write-Host -ForegroundColor green "vscode is terminated successfully"
    taskkill /IM 'code.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_vlc {
    Write-Host -ForegroundColor green "VLC is terminated successfully"
    taskkill /IM 'vlc.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_mobaxterm {
    Write-Host -ForegroundColor green "mobaxterm is terminated successfully"
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

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "are you sure to exit 'kubernetes' session? [ Y | n ]"
}

switch ( $result ) {
    y {
        kill_vlc;
        kill_code;
        kill_mobaxterm;
        kill_vm_machines;
        Start-Sleep -Seconds 10;
        kill_vmware
    }
    n { exit 0 }
    default {
        kill_vlc;
        kill_code;
        kill_mobaxterm;
        kill_vm_machines;
        Start-Sleep -Seconds 10;
        kill_vmware
    }
}