# Integrate pwsh with gdb-dashboard
## Prerequisites
- Powershell (v7+)
- gdb-dashboard (.gdbinit)
## Setup 
- clone ```.gdbinit``` file from [gdb-dashboard](https://github.com/cyrus-and/gdb-dashboard.git) and copy it to gdb config folder.
(default path: ~/.config/gdb/)
```bash
git clone https://github.com/cyrus-and/gdb-dashboard.git
cp ./gdb-dashboard/.gdbinit ~/.config/gdb/
```

- Setting up scripts to pipe dashboard output to file, and print in the other powershell
> ```gdb-dashboard.ps1```
> ```powershell
> param($filename)
>
> # Modify this line to change the default layout for gdb-dashboard
> $layout = "dashboard -layout assembly source threads breakpoints variables 
> New-Item ./.tmp
> Write-Output $filename > ./.tmp
> Start-Process -FilePath pwsh.exe -ArgumentList <absolute_path>/read_filestream.ps1
> gdb.exe -ex "dashboard -output ./.tmp" -ex $layout $filename
> Remove-Item ./.tmp
> ```
> Replace <absolute_path> to the actual location of ```read_filestream.ps1```

> ```read_filestream.ps1```
> ```powershell
> $filePath = ".\.tmp"
> Get-Content $filePath -Wait
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
