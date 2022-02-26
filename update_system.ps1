Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating chocolatey packages"
Write-Host ""
sudo choco upgrade all -y

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating scoop packages"
Write-Host ""
scoop update *

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating npm packages"
Write-Host ""
npm update -g

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating python pip"
Write-Host ""
python -m pip install --upgrade pip

Write-Host ""
Write-Host ""
Write-Host -ForegroundColor Green "Updating python packages"
Write-Host ""
pip freeze | ForEach-Object{$_.split('==')[0]} | ForEach-Object{pip install --upgrade $_}

python -m pip install git+https://www.github.com/justfoolingaround/animdl

Write-Host ""
Write-Host ""
write-host -ForegroundColor Green "Check for windows updates"
Write-Host ""
C:\Windows\System32\control.exe /name Microsoft.WindowsUpdate
