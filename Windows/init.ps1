
if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    echo "Please run as an admin.";
    exit;
}

Set-ExecutionPolicy RemoteSigned
Install-Module posh-git

# chocolatey install
if ( -not (Get-Command "choco" -errorAction SilentlyContinue)) {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

cinst -y $args[0]
cup -y all

# load cert for ruby
if ( -not (Test-Path ~/.ssl/cacert.pem) ) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    [Environment]::SetEnvironmentVariable('SSL_CERT_FILE', ($env:userprofile + ''), 'User')
}

# init dir
if ( -not ( Test-Path ~/.vimrc )) { 
    cmd /c (("mklink `"%userprofile%/.vimrc`" `"") + (Resolve-Path ../.vimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.gvimrc )) {
    cmd /c (("mklink `"%userprofile%/.gvimrc`" `"") + (Resolve-Path ../.gvimrc).Path + "`"") 
}
if ( -not ( Test-Path ~/.ssh )) { cmd /c "mklink /d `"%userprofile%/.ssh`" `"c:/gd/sync/ssh`"" }
if ( -not ( Test-Path ~/.vim )) { mkdir ~/.vim }
if ( -not ( Test-Path "c:/app" )) { mkdir "c:/app" }
if ( -not ( Test-Path "c:/app/vim" )) { mkdir "c:/app/vim" }
if ( -not ( Test-Path ~/.vim/dein.toml ) ) {
    cmd /c (("mklink `"%userprofile%/.vim/dein.toml`" `"") + (Resolve-Path ../dein.toml).Path + "`"") 
}
if ( -not ( Test-Path "C:/tools/cmder/vendor/conemu-maximus5") ) {  
    cmd /c ("mklink `"C:/tools/cmder/vendor/conemu-maximus5`" `"C:/src/dotfiles/Windows/ConEmu.xml`"")
}

$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
$path2 = [Environment]::GetEnvironmentVariable('PATH', 'User')
$env:path = $path + ";" + $path2;

$gopath = go env GOPATH
AddPath($gopath);

yarn global add -g typescript webpack vue-cli
gem install rubygems-update --source http://rubygems.org/
update_rubygems
gem install --conservative bundle jekyll

go get github.com/mattn/sudo
go get github.com/mattn/goemon/cmd/goemon
go get github.com/koron/netupvim
cd c:/app/vim
netupvim
AddPath("c:/app/vim");

tlmgr update --self —all
tlmgr install collection-langjapanese collection-luatex collection-latexextra minted latexmk
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

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