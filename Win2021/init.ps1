Import-Module Appx
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
    "Microsoft.MicrosofntSolitaireCollection",
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

# win feature
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart All
