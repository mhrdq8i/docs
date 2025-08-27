# PowerShell

## Find binary location like unix `which`

```powershell
gcm \<latex\> | select Source
```

## Restart Session

```powershell
. $PROFILE
or
powershell.exe -noprofile
```

## Update powershell

Open powershell in administrative mode and enter this command

```powershell
winget upgrade powershell
```

## Alias for Powershell

### Get List

```powershell
gal
```

### Set an Alias

Temporary

```powershell
Set-Alias -Name tf -Value terrafrom
```

Set powershell profile config `C:\Users\<YourUsername>\Documents\PowerShell\profile.ps1`

```powershell
notepad++ C:\Users\mehrdad\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
add Set-Alias -Name ...  line
```

### Remove an Alias

```powershell
Remove-Item Alias:tf
```

## Disable `Bell` alert in terminal

- open the `json` file in setting section
- add this `key & value` to json file

```json
 "profiles":
    {
        "defaults":
        {
            "bellStyle": "none",
             ...
```

## Active powershell profile

```powershell
Set-ExecutionPolicy RemoteSigned
```

## Fish-like Autosuggestion in Powershell

I. First, install ´PSReadLine´ version 2.1.0

```powershell
   Install-Module PSReadLine -RequiredVersion 2.1.0
```

II. Then, initialize it with the command below(notepad $profile)

```powershell
   Import-Module PSReadLine
   Set-PSReadLineOption -PredictionSource History
```

## oh-my-posh

## Installation Script

Curl this file to install oh-my-posh with it's fonts and themes

```powershell
curl -o install-oh-my-posh.ps1 https://raw.githubusercontent.com/mhrdq8i/docs/master/docs/OS/windows/pwsh_scripts/install-oh-my-posh.ps1
```

### Installation

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### Clone oh-my-posh Themes

- git clone [**without-my-custom-theme**](https://github.com/JanDeDobbeleer/oh-my-posh.git)

## Active Custom Theme

Show the path of the current profile

```pwsh
echo $PROFILE
```

Open the active profile

```pwsh
notepad++ $profile
```

Edit these lines

```pwsh
oh-my-posh init pwsh --config C:\Users\mehrdad\oh-my-posh\themes\mehrdad.omp.json | Invoke-Expression
```

### Language Segment

- [Python](https://ohmyposh.dev/docs/segments/languages/python)
- [Rust](https://ohmyposh.dev/docs/segments/languages/rust)
