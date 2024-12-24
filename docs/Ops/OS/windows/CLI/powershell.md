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

## Install oh-my-posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

## Clone oh-my-posh Themes

- git clone [**without-my-custom-theme**](https://github.com/JanDeDobbeleer/oh-my-posh.git)

## Active Custom Theme

notepad++ $profile

```powershell
oh-my-posh init pwsh --config C:\Users\mehrdad\oh-my-posh\themes\mehrdad.omp.json | Invoke-Expression
```

## Fish-like Autosuggestion in Powershell

### Installation

I. First, install ´PSReadLine´ version 2.1.0

```powershell
   Install-Module PSReadLine -RequiredVersion 2.1.0
```

II. Then, initialize it with the command below(notepad $profile)

```powershell
   Import-Module PSReadLine
   Set-PSReadLineOption -PredictionSource History
```
