function kill_edge {
    Write-Host -ForegroundColor red "Edge is terminated due to previous error"
    taskkill /IM msedge.exe /T /F
    Start-Sleep -Seconds 3
}

function kill_nekoray {
    Write-Host -ForegroundColor red "Nekoray is terminated due to previous error"
    taskkill /IM nekoray.exe /T /F
    Start-Sleep -Seconds 3
}

function kill_spotify {
    Write-Host -ForegroundColor red "Spotify is terminated due to previous error"
    taskkill /IM spotify.exe /T /F
    Start-Sleep -Seconds 3
}

function kill_code {
    Write-Host -ForegroundColor red "vscode is terminated due to previous error"
    taskkill /IM code.exe /T /F
    Start-Sleep -Seconds 3
}

Import-Module .\rust-stop.ps1
function run_edge {
    msedge
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Microsoft-Edge is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        kill_edge
        kill_nekoray
        kill_spotify
        kill_code
        exit 1
    }
}
function run_nekoray {
    nekoray
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Nekoray is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "Nekoray is fucked up"
        kill_nekoray
        kill_edge
        kill_spotify
        kill_code
        exit 1
    }
}

function run_spotify {
    spotify
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "Spotify is started successfully"
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "Spotify is fucked up"
        kill_spotify
        kill_edge
        kill_nekoray
        kill_code
        exit 1
    }
}
function practice {
    wsl code '/mnt/e/sb/w/rust/ro/rustlings'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "vscode is started successfully"
        wsl --cd 'E:\sb\w\rust\ro\rustlings\'
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "vscode is fucked up"
        kill_code
        kill_edge
        kill_nekoray
        kill_spotify
        exit 1
    }
}
function read {
    wsl code '/mnt/e/sb/w/rust/ro/rust-book'
    if ( $? -eq "True" ) {
        Write-Host -ForegroundColor green "vscode is started successfully"
        wsl --cd 'E:\sb\w\rust\ro\rust-book\'
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host -ForegroundColor red "vscode is fucked up"
        kill_code
        kill_edge
        kill_nekoray
        kill_spotify
        exit 1
    }
}


while ($result -ne 'p' -and $result -ne 'r' -and $result -ne '') {
    $result = Read-Host "your are on practice or read? [ p | R ]"
}

switch ( $result ) {
    p { run_edge; run_nekoray; run_spotify; practice }
    r { run_edge; run_nekoray; run_spotify; read }
    default { run_edge; run_nekoray; run_spotify; read }
}