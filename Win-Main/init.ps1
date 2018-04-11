
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

##### STEP1 privilege and policy #####
if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "Please run as an admin.";
    exit;
}
Set-ExecutionPolicy RemoteSigned

cd c:\s\dotfiles
git remote remove origin
git remote add origin git@github.com:KageShiron/dotfiles
cd c:\s\dotfiles\Win-Main

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
    "Microsoft.MicrosofntSolitaireCollection",
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

Get-AppxPackage | where { -not $_.IsFramework -and $_.SignatureKind -eq "Store" -and $_.Name -in $removeapp -and $_.Name -ne "Microsoft.Store" } `
    | Remove-AppxPackage


##### STEP3 Install Packages #####
Install-PackageProvider nuget -Force
Install-PackageProvider psl -Force

# posh-git
Install-Module posh-git -Force

# chocolatey
[Environment]::SetEnvironmentVariable("ChocolateyInstall", "c:\a", 'User')
[Environment]::SetEnvironmentVariable("ChocolateyInstall", "c:\a", 'Machine')
$env:ChocolateyInstall = "c:\a"
echo $env:ChocolateyInstall\lib\
if ( -not (Get-Command "choco" -errorAction SilentlyContinue)) {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
C:\a\bin\RefreshEnv.cmd
cup --limitoutput --no-progress -y all
cinst --limitoutput --no-progress -y packages.config
C:\a\bin\RefreshEnv.cmd

# mkdir
if ( -not ( Test-Path ~/.vimrc )) { 
    cmd /c (("mklink `"%userprofile%/.vimrc`" `"") + (Resolve-Path ../.vimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.gvimrc )) {
    cmd /c (("mklink `"%userprofile%/.gvimrc`" `"") + (Resolve-Path ../.gvimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.vim )) { mkdir ~/.vim }
if ( -not ( Test-Path "c:/b" )) { mkdir "c:/b" }
if ( -not ( Test-Path "c:/b/vim" )) { mkdir "c:/b/vim" }
if ( -not ( Test-Path ~/.vim/dein.toml ) ) {
    cmd /c (("mklink `"%userprofile%/.vim/dein.toml`" `"") + (Resolve-Path ../dein.toml).Path + "`"") 
}
if ( -not ( Test-Path "C:/tools/cmder/vendor/conemu-maximus5") ) {  
    cmd /c ("mklink `"C:/tools/cmder/vendor/conemu-maximus5`" `"C:/src/dotfiles/Windows/ConEmu.xml`"")
}

# go
$gopath = go env GOPATH
AddPath($gopath);
refreshenv
go get github.com/mattn/sudo
go get github.com/mattn/goemon/cmd/goemon
go get github.com/koron/netupvim
cd c:/b/vim
netupvim
AddPath("c:/b/vim");

# win feature
Enable-WindowsOptionalFeature -Online -FeatureName -NoRestart Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName -NoRestart Microsoft-Hyper-V-All

##### STEP4 Make links #####
$conemu = "C:/tools/cmder/config/user-ConEmu.xml"
if( -not (test-path $conemu)){ rm $conemu };
cp "$PSScriptRoot/user-ConEmu.xml" $conemu

$prof = "C:\tools\cmder\config\user-profile.ps1";
if( -not (test-path $prof) ){ rm $prof };
cmd /c ("mklink `"$prof`" `"$PSScriptRoot/user-profile.ps1`"")

$gji = "$env:userprofile\AppData\LocalLow\Google\Google Japanese Input\config1.db";
if( -not (test-path $prof) ){ rm $gji };
cmd /c ("mklink `"$gji`" `"$PSScriptRoot/config1.db`"")

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

##### STEP5 Registories #####
Set-ItemProperty "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Search/" "SearchboxTaskbarMode" 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSmallIcons" 1