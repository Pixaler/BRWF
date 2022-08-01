# Download or not apk files
function downloadapps {
    Write-Host "---Download YouTube 17.29.34---"
    Remove-Item youtube1.apk
    ./wget/bin/wget.exe --content-disposition https://dl1.topfiles.net/files/2/1159/48171/TVZTTUhwgfZ4YmxqN1ZtSHd4VW1HZVp6T0VYMDlicnl0VVYrNmtteDY4ZXRSTT06Ovu33dVQN6CdJDvczZSgrIk/youtube_17.29.34.apk -O youtube1.apk
    Read-Host -Prompt "Press Enter to continue"
    Write-Host "---Download YouTube Music 5.14.53---"
    Remove-Item youtube2.apk
    ./wget/bin/wget.exe --content-disposition https://dl3.topfiles.net/files/2/482/46522/NmR6cWR1rLtnMk9IaExveFZZc0pma1JvbGw2MGVxU3A5SVA1WjNPcHBObUl4WT06OpP3NHltkCHItrylSnJeKZc/youtube-music-arm64-v8a_5.14.53.apk -O youtube2.apk
    Read-Host -Prompt "Press Enter to continue"
}

function downloadrevanced {
# Delete old files
    Write-Host "---Delete previous files---"
    Write-Host "."
    Write-Host "."
    Remove-Item revanced*.dex
    Remove-Item revanced*.jar
    Remove-Item app-release-unsigned.apk

# Download ReVanced Integrations
    Write-Host "---Download ReVanced Integrations---"
    Write-Host "."
    Write-Host "."
    $LinkRI = 'https://api.github.com/repos/revanced/revanced-integrations/releases/latest'   
    $DownloadLinkRI = (((Invoke-WebRequest $LinkRI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'app-release-unsigned').Line
    ./wget/bin/wget.exe --content-disposition $DownloadLinkRI
    Start-Sleep -Seconds 5

# Download ReVanced CLI
    Write-Host "---Download ReVanced CLI---"
    Write-Host "."
    Write-Host "."
    $LinkRCLI = 'https://api.github.com/repos/revanced/revanced-patches/releases/latest'   
    $downloadLinkRCLI = (((Invoke-WebRequest $LinkRCLI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-patches').Line
    ./wget/bin/wget.exe --content-disposition $downloadLinkRCLI -O revanced-patches.jar
    Start-Sleep -Seconds 5

# Download ReVanced CLI
    Write-Host "---Download ReVanced CLI---"
    Write-Host "."
    Write-Host "."
    $LinkRCLI = 'https://api.github.com/repos/revanced/revanced-cli/releases/latest'   
    $DownloadLinkRCLI = (((Invoke-WebRequest $LinkRCLI) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-cli').Line
    ./wget/bin/wget.exe --content-disposition $DownloadLinkRCLI -O revanced-cli-all.jar
    Remove-Item revanced*.dex
    Start-Sleep -Seconds 5
}


# Input your ADB number devices
function changeadb {
    $adbw = Read-Host -Prompt "Type or copy your adb number (only number)"
    Write-Host "."
    Write-Host "."
    "$adbw" | Out-File -FilePath .\adb.txt
    $adb = Get-Content -Path .\adb.txt
    return $adb
}


# Show your ADB number
function mesadb {
    $adb = Get-Content -Path .\adb.txt
    Write-Host "If its diffrent delete adb.txt and run script again or copy your ADB device number and replace it instead of number in adb.txt"
    Write-Host "."
    Write-Host "."
    Write-Host "."
    Write-Host "."
    return $adb
}


function ytroot {
    Write-Host "---Uninstalling YouTube---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb uninstall com.google.android.youtube
    Write-Host "---Installing YouTube---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install youtube1.apk
    Write-Host "---Build Youtube ReVanced Root---"
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app in your phone"
    ./zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d $adb -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --mount
    Read-Host -Prompt "Press Enter to continue"
}
function ytmroot {
    Write-Host "---Uninstalling YouTube Music---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb uninstall com.google.android.apps.youtube.music
    Write-Host ---Installing YouTube Music---
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install youtube2.apk
    Write-Host "---Build Youtube Music Revanced Root---"
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app in your phone"
    ./zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d $adb -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    Read-Host -Prompt "Press Enter to continue"
}
function ytnonroot {
    Write-Host "---Uninstalling YouTube---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb uninstall com.google.android.youtube
    Write-Host "---Installing Vanced Microg---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install microg.apk
    Write-Host "---Installing YouTube---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install youtube1.apk
    Write-Host "---Build Youtube ReVanced Non-Root---"
    Write-Host "."
    Write-Host "."
    Write-Host "If display any warning that prevent instaling app through ADB - apply it!"
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app in your phone"
    ./zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d $adb -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls
    Read-Host -Prompt "Press Enter to continue"
}
function ytmnonroot {
    Write-Host "---Uninstalling YouTube Music---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb uninstall com.google.android.apps.youtube.music
    Write-Host "---Installing Vanced Microg---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install microg.apk
    Write-Host "---Installing YouTube Music---"
    Write-Host "."
    Write-Host "."
    ./adb -s $adb install youtube2.apk
    Write-Host "---Build Youtube Music Revanced Non-Root---"
    Write-Host "."
    Write-Host "."
    Write-Host If display any warning that prevent instaling app through ADB - apply it!
    Write-Host "."
    Write-Host "."
    Write-Host "When building is over, close app on your phone"
    ./zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d $adb -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk
    Read-Host -Prompt "Press Enter to continue"
}

Clear-Host
$downloadyt = Read-Host -Prompt "Download YT apk (y/n)"

if ($downloadyt -like 'y') {
    downloadapps
}
if ($downloadyt -like 'n') {
    Clear-Host
}

# Download or not revanced files
Clear-Host
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
Write-Host "."
./adb devices
Write-Host "Give ADB access to this PC, if its needed"
Write-Host "."
Start-Sleep -Seconds 5
Write-Host "."
Write-Host "Garant root to shell on your phone, if it's stuck!"
./adb shell su -c exit
Write-Host "."
Start-Sleep -Seconds 5
Write-Host "."

# Read adb number
$state = Test-Path -Path C:\BRWF\adb.txt -PathType Leaf
if ( $state -like $false) {
    changeadb
} 
if ( $state -like $true) {
    mesadb
}

# What do you want to build
Write-Host "1. YouTube ReVanced Root"
Write-Host "2. YouTube Music Revanced Root"
Write-Host "3. All Root"  
Write-Host "4. YouTube ReVanced Non-Root"
Write-Host "5. YouTube Music ReVanced Non-Root"
Write-Host "6. All Non-Root"
$option = Read-Host -Prompt "You options is" 
Clear-Host

switch ($option) {
    1 {
        ytroot
    }
    2 {
        ytmroot
    }
    3 {
        ytroot
        ytmroot
    }
    4 {
        ytnonroot
    }
    5 {
        ytmnonroot
    }
    6 {
        ytnonroot
        ytmnonroot
    }
    Default{
        Write-Host "Type number from 1 - 6"
        Write-Host "."
        Write-Host "."
    }
}

