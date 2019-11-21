Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -EditMode Emacs
Import-Module posh-git
function cde() {
    $shell = New-Object -ComObject Shell.Application
    $exps = $shell.Windows() | Select-Object @{Name = "Name"; expression = {$_.LocationName} } , @{Name = "Path"; expression = {([uri]$_.LocationURL).LocalPath} } | 
        Where-Object {$null -ne $_.Path}
    $exps | ForEach-Object { "({0}) {1}`0{1}" -f $_.Name, $_.Path} | peco --null | Set-Location
}

function cdg() {
    es $(git config --global ghq.root)"*\.git" | split-path | peco | Set-Location
}

function ghqc() {
    $token = cat ~\.config\hub | wsl ~/.asdf/installs/python/anaconda3-2019.03/bin/yq -r '.[][0].oauth_token'
    $json = curl.exe -u KageShiron:$token  "https://api.github.com/user/repos" | ConvertFrom-Json
    $obj = $json | ForEach-Object{
        if ( $_.private )
        {
            "[鍵] $( $_.full_name )`0$($_.full_name)"
        }else{
            "$( $_.full_name )`0$($_.full_name)"
        }
    }
    echo $obj | peco --null | %{ ghq get $_ }
}

function Invoke-PecoHistory() {
    Get-Content (Get-PSReadlineOption).HistorySavePath -Encoding UTF8 | peco --prompt "history>" --initial-index 9999 --layout bottom-up --print-query | Invoke-Expression
    Clear-Host
}

Set-PSReadlineKeyHandler -Chord "Ctrl+]" -ScriptBlock { cdg ; break }
Set-PSReadlineKeyHandler -Chord "Ctrl+r" -ScriptBlock { Invoke-PecoHistory}
