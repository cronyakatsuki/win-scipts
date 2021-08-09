Write-Host ""
Write-Host -ForegroundColor Green "Cleanup scoop packages"
Write-Host ""

scoop cleanup *

Write-Host ""
Write-Host -ForegroundColor Green "Cleaning chocolatey packages"
Write-Host ""

sudo choco-cleaner

Write-Host ""
Write-host -ForegroundColor Green "Deleting Rouge folders"
Write-Host ""
    Write-Host -ForegroundColor Yellow "Removing congig.msi"
    if (test-path C:\Config.Msi) {sudo remove-item -Path C:\Config.Msi -force -recurse}
    Write-Host -ForegroundColor Yellow "Removing intel"
	if (test-path c:\Intel) {remove-item -Path c:\Intel -force -recurse}
    Write-Host -ForegroundColor Yellow "Removing Perflogs"
	if (test-path c:\PerfLogs) {remove-item -Path c:\PerfLogs -force -recurse}
    Write-Host -ForegroundColor Yellow "Removing Hp software driver repository"
	if (test-path c:\swsetup) {remove-item -Path c:\swsetup -force -recurse} # HP Software and Driver Repositry
    Write-Host -ForegroundColor Yellow "Removing memory.dmp"
    if (test-path $env:windir\memory.dmp) {remove-item $env:windir\memory.dmp -force}

Write-Host ""
Write-host -ForegroundColor Green "Deleting Windows Error Reporting files"
Write-Host ""
if (test-path C:\ProgramData\Microsoft\Windows\WER) {Get-ChildItem -Path C:\ProgramData\Microsoft\Windows\WER -Recurse | Remove-Item -force -recurse}

Write-Host ""
Write-host -ForegroundColor Green "Removing System and User Temp Files"
Write-Host ""
    Write-Host -ForegroundColor Yellow "Removing windir minidump"
    Remove-Item -Path "$env:windir\minidump\*" -Force -Recurse
    Write-Host -ForegroundColor Yellow "Removing prefetch"
    Remove-Item -Path "$env:windir\Prefetch\*" -Force -Recurse
    Write-Host -ForegroundColor Yellow "Removing local microsoft junk"
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\WER\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\IECompatCache\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\IECompatUaCache\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\IEDownloadHistory\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\INetCache\*" -Force -Recurse
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\INetCookies\*" -Force -Recurse
	Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Terminal Server Client\Cache\*" -Force -Recurse

Write-Host ""
Write-Host -ForegroundColor Green "Checking Component store size"
Write-Host ""

sudo dism /Online /Cleanup-Image /AnalyzeComponentStore

Write-Host ""
while ($true) {
    $yn = Read-Host "Wan't to cleaunup Component store?"
    if ($yn -eq "y" -Or $yn -eq "Y") {
        Write-Host -ForegroundColor Green "Cleaning up Component store"
        sudo dism /online /Cleanup-Image /StartComponentCleanup
        break
    }
    elseif ($yn -eq "n" -Or $yn -eq "N") {
        Write-Host -ForegroundColor Green "Skipping cleanup of component store"
        break
    }
}