$wmiOS = Get-CimInstance -Class Win32_OperatingSystem
$wmiCS = Get-CimInstance -ClassName Win32_ComputerSystem
$uptime = Get-Uptime
$os = $wmiOS.Caption
$model = $wmiCS.Model
$build = $wmiOS.BuildNumber
$uptimeHours = $uptime.Hours
$uptimeMinutes = $uptime.Minutes
$chocoPackages = choco list -l | Measure-Object -Line
$scoopPackages = scoop.cmd list | Measure-Object -Line
$packages = $($chocoPackages.Lines - 1) + $($scoopPackages.Lines - 3)

Write-Host -ForegroundColor Yellow "$env:username@$env:computername"
Write-Host -ForegroundColor Red "os     " -NoNewline; Write-Host -ForegroundColor DarkCyan "$os"
Write-Host -ForegroundColor Red "host   " -NoNewline; Write-Host -ForegroundColor DarkCyan "$model"
Write-Host -ForegroundColor Red "build  " -NoNewline; Write-Host -ForegroundColor DarkCyan "$build"
Write-Host -ForegroundColor Red "uptime " -NoNewline; Write-Host -ForegroundColor DarkCyan $uptimeHours"h "$uptimeMinutes"m"
Write-Host -ForegroundColor Red "pkgs   " -NoNewline; Write-Host -ForegroundColor DarkCyan "$packages (choco + scoop)"
