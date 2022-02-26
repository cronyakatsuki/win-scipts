using namespace System.Management.Automation

powerfetch.ps1

Import-Module PSReadLine

$versionMinimum = [Version]'7.1.999'

if (($Host.Name -eq 'ConsoleHost') -and ($PSVersionTable.PSVersion -ge $versionMinimum))
{
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}
else
{
    Set-PSReadLineOption -PredictionSource History
}

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -Color @{
    "Command" = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator" = [ConsoleColor]::Magenta
    "Variable" = [ConsoleColor]::White
    "String" = [ConsoleColor]::Yellow
    "Number" = [ConsoleColor]::Blue
    "Type" = [ConsoleColor]::Cyan
    "Comment" = [ConsoleColor]::DarkCyan
}

Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
$GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta

$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.DefaultPromptWriteStatusFirst = $true
$GitPromptSettings.BeforePath = '{'
$GitPromptSettings.AfterPath = '}'
$GitPromptSettings.BeforePath.ForegroundColor = 'Red'
$GitPromptSettings.AfterPath.ForegroundColor = 'Red'

function global:PromptWriteErrorInfo() {
    if ($global:GitPromptValues.DollarQuestion) { return }

    if ($global:GitPromptValues.LastExitCode) {
        "`e[31m(" + $global:GitPromptValues.LastExitCode + ") `e[0m"
    }
    else {
        "`e[31m! `e[0m"
    }
}

$global:GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n$(PromptWriteErrorInfo)'

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function lsPretty
{
    lsd -A -L -l $args[0]
}

function mklink 
{
    [string] $original = $args[0]
    [string] $target = $args[1]
    sudo New-Item -ItemType SymbolicLink -Path "$target" -Target "$original"
}

function yta {
    youtube-dl -x -f bestaudio --external-downloader aria2c --external-downloader-args "-j 16 -s 16 -x 16 -k 5M" --audio-format mp3 -o "%(title)s.%(ext)s" $args[0]
}

function ytvb {
    youtube-dl --merge-output-format mp4 -f "bestvideo+bestaudio[ext=m4a]/best" --embed-thumbnail --external-downloader aria2c --external-downloader-args "-j 16 -s 16 -x 16 -k 5M" --add-metadata -o "%(title)s.%(ext)s" $args[0]
}

function ytvf {
    youtube-dl --merge-output-format mp4 --format best --embed-thumbnail --external-downloader aria2c --external-downloader-args "-j 16 -s 16 -x 16 -k 5M" --add-metadata -o "%(title)s.%(ext)s" $args[0]
}

function download {
    Set-Location ~\Downloads
    aria2c -j 16 -s 16 -x 16 -k 5M --file-allocation=none $args[0] 
}

function BlockTheSpot {
    Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1' | Invoke-Expression
}

Set-Alias -Name ls -Value lsPretty
Set-Alias -Name grep -Value rg
Set-Alias -Name ln -Value mklink
Set-Alias -Name vi -Value nvim-qt
