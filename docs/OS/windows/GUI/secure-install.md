# Install Windows the Arch Linux Way

## [According from this link][docreflnk]

### From boatloader disk/flash

Shift+F10

```powershell
diskpart
...
```

```powershell
DISM /Get-ImageInfo /imagefile:d:\sources\install.wim
DISM /apply-image /imagefile:d:\sources\install.wim /index:6 /applydir:c:
```

### Bring back my computer icon

Execute one of these commands into the `run`

```powershell
'desk.cpl ,5 or rundll32.exe, shell32.dll, Control_RunDLL desk.cpl,,0'
```

### Tweaks

```powershell
irm christitus.com/win | iex
```

### Block these domain as well as this [source]

```powershell
127.0.0.1   msftconnecttest.com
127.0.0.1   azureedge.net
127.0.0.1   activity.windows.com
127.0.0.1   bingapis.com
127.0.0.1   msedge.net
127.0.0.1   assets.msn.com
127.0.0.1   scorecardresearch.com
127.0.0.1   edge.microsoft.com
127.0.0.1   data.msn.com
```

## Install Windows 11 to Unsupported PC

- [Link #1]

<!-- links -->
[docreflnk]: https://christitus.com/install-windows-the-arch-linux-way
[source]: https://www.youtube.com/watch?v=IJr2DcffquI
[Link #1]: https://pureinfotech.com/install-windows-11-unsupported-pc/amp/
