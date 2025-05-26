# Integrate pwsh with gdb-dashboard
## Prerequisites
- Powershell (v7+)
- gdb-dashboard (.gdbinit)
## Setup 
- clone ```.gdbinit``` file from [gdb-dashboard](https://github.com/cyrus-and/gdb-dashboard.git) and copy it to gdb config folder.
(default path: "~/.config/gdb/" or "~/")
```bash
git clone https://github.com/cyrus-and/gdb-dashboard.git
cp ./gdb-dashboard/.gdbinit ~/.config/gdb/
```

- Setting up scripts to pipe dashboard output to file, and print in the other powershell
- You can also clone the repo like using gdb-dashboard
> ```gdb-dashboard.ps1```
> ```powershell
> param($filename)
> 
> $layout = "dashboard -layout variables threads breakpoints"
> 
> if(Test-Path -Path ./.tmp) {
>   Remove-Item ./.tmp
> }
> New-Item ./.tmp
> 
> Write-Output "Debugging: $filename" > ./.tmp
> 
> Start-Process -FilePath pwsh.exe -ArgumentList I:\Study\PwshScript\pipeserver\read_filestream.ps1
> gdb.exe -ex "dashboard -output ./.tmp" -ex $layout $filename
> 
> Remove-Item ./.tmp
> ```
> Replace <absolute_path> to the actual location of ```read_filestream.ps1```

> ```read_filestream.ps1```
> ```powershell
> $filepath = ".\.tmp"
> 
> $previous_content = Get-Content $filepath -Raw
> Write-Output $previous_content
> 
> while(Test-Path -Path $filepath) {
>   $current_content = Get-Content $filepath -Raw
>   if($current_content -ne $previous_content) {
>     Write-Output $current_content
>     $previous_content = $current_content
>   }
>   Start-Sleep -Milliseconds 500
> }
> ```

- You should have directory structure like this:
```
somewhere_folder/
|- gdb-dashboard.ps1
|- read_filestream.ps1
```
- Add ```somewhere_folder``` to $PATH to run the ```gdb-dashboard.ps1``` from powershell directly.
## Usage
- Change working directory to where executable file exists.
```bash
cd <working_directory>
```
- Run the ```gdb-dashboard.ps1``` with executable filename.
```powershell
gdb-dashboard.ps1 filename.exe
```
- It should startup a new powershell that showing the debugging filename
![image](https://hackmd.io/_uploads/r1QMlU1Ggl.png)
- Do whatever you want with gdb and start the debug process.
![image](https://hackmd.io/_uploads/rJy3gUkzxx.png)
- The extra powershell will terminate automatically after quitting gdb.
