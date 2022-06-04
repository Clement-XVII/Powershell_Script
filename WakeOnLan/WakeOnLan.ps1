function Start-One {
    
    begin {
        $CSV = "C:\Users\orion\OneDrive\Bureau\Macs.csv"

        $CSVfile = Read-Host -Prompt "Enter the path of the CSV file ex: C:\test\MAC.csv or press Enter for the default value ($CSV)"
        if (-not($CSVfile)) {
            $CSVfile = $CSV
            Write-Host "$CSVfile `n" -ForegroundColor Green
        }
        elseif ($CSVfile) {
            Write-Host "Configured path: $CSVfile `n" -ForegroundColor Green
        }

        $ListPCs = Get-Content $CSVfile -Encoding UTF8 | ConvertFrom-Csv -Delimiter ";" | select MAC, Noms
        $users = Read-Host -Prompt "Enter the name of Computer/Server"
        foreach ($UnPC in $ListPCs) {
            if ($UnPC -match "$users") {
                $MacAddress = $UnPC.MAC
                echo $MacAddress
            }
        }

        $MacAddress -match '^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$'


        # instantiate a UDP client:
        $UDPclient = [System.Net.Sockets.UdpClient]::new()
    }
    process {
        foreach ($_ in $MacAddress) {
            try {
                $currentMacAddress = $_
        
                # get byte array from mac address:
                $mac = $currentMacAddress -split '[:-]' |
                # convert the hex number into byte:
                ForEach-Object {
                    [System.Convert]::ToByte($_, 16)
                }
 
                #region compose the "magic packet"
        
                # create a byte array with 102 bytes initialized to 255 each:
                $packet = [byte[]](, 0xFF * 102)
        
                # leave the first 6 bytes untouched, and
                # repeat the target mac address bytes in bytes 7 through 102:
                6..101 | Foreach-Object { 
                    # $_ is indexing in the byte array,
                    # $_ % 6 produces repeating indices between 0 and 5
                    # (modulo operator)
                    $packet[$_] = $mac[($_ % 6)]
                }
        
                #endregion
        
                # connect to port 400 on broadcast address:
                $UDPclient.Connect(([System.Net.IPAddress]::Broadcast), 4000)
        
                # send the magic packet to the broadcast address:
                $null = $UDPclient.Send($packet, $packet.Length)
                Write-Verbose "sent magic packet to $currentMacAddress..."
            }
            catch {
                Write-Warning "Unable to send ${mac}: $_"
            }
        }
    }
    end {
        # release the UDF client and free its memory:
        $UDPclient.Close()
        $UDPclient.Dispose()
    }

}


