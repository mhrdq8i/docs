# Kills
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

# RUNS
function run_code {
    code 'E:\sb\d\docstack'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "vscode is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "vscode has been crashed"
        kills_vmware_mode
        kills_virtualbox_mode
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
        kills_vmware_mode
        kills_virtualbox_mode
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
        kills_vmware_mode
        kills_virtualbox_mode
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
        kills_vmware_mode
        exit 1
    }
}

function run_vagrant_up {

    Set-Location 'E:\sb\w\hashicorp\vagrant\vagrant-kubeadm-kubernetes'
    vagrant status
    Start-Sleep -Second 5
    vagrant up

    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Master Node is started successfully"
        Write-Host -ForegroundColor green "Worker Node 01 is started successfully"
        Write-Host -ForegroundColor green "Worker Node 02 is started successfully"
        vagrant status
        Start-Sleep -Second 5
    }
    else {
        Write-Host -ForegroundColor red "Something went wrong during start vagrant machines"
        kills_virtualbox_mode
        exit 1
    }
}

function run_vagrant_ssh {

    $vagrant_dir = 'E:\sb\w\hashicorp\vagrant\vagrant-kubeadm-kubernetes'
    $run_mn_00 = 'vagrant ssh controlplane'
    $run_wn_01 = 'vagrant ssh node01'
    $run_wn_02 = 'vagrant ssh node02'

    wt -d $vagrant_dir powershell -c $run_mn_00 `; split-pane --vertical -d $vagrant_dir  powershell -c $run_wn_01 `; split-pane --horizontal -d $vagrant_dir powershell -c $run_wn_02 `;  focus-pane --target 0

    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "SSH connection over vagrant machines are successfully stablished"
        Start-Sleep -Second 5
    }
    else {
        Write-Host -ForegroundColor red "Something went wrong during SSH to machines"
        kills_virtualbox_mode
        exit 1
    }
}


while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "would you like to start 'kubernetes' session? [Y | n]"
}
    switch ( $result ) {
        y {
            while ($env_result -ne 'vmware' -and $env_result -ne 'vagrant' -and $env_result -ne '') {
                $env_result = Read-Host "Which ENVs do you want to run? [ vmware | vagrant ]"
            }
                switch ( $env_result ) {
                    vmware {
                        run_code
                        run_vlc
                        run_vmware_machines
                    }
                    vagrant {
                        run_code
                        run_vlc
                        run_vagrant_up
                        run_vagrant_ssh
                    }
                    Default {
                        run_code
                        run_vlc
                        run_vagrant_up
                        run_vagrant_ssh
                    }
                }
        }
        n {
            exit 0
        }
        default {
            run_code
            run_vlc
            run_vagrant_up
            run_vagrant_ssh
        }
}