Enable-PSRemoting -SkipNetworkProfileCheck –force
# Set start mode to automatic
Set-Service WinRM -StartMode Automatic
# Verify start mode and state - it should be running
Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}
Set-Item WSMan:localhost\client\trustedhosts -value * -force
# Verify trusted hosts configuration
Get-Item WSMan:\localhost\Client\TrustedHosts

if (Get-Module -ListAvailable -Name BurntToast) {
    Write-Host "Module Hyper-V exists " -ForegroundColor Green
} else {
    Write-Host "Module does not exist " -ForegroundColor Yellow
    Install-PackageProvider -Name NuGet -force
    Install-Module BurntToast -force
    Import-Module BurntToast -force
    }
New-BurntToastNotification -Text "PowerShell Notification" , "Activation réussie !"