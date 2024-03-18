# Windows Subsystem for Android™️

## Download and Install

### WSA

- Follow [this link](https://allthings.how/how-to-download-windows-subsystem-for-android-without-microsoft-store-msixbundle/) to download and install "Windows Subsystem for Android" in secure way

### ADB

- You can also install `ADB` from [this link](https://developer.android.com/tools/releases/platform-tools) for _test_ and _debug_

### Document

- Official Microsoft documentation for [WSA](https://learn.microsoft.com/en-us/windows/android/wsa/)

### Commands

- To connect/disconnect to the Windows Subsystem for Android™️ VM for debugging

  ```powershell
  adb connect 127.0.0.1:58526
  adb disconnect [HOST[:PORT]]
  ```

- For install `apk` from windows

  ```powershell
  adb install pckg.apk
  ```

### Security

- Block `ntp.msn.com` domain using Nekoray
