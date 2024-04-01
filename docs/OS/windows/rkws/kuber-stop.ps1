function kill_code {
    Write-Host -ForegroundColor red "vscode has terminated successfully"
    taskkill /IM 'code.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_vlc {
    Write-Host -ForegroundColor gree "VLC has terminated successfully"
    taskkill /IM 'vlc.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_mobaxterm {
    Write-Host -ForegroundColor red "mobaxterm has terminated successfully"
    taskkill /IM 'mobaxterm.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_vmware_machines {
    vmrun -T ws stop "E:\VirtualMachines\k8s\master-1\master-1.vmx"
    Write-Host -ForegroundColor green "Master-1 has been shutdown successfully"

    vmrun -T ws stop "E:\VirtualMachines\k8s\master-2\master-2.vmx"
    Write-Host -ForegroundColor green "Master-2 has been shutdown successfully"

    vmrun -T ws stop "E:\VirtualMachines\k8s\master-3\master-3.vmx"
    Write-Host -ForegroundColor green "Master-3 has been shutdown successfully"
}

function kill_vmware {
    taskkill /IM 'vmware.exe' /T /F
    Write-Host -ForegroundColor green "VMWare has been terminated successfully"
}

function kill_vagrant_machines {
    Set-Location 'E:\sb\w\hashicorp\vagrant\vagrant-kubeadm-kubernetes'
    vagrant halt
    Write-Host -ForegroundColor green "Vagrant Machines have been Halted successfully"
}

function kill_virtulbox {
    taskkill /IM 'virtualbox.exe' /T /F
    Write-Host -ForegroundColor green "virtualbox has been terminated successfully"
}

function kills_common_mode {
    kill_vlc
    kill_code
    kill_mobaxterm
}

function kills_vmware_mode {
    kill_vmware_machines
    Start-Sleep -Seconds 6
    kill_vmware
}

function kills_virtualbox_mode {
    kill_vagrant_machines
    Start-Sleep -Seconds 6
    kill_virtulbox
}

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "are you sure to exit 'kubernetes' session? [ Y | n ]"
}

switch ( $result ) {
    y {
        kills_virtualbox_mode
        # kills_vmware_mode
        kills_common_mode
    }
    n { exit 0 }
    default {
        kills_virtualbox_mode
        # kills_vmware_mode
        # kills_common_mode
    }
}