# PowerShell

## Commands

### Find binary location like unix `which`

> - gcm \<latex\> | select Source

## Config

### Set alias for powershell

- get the list of aliases

  ```powershell
  gal
  ```

### set new alias

- **Set Temporary**

  ```powershell
  Set-Alias -Name tf -Value terrafrom
  ```

- **Set Permanently**

  ```powershell
  notepad++ C:\Users\mehrdad\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
  add Set-Alias -Name ...  line
  ```

### Remove an exist alias

```powershell
Remove-Item Alias:tf
```

### Disable `bell` alert in terminal

> open the `json` file in setting section  
> add this `key & value` to json file

```json
 "profiles":
    {
        "defaults":
        {
            "bellStyle": "none",
             ...
```

### Active powershell profile

```powershell
Set-ExecutionPolicy RemoteSigned
```

### Install oh-my-posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### Clone oh-my-posh Themes

- git clone [**without-my-custom-theme**](https://github.com/JanDeDobbeleer/oh-my-posh.git)
- copy [**with custom theme `mehrdad`**](oh-my-posh/ "with-my-custom-theme")

### Active Custom Theme

> notepad++ $profile

```powershell
oh-my-posh init pwsh --config C:\Users\mehrdad\oh-my-posh\themes\mehrdad.omp.json | Invoke-Expression
```

### Fish-like Autosuggestion in Powershell

#### Installation

1. First, install ´PSReadLine´ version 2.1.0

```powershell
   Install-Module PSReadLine -RequiredVersion 2.1.0
```

2. Then, initialize it with the command below(notepad $profile)

```powershell
   Import-Module PSReadLine
   Set-PSReadLineOption -PredictionSource History
```
