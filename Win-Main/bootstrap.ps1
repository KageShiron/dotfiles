<#

iex ((new-object net.webclient).DownloadString('https://cdn.rawgit.com/KageShiron/dotfiles/master/Win-Main/bootstrap.ps1')) 2>&1 | tee ~/${(Get-Date).ToString("yyyyMMdd")}.log

#>

if ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    echo "Please run as an admin.";
    exit;
}
Set-ExecutionPolicy RemoteSigned

function Add-FullControl( $folder_path ) {
    $fc_user_name = 'Users'
    $acl = Get-Acl $folder_path
    $permission = ($fc_user_name, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
    # 引数：ユーザー名,アクセス権,下位フォルダへ継承,下位オブジェクトへ継承,継承の制限,アクセス許可
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl $folder_path
}

$env:ChocolateyInstall = "c:\a"
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
cinst -y --no-progress git

mkdir c:\s
git clone https://github.com/KageShiron/dotfiles.git c:\s\dotfiles

Add-FullControl c:\a
Add-FullControl c:\s

& c:\s\dotfiles\Win-Main\init.ps1