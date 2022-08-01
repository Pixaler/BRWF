@echo off
:: Download or not apk files
cls
:downloadyoutube
set /P downloadyt=Download YT apk (y/n): 

if %downloadyt%==y (
    call :downloadapps
    goto :downloadrevancedoption
)
if %downloadyt%==n (
    goto :downloadrevancedoption
) else (
    echo Type y - yes or n - no
    echo .
    echo .
    goto :downloadyoutube
)

:: Download or not revanced files
:downloadrevancedoption
cls
echo Download revanced files? (y/n)
set /P downloadrevanced=You options is: 

if %downloadrevanced%==y (
    call :downloadrevanced
)
if %downloadrevanced%==n (
    goto :adb
) else (
    echo Type y - yes or n - no
    echo .
    echo .
    goto :downloadrevancedoption
)

:: Check ADB connection
:adb
    cls
    echo ---Check ADB connection---
    echo .
    echo .
    adb devices
    echo Give ADB access to this PC, if its needed
    echo .
    timeout 5 > NUL /nobreak
    echo .
    echo Garant root to shell on your phone, if it's stuck!
    adb shell su -c exit
    echo .
    timeout 5 > NUL /nobreak
    echo .

:: Read adb number
if exist adb.txt (
    call :mesadb
) else (
    call :changeadb
)

:: What do you want to build
:build
    echo 1. YouTube ReVanced Root
    echo 2. YouTube Music Revanced Root
    echo 3. All Root  
    echo 4. YouTube ReVanced Non-Root
    echo 5. YouTube Music ReVanced Non-Root
    echo 6. All Non-Root
    set /P option=You options is: 
    cls

call :menu-n-%option% 2>nul ||(
    echo Type number from 1 - 6
    echo .
    echo .
    goto :build
)

:menu-n-1 
    call :ytroot
    goto :scriptend

:menu-n-2 
    call :ytmroot
    goto :scriptend

:menu-n-3 
    call :ytroot
    call :ytmroot
    goto :scriptend

:menu-n-4
    call :ytnonroot
    goto :scriptend

:menu-n-5
    call :ytmnonroot
    goto :scriptend

:menu-n-6
    call :ytnonroot
    call :ytmnonroot
    goto :scriptend

:downloadapps
    echo ---Download YouTube 17.29.34---
    del /q /s youtube1.apk
    start "" C:/BRWF/wget/bin/wget.exe --content-disposition https://dl1.topfiles.net/files/2/1159/48171/M0tKREa7VU44Y0VKMGtDUGRKZHRQNkdXVk9oNDg1cVZaM2l4bGVwd0ppZGpIUT06Og3JocBjv2oRotfsy8kCs2o/youtube_17.29.34.apk -O youtube1.apk
    pause
    echo ---Download YouTube Music 5.14.53---
    del /q /s youtube2.apk
    start "" C:/BRWF/wget/bin/wget.exe --content-disposition https://dl3.topfiles.net/files/2/482/46522/ekF1RGuXa4JKVVA5N0pKcFJqekY1YkpDOFhxRDVPWEhlRTJTd3JFUjVQeWJCZz06OmpIQwmhHrCKAvEXUQA8Dik/youtube-music-arm64-v8a_5.14.53.apk -O youtube2.apk
    pause
    goto :downloadrevancedoption

:downloadrevanced
:: Delete old files
    echo ---Delete previous files-- 
    echo .
    echo .
    del /q /s revanced*.dex
    del /q /s revanced*.jar
    del /q /s app-release-unsigned.apk

:: Download ReVanced Integrations
    echo ---Download ReVanced Integrations---
    echo .
    echo .
    powershell.exe ./ri.ps1
    timeout 5 > NUL /nobreak

:: Download ReVanced Patches
    echo ---Download ReVanced CLI---
    echo .
    echo .
    powershell.exe ./rcli.ps1
    timeout 5 > NUL /nobreak

:: Download ReVanced CLI
    echo ---Download ReVanced Patches---
    echo .
    echo .
    powershell.exe ./rp.ps1
    del /q /s revanced*.dex
    timeout 5 > NUL /nobreak

:: Rename files
    echo ---Rename files---
    echo .
    echo .
    ren revanced-cli*.jar revanced-cli-all.jar
    ren revanced-patches*.jar revanced-patches.jar
    goto :adb

:: Input your ADB number devices
:changeadb
    set /p adbw=Type or copy your adb number (only number): 
    echo .
    echo .
    echo %adbw%
    echo %adbw% > adb.txt
    goto :adb

:: Show your ADB number
:mesadb
    set /p adb=< %cd%\adb.txt
    echo Your devices: %adb%
    echo If its diffrent delete adb.txt and run script again or copy your ADB device number and replace it instead of number in adb.txt 
    echo .
    echo .
    echo .
    echo .
    goto :build

:ytroot
    echo ---Uninstalling YouTube---
    echo .
    echo .
    adb -s %adb% uninstall com.google.android.youtube
    echo ---Installing YouTube---
    echo .
    echo .
    adb -s %adb% install youtube1.apk
    echo ---Build Youtube ReVanced Root---
    echo .
    echo .
    echo When building is over, close jar window and press any key
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --mount
    pause
    goto :eof

:ytmroot
    echo ---Uninstalling YouTube Music---
    echo .
    echo .
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo ---Installing YouTube Music---
    echo .
    echo .
    adb -s %adb% install youtube2.apk
    echo ---Build Youtube Music Revanced Root---
    echo .
    echo .
    echo When building is over, close jar window and press any key
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    pause
    goto :eof

:ytnonroot
    echo ---Uninstalling YouTube---
    echo .
    echo .
    adb -s %adb% uninstall com.google.android.youtube
    echo ---Installing Vanced Microg---
    echo .
    echo .
    adb -s %adb% install microg.apk
    echo ---Installing YouTube---
    echo .
    echo .
    adb -s %adb% install youtube1.apk
    echo ---Build Youtube ReVanced Non-Root---
    echo .
    echo .
    echo If display any warning that prevent instaling app through ADB - apply it!
    echo .
    echo .
    echo When building is over, close jar window and press any key
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls
    pause
    goto :eof

:ytmnonroot
    echo ---Uninstalling YouTube Music---
    echo .
    echo .
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo ---Installing Vanced Microg---
    echo .
    echo .
    adb -s %adb% install microg.apk
    echo ---Installing YouTube Music---
    echo .
    echo .
    adb -s %adb% install youtube2.apk
    echo ---Build Youtube Music Revanced Non-Root---
    echo .
    echo .
    echo If display any warning that prevent instaling app through ADB - apply it!
    echo .
    echo .
    echo When building is over, close jar window and press any key
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk
    pause
    goto :eof

:scriptend
    exit