Write-Host ""
Write-Host -ForegroundColor Green "Cleanup scoop packages"
Write-Host ""

scoop cleanup *

Write-Host ""
Write-Host -ForegroundColor Green "Cleaning chocolatey packages"
Write-Host ""

sudo choco-cleaner