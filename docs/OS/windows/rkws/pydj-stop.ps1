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

function kill_docker {
    Write-Host -ForegroundColor green "VLC is terminated successfully"
    taskkill /IM 'Docker Desktop.exe' /T /F
    Start-Sleep -Seconds 3
}

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "are you sure to exit 'python/django' session? [ Y | n ]"
}

switch ( $result ) {
    y { kill_docker; kill_vlc; kill_code }
    n { exit 0 }
    default { kill_docker; kill_vlc; kill_code }
}