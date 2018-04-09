
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

Get-AppxPackage | where { -not $_.IsFramework -and $_.SignatureKind -eq "Store" -and $_.Name -in $removeapp -and $_.Name -ne "Microsoft.Store" } `
    | Remove-AppxPackage


##### STEP3 Install Packages #####
Install-PackageProvider nuget
Install-PackageProvider psl

# posh-git
Install-Module posh-git

# chocolatey
[Environment]::SetEnvironmentVariable("ChocolateyInstall", "c:\a", 'User')
[Environment]::SetEnvironmentVariable("ChocolateyInstall", "c:\a", 'Machine')
$env:ChocolateyInstall = "c:\a"
echo $env:ChocolateyInstall\lib\
if ( -not (Get-Command "choco" -errorAction SilentlyContinue)) {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
C:\a\bin\RefreshEnv.cmd
cup -y all
cinst -y packages.config
C:\a\bin\RefreshEnv.cmd

# mkdir
if ( -not ( Test-Path ~/.vimrc )) { 
    cmd /c (("mklink `"%userprofile%/.vimrc`" `"") + (Resolve-Path ../.vimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.gvimrc )) {
    cmd /c (("mklink `"%userprofile%/.gvimrc`" `"") + (Resolve-Path ../.gvimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.ssh )) { cmd /c "mklink /d `"%userprofile%/.ssh`" `"c:/g/sync/ssh`"" }
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
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

##### STEP4 Make links #####
rm "C:/tools/cmder/config/user-ConEmu.xml";
cp "$PSScriptRoot/user-ConEmu.xml" "C:/tools/cmder/config/user-ConEmu.xml"

rm  "C:/tools/cmder/config/user-profile.ps1";
cmd /c ("mklink `"C:/tools/cmder/config/user-profile.ps1`" `"$PSScriptRoot/user-profile.ps1`"")

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
