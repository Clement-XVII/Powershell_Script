$ListVMs = Import-Csv -Path "F:\stage\salleE03.csv" -Delimiter ";"
$Password = ConvertTo-SecureString "user1" -AsPlainText -Force
foreach ($UneVM in $ListVMs)
{ 

    $NomVm = $UneVM.Machines
	if ($NomVm.length -igt 0)
    {
        
	$Username = "$NomVm\user1"
    	$mycreds = New-Object System.Management.Automation.PSCredential($Username, $Password)
    
    	$Session = New-PSSession -ComputerName $NomVm -Credential $mycreds
    	Invoke-Command -FilePath F:\no.ps1 -Session $Session
	Remove-PSSession -Session $Session
    }

}

<#
$ListVMs = Import-Csv -Path "C:\Users\orion\OneDrive\Bureau\vm_ps_script\PC.csv" -Delimiter ";"
$Password = ConvertTo-SecureString "user1" -AsPlainText -Force
foreach ($UneVM in $ListVMs)
{ 

    $NomVm = $UneVM.Machines
    if ($NomVm.length -igt 0)
    {
        
    
    }

}
#>