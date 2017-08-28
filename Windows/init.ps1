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
cinst -y packages.config
cup -y all

# load cert for ruby
if ( -not (Test-Path ~/.ssl/cacert.pem) ) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    [Environment]::SetEnvironmentVariable('SSL_CERT_FILE', ($env:userprofile + ''), 'User')
}

npm install -g typescript typings webpack react react-dom babel-loader babel-core vue-cli
gem install rubygems-update --source http://rubygems.org/
update_rubygems
gem install bundle jekyll


Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if ( -not ( Test-Path ~/.vimrc )) { cmd /c (("mklink `"%userprofile%/.vimrc`" `"") + (Resolve-Path ../.vimrc).Path + "`"") }
if ( -not ( Test-Path ~/.gvimrc )) { cmd /c (("mklink `"%userprofile%/.gvimrc`" `"") + (Resolve-Path ../.gvimrc).Path + "`"") }
if ( -not ( Test-Path ~/.ssh )) { cmd /c "mklink /d `"%userprofile%/.ssh`" `"c:/gd/sync/ssh`"" }
if ( -not ( Test-Path ~/.vim )) { mkdir ~/.vim }
if ( -not ( Test-Path "c:/app" )) { mkdir "c:/app" }
if ( -not ( Test-Path ~/.vim/dein.toml ) ) {  cmd /c (("mklink `"%userprofile%/.vim/dein.toml`" `"") + (Resolve-Path ../dein.toml).Path + "`"") }

go get github.com/mattn/sudo
go get github.com/mattn/goemon/cmd/goemon
go get github.com/koron/netupvim
cd c:\app
netupvim


tlmgr update --self —all
tlmgr install collection-langjapanese collection-luatex collection-latexextra minted latexmk