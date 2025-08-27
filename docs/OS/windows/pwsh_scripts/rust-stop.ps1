function kill_edge {
    Write-Host -ForegroundColor green "Edge is terminated successfully"
    taskkill /IM 'msedge.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_nekoray {
    Write-Host -ForegroundColor green "Nekoray is terminated successfully"
    taskkill /IM 'nekoray.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_spotify {
    Write-Host -ForegroundColor green "Spotify is terminated successfully"
    taskkill /IM 'spotify.exe' /T /F
    Start-Sleep -Seconds 3
}

function kill_code {
    Write-Host -ForegroundColor green "vscode is terminated successfully"
    taskkill /IM 'code.exe' /T /F
    Start-Sleep -Seconds 3
}

while ($result -ne 'y' -and $result -ne 'n' -and $result -ne '') {
    $result = Read-Host "are you sure to exit 'rust' session? [ Y | n ]"
}

switch ( $result ) {
    y { kill_edge; kill_nekoray; kill_spotify; kill_code }
    n { exit 0 }
    default { kill_edge; kill_nekoray; kill_spotify; kill_code }
}