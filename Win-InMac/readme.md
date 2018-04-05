1. Mac上で~/srcにレポジトリをclone
2. 必要に応じてWindowsのメモリ割り当てを大きめにしておく
1. Paralells上でsrcを共有フォルダにマウント
1. 管理者でPowerShellを開く
1. `net use v: \\psf\src`
1. `cd v:\dotfiles\Win-InMac\`
1. `powershell -ExecutionPolicy Unrestricted .\init.ps1`