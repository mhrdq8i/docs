function kill_code {
    Write-Host -ForegroundColor red "vscode is terminated due to previous error"
    taskkill /IM code.exe /T /F
    Start-Sleep -Seconds 3
}

function kill_vlc {
    Write-Host -ForegroundColor red "VLC is terminated due to previous error"
    taskkill /IM vlc.exe /T /F
    Start-Sleep -Seconds 3
}

function kill_docker {
    Write-Host -ForegroundColor red "VLC is terminated due to previous error"
    taskkill /IM 'Docker Desktop.exe' /T /F
    Start-Sleep -Seconds 3
}

function run_code {
    wsl code '/mnt/e/sb/w/python/mark/recipe-app-api/'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "vscode is started successfully"
        wsl --cd 'E:\sb\w\python\mark\recipe-app-api\'
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "vscode has been crashed"
        kill_code
        kill_vlc
        kill_docker
        exit 1
    }
}

function run_vlc {
    vlc "E:\sb\t\prgrmng-dsa\python\django\Udemy\Build a Backend REST API with Python & Django - Advanced"
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "VLC is started successfully"
        Start-Sleep -Seconds 10
    }
    else {
        Write-Host -ForegroundColor red "VLC has been crashed"
        kill_vlc
        kill_code
        kill_docker
        exit 1
    }
}

function run_docker {
    Start-Job -ScriptBlock { Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe" }
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Docker Desktop & Docker Service are started successfully"
        Start-Sleep -Seconds 5
        Write-Host -ForegroundColor cyan "All the applications have been run successfully"
        Start-Sleep -Seconds 5
        Write-Host -ForegroundColor green "Shell is changing to Linux BASH soon..."
        wsl --cd "E:\sb\w\python\mark\recipe-app-api\"
    }
    else {
        Write-Host -ForegroundColor red "Docker has been crashed"
        kill_docker
        kill_vlc
        kill_code
        exit 1
    }
}

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "would you like to start 'python/djano' session? [ Y | n ]"
}

switch ( $result ) {
    y { run_docker; run_vlc; run_code }
    n { exit 0 }
    default { run_docker; run_vlc; run_code }
}