$qttabbar_assembly = [Reflection.Assembly]::LoadWithPartialName("QTTabBar")
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -EditMode Emacs
chcp 65001

function Recovery-QTTabBarScripting() {
    # UnregisterChannel
    $channel = [System.Runtime.Remoting.Channels.ChannelServices]::GetChannel("QTTabBarScriptingClient")
    [System.Runtime.Remoting.Channels.ChannelServices]::UnregisterChannel($channel)
    # Set null
    [QTTabBarLib.Scripting].GetField("translator", [System.Reflection.BindingFlags]"nonpublic,static").SetValue($null, $null)
    $qttabbar_assembly.GetType("QTTabBarLib.ScriptingRemoteClient").GetField("fChannelRegistered", "nonpublic,static").SetValue($null, $null)
    $qttabbar_assembly.GetType("QTTabBarLib.ScriptingRemoteClient").GetField("previousPortName", "nonpublic,static").SetValue($null, $null)
    $qttabbar_assembly.GetType("QTTabBarLib.ScriptingRemoteClient").GetField("remoteObject", "nonpublic,static").SetValue($null, $null)
}


$q = New-Object QTTabBarLib.Scripting
$old_prompt = ${function:prompt}

Function Ensure-QTTabBarScripting() {
    if ( $q.ActiveWindow -eq $null -or $q.ActiveWindow.Text -eq $null) {
        recovery-qttabbarscripting
        if ( $q.ActiveWindow.Text -eq $null ) {
            Write-Host "QTTabBarとの接続に失敗しました。PowerShellを再起動してください。" -BackgroundColor DarkRed
            return $false
        }
    }
    return $true;
}

function prompt() {
    if ( $exp_stalker_id -is [System.Int32] ) {
        if ( -not (Ensure-QTTabBarScripting )) {
            &$old_prompt
            return
        }
        $target = $null
        $q.Windows | % { $_.Tabs | % { if ( $_.ID -eq $exp_stalker_id) {
                    $target = $_;
                }
            }
        }



        if ( $target -eq $null) {
            Write-Host "ID:${exp_stalker_id}のタブが見つかりません。追尾中止" -BackgroundColor DarkRed
            $global:exp_stalker_id = $null;
        }
        else { 
            if ( $target.Path -ne (pwd).Path ) {
                if ( $target.Path -ne "" -and -not $target.Path.StartsWith("::")) { 
                    Write-Host "ID:${exp_stalker_id}を追尾しました" -BackgroundColor DarkRed
                    Set-Location $target.Path
                }
                else {
                    Write-Host "ID:$exp_stalker_id($($target.Text))は追跡可能なフォルダにありません。" -BackgroundColor DarkRed
                }

            }
        }
        

    }
    &$old_prompt;
}

function Open-QTTabBar( $location ) {
    if ( $location -eq $null) {
        $location = pwd
    }

    Ensure-QTTabBarScripting
    $tab = $q.OpenGroup("Stalker").ActiveTab  
    $tab.NavigateTo( $location )
    $global:exp_stalker_id = $tab.ID
}

function Set-Location {
    [CmdletBinding()]
    param (
        $path
    )
    PROCESS {
        if ( $path -ne $null) { Microsoft.PowerShell.Management\Set-Location $path }
        if ( $exp_stalker_id -is [System.Int32] ) {
            
            $target = $null
            $q.Windows | % { $_.Tabs | % { if ( $_.ID -eq $exp_stalker_id) {
                        $target = $_;
                    }
                }
            }

            if ( $target -ne $null) {
                $target.NavigateTo( (pwd).Path );
            }
        }
    }
}

function pcd(){

}

filter grep($keyword, $context = (0, 0)) {
    $_ | Out-String -Stream | Select-String -Pattern $keyword -Context $context
}
