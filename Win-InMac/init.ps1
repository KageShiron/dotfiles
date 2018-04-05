##### STEP1 privilege and policy #####
if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    echo "Please run as an admin.";
    exit;
}
Set-ExecutionPolicy RemoteSigned

##### STEP2 Remove needless UWP #####
$removeapp = @(
    "Microsoft.XboxIdentityProvider",
#    "Microsoft.DesktopAppInstaller",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.Print3D",
    "Microsoft.Xbox.TCUI",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.ZuneVideo",
#    "Microsoft.WindowsCalculator",
#    "Microsoft.WindowsStore",
    "Microsoft.XboxGameOverlay",
    "Microsoft.Wallet",
    "Microsoft.BingWeather",
    "Microsoft.MicrosoftSolitaireCollection",
#    "Microsoft.WindowsFeedbackHub",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.OneConnect",
    "Microsoft.Office.OneNote",
#    "Microsoft.People",
    "Microsoft.Messaging",
    "Microsoft.Getstarted",
    "Microsoft.GetHelp",
    "Microsoft.WindowsAlarms",
#    "Microsoft.StorePurchaseApp",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.SkypeApp",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsMaps",
    "Microsoft.Windows.Photos",
    "Microsoft.XboxApp",
    "Microsoft.MSPaint",
    "microsoft.windowscommunicationsapps",
    "Microsoft.ZuneMusic",
    "828B5831.HiddenCityMysteryofShadows",
    "89006A2E.AutodeskSketchBook",
    "A278AB0D.MarchofEmpires",
    "DolbyLaboratories.DolbyAccess",
    "Microsoft.BingNews",
    "SpotifyAB.SpotifyMusic",
    "king.com.BubbleWitch3Saga",
    "king.com.CandyCrushSodaSaga"
);

Get-AppxPackage | where { -not $_.IsFramework -and $_.SignatureKind -eq "Store" -and $_.Name -in $removeapp -and $_.Name -neq "Microsoft.Store" }

Install-PackageProvider nuget -Force
Install-PackageProvider psl -Force

##### STEP4 Install Packages #####

# posh-git
Install-Module posh-git
Install-Module PSReadLine

# chocolatey
if ( -not (Get-Command "choco" -errorAction SilentlyContinue)) {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
cup -y all
cinst -y packages.config

# go
$gopath = go env GOPATH
AddPath($gopath);
refreshenv
go get github.com/mattn/sudo

##### STEP5 Make links #####
if ( -not ( Test-Path "C:/tools/cmder/vendor/conemu-maximus5") ) {  
    cmd /c ("mklink `"C:/tools/cmder/vendor/conemu-maximus5`" `"$PSScriptRoot/ConEmu.xml`"")
}



function AddPath( $addpath ) {
    $path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
    $path2 = [Environment]::GetEnvironmentVariable('PATH', 'User')
    $addpath = (Resolve-Path $addpath).Path
    if ( -not $path.contains($addpath) ) {
        $path += ';' + $addpath;
    }
    [Environment]::SetEnvironmentVariable('PATH', $path, 'Machine')
    $env:path = $path + ";" + $path2
}