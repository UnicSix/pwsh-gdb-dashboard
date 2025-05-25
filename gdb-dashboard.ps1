param($filename)

$layout = "dashboard -layout source threads breakpoints"

New-Item ./.tmp

Write-Output "Debugging: $filename" > ./.tmp

Start-Process -FilePath pwsh.exe -ArgumentList I:\Study\PwshScript\pipeserver\read_filestream.ps1
gdb.exe -ex "dashboard -output ./.tmp" -ex $layout $filename

Remove-Item ./.tmp
