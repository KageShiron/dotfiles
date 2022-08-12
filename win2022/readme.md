1. ディスプレイ等の設定
2. `wsl install`
3. `winget install gerardog.gsudo`
4. winget.jsonを落として、特権でインストール（このタイミングではgsudoにパスが通らない)
`C:\Program Files (x86)\gsudo\gsudo.exe winget import winget.json --accept-package-agreements --accept-source-agreements`
5. 「開発者」と検索し、エクスプローラの設定、ターミナル設定、PowerShell設定を実行
6. 再起動

## アプリ設定
* いらないソフトをuninstall
* StoreとWindows Update
* Google Drive
* XMBCのxmlをimport
* Firefoxログイン
* wtでスタートアップをpwshに。