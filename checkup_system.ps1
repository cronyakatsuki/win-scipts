Write-Host ""
Write-Host -ForegroundColor "Malware scan using adwcleaner"
Write-Host ""

adwcleaner.exe

Write-Host ""
Write-Host -ForegroundColor Green "Check windows image component store state"
Write-Host ""

sudo DISM /Online /Cleanup-Image /CheckHealth

Write-Host ""
Write-Host -ForegroundColor Green "Check windows image health"
Write-Host ""

sudo DISM /Online /Cleanup-Image /ScanHealth

Write-Host ""
while ($true) {
    $yn = Read-Host "Wan't to restore windows image health"
    if ($yn -eq "y" -Or $yn -eq "Y") {
        Write-Host -ForegroundColor Green "Restoring windows image health"
        sudo DISM /Online /Cleanup-Image /RestoreHealth
        break
    }
    elseif ($yn -eq "n" -Or $yn -eq "N") {
        Write-Host -ForegroundColor Green "Skipping restoring health of windows image"
        break
    }
}

Write-Host ""
Write-Host -ForegroundColor Green "Check windows install"
Write-Host ""

sudo SFC /scannow

Write-Host ""
while ($true) {
    $yn = Read-Host "Wan't to run sfc 2 more times to ensure issues are fixed"
    if ($yn -eq "y" -Or $yn -eq "Y") {
        Write-Host -ForegroundColor Green "1. run"
        sudo SFC /scannow
        Write-Host -ForegroundColor Green "2. run"
        sudo SFC /scannow
        break
    }
    elseif ($yn -eq "n" -Or $yn -eq "N") {
        Write-Host -ForegroundColor Green "Skipping running sfc 2 more times"
        break
    }
}

Write-Host ""
while ($true) {
    $yn = Read-Host "Run disk checker on c disk?"
    if ($yn -eq "y" -Or $yn -eq "Y") {
        Write-Host -ForegroundColor Green "Running disk check on next reboot."
        sudo chkdsk C: /f /r /x
        break
    }
    elseif ($yn -eq "n" -Or $yn -eq "N") {
        Write-Host -ForegroundColor Green "Skipping disk checkup."
        break
    }
}

Write-Host ""
while ($true) {
    $yn = Read-Host "Wan't to restart now?"
    if ($yn -eq "y" -Or $yn -eq "Y") {
        Write-Host -ForegroundColor Green "Restarting"
        shutdown /r
        break
    }
    elseif ($yn -eq "n" -Or $yn -eq "N") {
        Write-Host -ForegroundColor Green "Skipping restarting."
        break
    }
}