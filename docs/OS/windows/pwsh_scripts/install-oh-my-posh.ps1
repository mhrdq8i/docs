# Oh My Posh Installation and Theme Setup Script
# This script installs Oh My Posh and sets up your preferred theme

param(
    [string]$Theme = ""
)

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to install Oh My Posh
function Install-OhMyPosh {
    Write-Host "Installing Oh My Posh..." -ForegroundColor Green
    
    try {
        # Check if winget is available
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "Installing via winget..." -ForegroundColor Yellow
            winget install JanDeDobbeleer.OhMyPosh -s winget
        }
        # Fallback to PowerShell Gallery if winget fails
        elseif (Get-Command Install-Module -ErrorAction SilentlyContinue) {
            Write-Host "Installing via PowerShell Gallery..." -ForegroundColor Yellow
            Install-Module oh-my-posh -Scope CurrentUser -Force
        }
        else {
            throw "Neither winget nor PowerShell Gallery installation methods are available."
        }
        
        Write-Host "Oh My Posh installed successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Failed to install Oh My Posh: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Function to get available themes
function Get-OhMyPoshThemes {
    try {
        # Get Oh My Posh executable path
        $ohMyPoshPath = (Get-Command oh-my-posh -ErrorAction SilentlyContinue).Source
        if (-not $ohMyPoshPath) {
            # Try common installation paths
            $possiblePaths = @(
                "$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe",
                "$env:ProgramFiles\oh-my-posh\bin\oh-my-posh.exe",
                "$env:ProgramFiles(x86)\oh-my-posh\bin\oh-my-posh.exe"
            )
            foreach ($path in $possiblePaths) {
                if (Test-Path $path) {
                    $ohMyPoshPath = $path
                    break
                }
            }
        }
        
        if ($ohMyPoshPath) {
            # Get themes directory
            $themesPath = Split-Path $ohMyPoshPath -Parent | Join-Path -ChildPath "..\themes"
            if (Test-Path $themesPath) {
                $themes = Get-ChildItem -Path $themesPath -Filter "*.omp.json" | ForEach-Object { $_.BaseName -replace '\.omp$', '' }
                return $themes
            }
        }
        
        # Fallback list of popular themes
        return @(
            "agnoster", "atomic", "avit", "blue-owl", "bubbles", "capr4n", "clean-detailed",
            "craver", "dracula", "emodipt-extend", "fish", "huvix", "iterm2", "jandedobbeleer",
            "lambda", "marcduiker", "material", "negligible", "night-owl", "paradox", "powerline",
            "pure", "robbyrussell", "rudolfs-light", "slim", "sonicboom_dark", "sonicboom_light",
            "spaceship", "star", "thecyberden", "tokyo", "unicorn", "ys", "zash"
        )
    }
    catch {
        Write-Host "Warning: Could not retrieve theme list. Using default themes." -ForegroundColor Yellow
        return @("agnoster", "atomic", "bubbles", "jandedobbeleer", "night-owl", "paradox", "powerline", "pure")
    }
}

# Function to prompt user for theme selection
function Select-Theme {
    if ($Theme) {
        Write-Host "Using provided theme: $Theme" -ForegroundColor Green
        return $Theme
    }
    
    Write-Host "`nWhich theme would you like to install?" -ForegroundColor Cyan
    Write-Host "Here are some popular Oh My Posh themes:" -ForegroundColor Yellow
    
    $availableThemes = Get-OhMyPoshThemes
    
    # Display themes in columns
    $columns = 3
    $themeCount = $availableThemes.Count
    $rows = [math]::Ceiling($themeCount / $columns)
    
    for ($row = 0; $row -lt $rows; $row++) {
        $line = ""
        for ($col = 0; $col -lt $columns; $col++) {
            $index = $row + ($col * $rows)
            if ($index -lt $themeCount) {
                $theme = $availableThemes[$index]
                $line += "{0,-20}" -f $theme
            }
        }
        Write-Host $line -ForegroundColor White
    }
    
    Write-Host "`nRecommended themes for beginners:" -ForegroundColor Green
    Write-Host "  - agnoster (classic powerline look)" -ForegroundColor White
    Write-Host "  - jandedobbeleer (creator's theme)" -ForegroundColor White
    Write-Host "  - night-owl (dark theme)" -ForegroundColor White
    Write-Host "  - pure (minimal design)" -ForegroundColor White
    
    do {
        $selectedTheme = Read-Host "`nPlease enter your preferred theme name"
        if ($selectedTheme -and $availableThemes -contains $selectedTheme) {
            return $selectedTheme
        } elseif ($selectedTheme) {
            Write-Host "Theme '$selectedTheme' not found. Please choose from the list above." -ForegroundColor Red
        }
    } while (-not $selectedTheme -or $availableThemes -notcontains $selectedTheme)
}

# Function to setup PowerShell profile
function Setup-PowerShellProfile {
    param([string]$SelectedTheme)
    
    Write-Host "Setting up PowerShell profile with theme: $SelectedTheme" -ForegroundColor Green
    
    # Get PowerShell profile path
    $profilePath = $PROFILE.CurrentUserCurrentHost
    $profileDir = Split-Path $profilePath -Parent
    
    # Create profile directory if it doesn't exist
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    
    # Backup existing profile if it exists
    if (Test-Path $profilePath) {
        $backupPath = "$profilePath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Copy-Item $profilePath $backupPath
        Write-Host "Existing profile backed up to: $backupPath" -ForegroundColor Yellow
    }
    
    # Create or update profile
    $profileContent = @"
# Oh My Posh initialization
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$SelectedTheme.omp.json`" | Invoke-Expression
} else {
    Write-Host "Oh My Posh not found. Please ensure it's installed and in PATH." -ForegroundColor Yellow
}

# Optional: Add some useful aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String

"@
    
    Set-Content -Path $profilePath -Value $profileContent -Encoding UTF8
    Write-Host "PowerShell profile updated: $profilePath" -ForegroundColor Green
}

# Function to display current terminal configuration
function Show-CurrentConfiguration {
    Write-Host "`n=== Current Terminal Configuration ===" -ForegroundColor Cyan
    
    # Get current Oh My Posh theme
    try {
        if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
            # Try to get current theme from environment variable or profile
            $currentTheme = $env:POSH_THEME
            if (-not $currentTheme) {
                # Check if we can extract from profile
                $profilePath = $PROFILE.CurrentUserCurrentHost
                if (Test-Path $profilePath) {
                    $profileContent = Get-Content $profilePath -Raw
                    if ($profileContent -match 'POSH_THEMES_PATH\\([^.]+)\.omp\.json') {
                        $currentTheme = $matches[1]
                    }
                }
            }
            
            if ($currentTheme) {
                Write-Host "🎨 Active Oh My Posh Theme: $currentTheme" -ForegroundColor Green
            } else {
                Write-Host "🎨 Active Oh My Posh Theme: Unable to detect (may be using default)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "🎨 Active Oh My Posh Theme: Oh My Posh not found or not configured" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "🎨 Active Oh My Posh Theme: Error detecting theme - $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Get Windows Terminal font configuration
    try {
        $terminalSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
        if (Test-Path $terminalSettingsPath) {
            $settings = Get-Content $terminalSettingsPath -Raw | ConvertFrom-Json
            
            # Check for font configuration in defaults
            if ($settings.profiles.defaults.font) {
                $fontFace = $settings.profiles.defaults.font.face
                $fontSize = $settings.profiles.defaults.font.size
                Write-Host "🔤 Font Family: $fontFace" -ForegroundColor Green
                Write-Host "📏 Font Size: $fontSize" -ForegroundColor Green
            }
            # Check active profile for font settings
            elseif ($settings.profiles.list) {
                $foundFont = $false
                foreach ($profile in $settings.profiles.list) {
                    if ($profile.font) {
                        $fontFace = $profile.font.face
                        $fontSize = $profile.font.size
                        Write-Host "🔤 Font Family: $fontFace (from profile: $($profile.name))" -ForegroundColor Green
                        Write-Host "📏 Font Size: $fontSize (from profile: $($profile.name))" -ForegroundColor Green
                        $foundFont = $true
                        break
                    }
                }
                if (-not $foundFont) {
                    Write-Host "🔤 Font Family: Using Windows Terminal default" -ForegroundColor Yellow
                    Write-Host "📏 Font Size: Using Windows Terminal default" -ForegroundColor Yellow
                }
            }
            else {
                Write-Host "🔤 Font Family: Using Windows Terminal default" -ForegroundColor Yellow
                Write-Host "📏 Font Size: Using Windows Terminal default" -ForegroundColor Yellow
            }
        }
        else {
            Write-Host "🔤 Font Family: Windows Terminal settings not found (using system default)" -ForegroundColor Yellow
            Write-Host "📏 Font Size: Windows Terminal settings not found (using system default)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "🔤 Font Family: Error reading terminal settings - $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📏 Font Size: Error reading terminal settings - $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Check for installed Nerd Fonts
    Write-Host "`n🔍 Checking for Nerd Fonts..." -ForegroundColor Cyan
    try {
        $fontsPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
        $systemFontsPath = "$env:SystemRoot\Fonts"
        
        $nerdFonts = @()
        $nerdFontPatterns = @("*Nerd Font*", "*NF*", "Caskaydia*", "Meslo*", "Fira*")
        
        foreach ($pattern in $nerdFontPatterns) {
            if (Test-Path $fontsPath) {
                $userFonts = Get-ChildItem -Path $fontsPath -Filter "$pattern.ttf" -ErrorAction SilentlyContinue
                $nerdFonts += $userFonts
            }
            if (Test-Path $systemFontsPath) {
                $systemFonts = Get-ChildItem -Path $systemFontsPath -Filter "$pattern.ttf" -ErrorAction SilentlyContinue
                $nerdFonts += $systemFonts
            }
        }
        
        if ($nerdFonts.Count -gt 0) {
            Write-Host "✅ Nerd Fonts detected: $($nerdFonts.Count) fonts found" -ForegroundColor Green
            $uniqueFonts = $nerdFonts | ForEach-Object { $_.BaseName -replace '\.(ttf|otf)$', '' } | Select-Object -Unique
            Write-Host "   Installed: $($uniqueFonts -join ', ')" -ForegroundColor Gray
        } else {
            Write-Host "⚠️  No Nerd Fonts detected - icons may not display correctly" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "❌ Error checking for Nerd Fonts: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host "`n💡 Configuration Tips:" -ForegroundColor Cyan
    Write-Host "   • Restart terminal after font changes" -ForegroundColor White
    Write-Host "   • Use 'Get-PoshThemes' to preview themes" -ForegroundColor White
    Write-Host "   • Edit profile with: notepad `$PROFILE" -ForegroundColor White
}

# Function to install required fonts
function Install-NerdFonts {
    Write-Host "`n=== Installing Nerd Fonts ===" -ForegroundColor Cyan
    Write-Host "Oh My Posh themes require Nerd Fonts to display icons and symbols correctly." -ForegroundColor Yellow
    Write-Host "Installing essential Nerd Fonts for optimal Oh My Posh experience..." -ForegroundColor Green
    
    # Array of recommended fonts to install
    $fontsToInstall = @(
        @{ Name = "CascadiaCode"; Description = "Microsoft's coding font with excellent PowerShell support" },
        @{ Name = "Meslo"; Description = "Popular monospace font, great for terminals" },
        @{ Name = "FiraCode"; Description = "Font with programming ligatures" }
    )
    
    $installedFonts = @()
    $failedFonts = @()
    
    foreach ($font in $fontsToInstall) {
        Write-Host "`nInstalling $($font.Name) Nerd Font..." -ForegroundColor Green
        Write-Host "  Description: $($font.Description)" -ForegroundColor Gray
        
        try {
            # Check if oh-my-posh is available for font installation
            if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
                # Use oh-my-posh built-in font installer (most reliable method)
                $result = oh-my-posh font install $($font.Name.ToLower()) 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "  ✅ Successfully installed $($font.Name) Nerd Font" -ForegroundColor Green
                    $installedFonts += $font.Name
                } else {
                    Write-Host "  ❌ Failed to install $($font.Name): $result" -ForegroundColor Red
                    $failedFonts += $font.Name
                }
            } else {
                # Fallback: Try winget for CascadiaCode only
                if ($font.Name -eq "CascadiaCode" -and (Get-Command winget -ErrorAction SilentlyContinue)) {
                    $result = winget install --id=9PL4Q9R6GWKT -e --source=msstore --silent
                    if ($LASTEXITCODE -eq 0) {
                        Write-Host "  ✅ Successfully installed $($font.Name) via winget" -ForegroundColor Green
                        $installedFonts += $font.Name
                    } else {
                        $failedFonts += $font.Name
                    }
                } else {
                    Write-Host "  ⚠️  Oh My Posh not available yet for font installation" -ForegroundColor Yellow
                    $failedFonts += $font.Name
                }
            }
        }
        catch {
            Write-Host "  ❌ Error installing $($font.Name): $($_.Exception.Message)" -ForegroundColor Red
            $failedFonts += $font.Name
        }
    }
    
    # Summary
    Write-Host "`n=== Font Installation Summary ===" -ForegroundColor Cyan
    if ($installedFonts.Count -gt 0) {
        Write-Host "✅ Successfully installed fonts: $($installedFonts -join ', ')" -ForegroundColor Green
    }
    if ($failedFonts.Count -gt 0) {
        Write-Host "❌ Failed to install fonts: $($failedFonts -join ', ')" -ForegroundColor Red
        Write-Host "   You can install them later using: oh-my-posh font install <font-name>" -ForegroundColor Yellow
        Write-Host "   Or visit: https://www.nerdfonts.com/font-downloads" -ForegroundColor Yellow
    }
    
    # Configure Windows Terminal if settings file exists
    $terminalSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    if ((Test-Path $terminalSettingsPath) -and ($installedFonts -contains "CascadiaCode")) {
        Write-Host "`nConfiguring Windows Terminal to use CaskaydiaCove NF..." -ForegroundColor Green
        try {
            $settings = Get-Content $terminalSettingsPath -Raw | ConvertFrom-Json
            
            # Add font configuration to defaults if it doesn't exist
            if (-not $settings.profiles.defaults.font) {
                if (-not $settings.profiles.defaults) {
                    $settings.profiles | Add-Member -MemberType NoteProperty -Name "defaults" -Value @{}
                }
                $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "font" -Value @{
                    face = "CaskaydiaCove NF"
                    size = 10
                }
                
                # Save updated settings
                $settings | ConvertTo-Json -Depth 10 | Set-Content $terminalSettingsPath -Encoding UTF8
                Write-Host "✅ Windows Terminal configured to use CaskaydiaCove NF font" -ForegroundColor Green
            } else {
                Write-Host "ℹ️  Windows Terminal font settings already configured" -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "⚠️  Could not automatically configure Windows Terminal. Please set font manually." -ForegroundColor Yellow
        }
    }
    
    Write-Host "`n📝 Font Configuration Instructions:" -ForegroundColor Cyan
    Write-Host "   1. Restart your terminal application" -ForegroundColor White
    Write-Host "   2. Set your terminal font to one of these Nerd Fonts:" -ForegroundColor White
    Write-Host "      • CaskaydiaCove NF (recommended for PowerShell)" -ForegroundColor Gray
    Write-Host "      • MesloLGL Nerd Font" -ForegroundColor Gray
    Write-Host "      • FiraCode Nerd Font" -ForegroundColor Gray
    Write-Host "   3. Your Oh My Posh themes will display correctly with icons and symbols" -ForegroundColor White
}

# Main execution
try {
    Write-Host "=== Oh My Posh Installation Script ===" -ForegroundColor Cyan
    Write-Host "This script will install Oh My Posh and set up your chosen theme.`n" -ForegroundColor White
    
    # STEP 1: Install or check Oh My Posh first (needed for font installation)
    $ohMyPoshInstalled = $false
    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        Write-Host "✅ Oh My Posh is already installed!" -ForegroundColor Green
        $ohMyPoshInstalled = $true
    } else {
        Write-Host "📦 Installing Oh My Posh first (required for font installation)..." -ForegroundColor Yellow
        $installSuccess = Install-OhMyPosh
        if (-not $installSuccess) {
            Write-Host "❌ Oh My Posh installation failed. Exiting." -ForegroundColor Red
            exit 1
        }
       
        # Refresh PATH to make oh-my-posh available
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        $ohMyPoshInstalled = $true
        Write-Host "✅ Oh My Posh installation completed!" -ForegroundColor Green
    }
    
    # STEP 2: Install Nerd Fonts FIRST (priority step)
    if ($ohMyPoshInstalled) {
        Install-NerdFonts
    }
    
    # STEP 3: Configure theme and profile
    $selectedTheme = Select-Theme
    Setup-PowerShellProfile -SelectedTheme $selectedTheme
    
    Write-Host "`n=== Installation Complete! ===" -ForegroundColor Green
    Write-Host "Theme '$selectedTheme' has been configured." -ForegroundColor White
    Write-Host "Please restart your PowerShell session or run: . `$PROFILE" -ForegroundColor Yellow
    Write-Host "`nTips:" -ForegroundColor Cyan
    Write-Host "- Set your terminal font to a Nerd Font for best experience" -ForegroundColor White
    Write-Host "- You can change themes later by editing your profile: $($PROFILE.CurrentUserCurrentHost)" -ForegroundColor White
    Write-Host "- Run 'Get-PoshThemes' to preview all available themes" -ForegroundColor White
    
    # Ask if user wants to reload profile now
    $reloadNow = Read-Host "`nWould you like to reload your PowerShell profile now? (y/n)"
    if ($reloadNow -eq 'y' -or $reloadNow -eq 'Y') {
        . $PROFILE
        Write-Host "Profile reloaded! Your new theme should now be active." -ForegroundColor Green
    }
    
    # STEP 4: Display current configuration
    Show-CurrentConfiguration
}
catch {
    Write-Host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
