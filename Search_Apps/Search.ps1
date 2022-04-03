$Application_d = Read-Host -Prompt "Enter the application name"
if (-not($Application_d)) {
    Write-Host "$Application_d `n" -ForegroundColor Green
}
elseif ($Application_d) {
    Write-Host "Enter the application name: $Application_d `n" -ForegroundColor Green
}
$Software = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select DisplayName, UninstallString, Publisher

foreach ($application in $Software) {

    if ($application -match $Application_d) {
        $Name = $Application.DisplayName
        $Uninstall = $Application.UnInstallString
        $NameOrganisation = $Application.Publisher
        Write-Host -ForegroundColor Green "Application name: " -NoNewline
        Write-Host -ForegroundColor White "$Name"
        Write-Host -ForegroundColor Green "Uninstall string: " -NoNewline
        Write-Host -ForegroundColor White "$Uninstall"
        Write-Host -ForegroundColor Green "Organization name: " -NoNewline
        Write-Host -ForegroundColor White "$NameOrganisation"`n
    }
}