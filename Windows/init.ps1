if( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
        {
            echo "Please run as an admin.";
            exit;
        }

cinst packages.config

if( -not ( Test-Path ~/.vimrc )){ cmd /c "mklink `"%userprofile%/.vimrc`" `"../.vimrc`"" }
if( -not ( Test-Path ~/.gvimrc )){ cmd /c "mklink `"%userprofile%/.vimrc`" `"../.gvimrc`"" }
if( -not ( Test-Path ~/.ssh )){ cmd /c "mklink /d `"%userprofile%/.ssh`" `"c:/gd/sync/ssh`"" }([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")