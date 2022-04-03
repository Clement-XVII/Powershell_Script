$Application_d = Read-Host -Prompt "Entrer le nom de l'application"
if (-not($Application_d)) {
    Write-Host "$Application_d `n" -ForegroundColor Green
}
elseif ($Application_d) {
    Write-Host "Nom de l'application: $Application_d `n" -ForegroundColor Green
}
$Software = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select DisplayName, UninstallString, Publisher

foreach ($application in $Software) {

    if ($application -match $Application_d) {
        $Name = $Application.DisplayName
        $Uninstall = $Application.UnInstallString
        $NameOrganisation = $Application.Publisher
        Write-Host -ForegroundColor Green "Nom de l'application: " -NoNewline
        Write-Host -ForegroundColor White "$Name"
        Write-Host -ForegroundColor Green "Code Produit: " -NoNewline
        Write-Host -ForegroundColor White "$Uninstall"
        Write-Host -ForegroundColor Green "Nom de l'organisation: " -NoNewline
        Write-Host -ForegroundColor White "$NameOrganisation"`n
    }
}
	