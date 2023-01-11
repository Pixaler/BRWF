function downloadyt {
    Write-Host "---Delete previous apk files---"
    Write-Host "."
    Remove-Item youtube1.apk
    Write-Host "."
    Write-Host "---Download YT---"
    $linkyt = ((Invoke-WebRequest -Uri 'https://android.biblprog.org.ua/ru/youtube/download/').Links | Where href -like "*youtube_17.49.37.apk*").href
    Write-Host "."
    Write-Host "."
    Write-Host "Wait"
    .\wget\wget.exe $linkyt -O youtube1.apk
}

function downloadrevanced {
# Delete old files
    Write-Host "---Delete previous files---"
    Write-Host "."
    Write-Host "."
    Remove-Item revanced*.dex
    Remove-Item revanced*.jar
    Remove-Item revanced*.apk

# Download ReVanced Integrations
    Write-Host "---Download ReVanced Integrations---"
    Write-Host "."
    Write-Host "."
    $LinkRI = 'https://api.github.com/repos/revanced/revanced-integrations/releases/latest'   
    $DownloadLinkRI = (((Invoke-WebRequest $LinkRI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-integrations').Line
    .\wget\wget.exe --content-disposition $DownloadLinkRI -O revanced-integrations.apk
    Start-Sleep -Seconds 5

# Download ReVanced Patches
    Write-Host "---Download ReVanced Patches---"
    Write-Host "."
    Write-Host "."
    $LinkRCLI = 'https://api.github.com/repos/revanced/revanced-patches/releases/latest'   
    $downloadLinkRCLI = (((Invoke-WebRequest $LinkRCLI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-patches').Line
    .\wget\wget.exe --content-disposition $downloadLinkRCLI -O revanced-patches.jar
    Start-Sleep -Seconds 5

# Download ReVanced CLI
    Write-Host "---Download ReVanced CLI---"
    Write-Host "."
    Write-Host "."
    $LinkRCLI = 'https://api.github.com/repos/revanced/revanced-cli/releases/latest'   
    $DownloadLinkRCLI = (((Invoke-WebRequest $LinkRCLI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-cli').Line
    .\wget\wget.exe --content-disposition $DownloadLinkRCLI -O revanced-cli-all.jar
    Remove-Item revanced*.dex
    Start-Sleep -Seconds 5
}

function ytroot {
    Write-Host "---Uninstalling YouTube---"
    Write-Host "."
    Write-Host "."
    .\platform-tools\adb.exe -s $adb uninstall com.google.android.youtube
    Write-Host "---Installing YouTube---"
    Write-Host "."
    Write-Host "."
    .\platform-tools\adb.exe -s $adb install youtube1.apk
    Write-Host "---Build Youtube ReVanced Root---"
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app in your phone"
    .\zulu17\bin\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d $adb -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --experimental --mount
    Read-Host -Prompt "Press Enter to continue"
}

function ytnonroot {
    Write-Host "---Uninstalling YouTube---"
    Write-Host "."
    Write-Host "."
    .\platform-tools\adb.exe -s $adb uninstall com.google.android.youtube
    Write-Host "---Installing Vanced Microg---"
    Write-Host "."
    Write-Host "."
    .\platform-tools\adb.exe -s $adb install microg.apk
    Write-Host "---Installing YouTube---"
    Write-Host "."
    Write-Host "."
    .\platform-tools\adb.exe -s $adb install youtube1.apk
    Write-Host "---Build Youtube ReVanced Non-Root---"
    Write-Host "."
    Write-Host "."
    Write-Host "If display any warning that prevent instaling app through ADB - apply it!"
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app in your phone"
    .\zulu17\bin\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d $adb -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --experimental
    Read-Host -Prompt "Press Enter to continue"
}

$java = Test-Path -Path .\zulu17\bin\java.exe -PathType Leaf

if ($java -like $false)
{
    Write-Host "---Download Java---"
    Write-Host "."
    Write-Host "."
    .\wget\wget.exe https://cdn.azul.com/zulu/bin/zulu17.36.13-ca-jdk17.0.4-win_x64.zip
    Write-Host "---Extract archive---"
    Write-Host "."
    Write-Host "."
    Expand-Archive -LiteralPath './zulu17.36.13-ca-jdk17.0.4-win_x64.zip' -DestinationPath .
    Write-Host "---Rename folder---"
    Write-Host "."
    Write-Host "."
    Rename-Item .\zulu17.36.13-ca-jdk17.0.4-win_x64 .\zulu17
    Write-Host "---Delete archive---"
    Write-Host "."
    Write-Host "."
    Remove-Item zulu17.36.13-ca-jdk17.0.4-win_x64.zip
}

$policy = Get-ExecutionPolicy
if ($policy -like 'Restricted')
{
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
}

Write-Host "Download apk files? (y/n)"
$downloadrevanced = Read-Host -Prompt "You options is"
if ( $downloadrevanced -like 'y' ) {
    downloadyt
    Clear-Host
    # downloadytm
}
if ($downloadrevanced -like 'n') {
    Clear-Host
}


# Download or not revanced files
Write-Host "Download revanced files? (y/n)"
$downloadrevanced = Read-Host -Prompt "You options is"

if ( $downloadrevanced -like 'y' ) {
    downloadrevanced
}
if ($downloadrevanced -like 'n') {
    Clear-Host
}

# Check ADB connection
Clear-Host
Write-Host "---Check ADB connection---"
Write-Host "."
.\platform-tools\adb.exe kill-server
.\platform-tools\adb.exe start-server
do {
    Write-Host "."
    Start-Sleep -Seconds 5
    Write-Host "Give ADB access to this PC, if its needed"
    .\platform-tools\adb.exe devices 
    $checkadb = .\platform-tools\adb.exe devices
} while ($checkadb -match 'device' -eq $true)
Write-Host "Garant root to shell on your phone, if it's stuck!"
.\platform-tools\adb.exe shell su -c exit
Write-Host "."
Start-Sleep -Seconds 5
Write-Host "."

# Read adb number
$state = Test-Path -Path .\adb.txt -PathType Leaf
if ( $state -like $false) {
    $adbw = Read-Host -Prompt "Type or copy your adb number (only number)"
    Write-Host "."
    Write-Host "."
    "$adbw" | Out-File -FilePath .\adb.txt
    $adb = Get-Content -Path .\adb.txt
} 
if ( $state -like $true) {
    $adb = Get-Content -Path ./adb.txt
    Write-Host "If its diffrent delete adb.txt and run script again or copy your ADB device number and replace it instead of number in adb.txt"
    Write-Host "."
    Write-Host "."
    Write-Host "."
    Write-Host "."
}

# What do you want to build
Write-Host "1. YouTube ReVanced Root"
Write-Host "2. YouTube ReVanced Non-Root"
$option = Read-Host -Prompt "You options is" 
Clear-Host

switch ($option) {
    1 {
        ytroot
    }
    2 {
        ytnonroot
    }
    Default{
        Write-Host "Type number from 1 - 6"
        Write-Host "."
        Write-Host "."
    }
}