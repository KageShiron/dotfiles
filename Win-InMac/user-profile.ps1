Set-PSReadlineKeyHandler -Key Tab -Function Complete
filter grep($keyword, $context = (0, 0)) {
    $_ | Out-String -Stream | Select-String -Pattern $keyword -Context $context
}
