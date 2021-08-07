Write-Host ""
Write-Host -ForegroundColor Green "Updating scoop packages"
Write-Host ""
scoop update *

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating chocolatey packages"
Write-Host ""
sudo choco upgrade all -y

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating python packages"
Write-Host ""
pip freeze | ForEach-Object{$_.split('==')[0]} | ForEach-Object{pip install --upgrade $_}

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating anime downloader from github"
pip3 install -U git+https://github.com/vn-ki/anime-downloader.git --user
Write-Host ""


Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating rustup"
rustup self update
Write-Host ""

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating rust"
rustup update
Write-Host ""

Write-Host ""
Write-Host ""
write-host -ForegroundColor Green "Check for windows updates"
Write-Host ""
C:\Windows\System32\control.exe /name Microsoft.WindowsUpdate