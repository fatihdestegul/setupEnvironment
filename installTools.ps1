(new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1', 'C:\Windows\Temp\install.ps1')

$env:chocolateyUseWindowsCompression = 'false'
for ($try = 0; $try -lt 5; $try++) {
  & C:/Windows/Temp/install.ps1
  if ($?) { break }
  if (Test-Path C:\ProgramData\chocolatey) { break }
  Write-Host "Failed to install chocolatey (Try #${try})"
  Start-Sleep 2
}

Start-Process choco -ArgumentList  "feature enable -n useFipsCompliantChecksums" -Wait -NoNewWindow

# Install Programs
Start-Process choco -ArgumentList "feature enable -n allowGlobalConfirmation"
Start-Process choco -ArgumentList "install git -y"