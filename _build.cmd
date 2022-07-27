@echo off
:: Check apk file for script
:checkytapk
if not exist youtube1.apk (
    echo "Please download YouTube apk. Then rename YouTube to youtube1.apk"
    echo "Check avaliable version that support patch: https://github.com/revanced/revanced-patches"
    pause
    goto:checkapk
)
:checkytmapk
if not exist youtube2.apk (
    echo "Please downloadYouTube Music apk. Then rename YouTube Music to youtube2.apk"
    echo "Check avaliable version that support patch: https://github.com/revanced/revanced-patches"
    pause
    goto:checkytmapk
)

:: Delete old files
echo ---Delete previous files-- 
del /q /s revanced*.dex
del /q /s revanced*.jar
del /q /s app-release-unsigned.apk
:: Download ReVanced Integrations
echo ---Download ReVanced Integrations---
powershell.exe ./ri.ps1
timeout 5 > NUL /nobreak
:: Download ReVanced Patches
echo ---Download ReVanced CLI---
powershell.exe ./rcli.ps1
timeout 5 > NUL /nobreak
:: Download ReVanced CLI
echo ---Download ReVanced Patches---
powershell.exe ./rp.ps1
del /q /s revanced*.dex
timeout 5 > NUL /nobreak
:: Rename files
echo ---Rename files---
ren revanced-cli*.jar revanced-cli-all.jar
ren revanced-patches*.jar revanced-patches.jar

:: Check ADB connection
:adb
echo ---Check ADB connection---
adb devices
echo Garant root to shell on your phone if it's stuck!
adb shell su -c exit
echo .
echo .
echo .

:: Read adb number
if exist adb.txt (
    goto:mesadb
) else (
    goto:changeadb
)
:mesadb
set /p adb=< %cd%\adb.txt
echo Your devices: %adb%
echo If its diffrent copy your ADB device number and replace it instead of number in adb.txt
echo .
echo .
echo .
echo .
goto:build

:: Input your ADB number devices
:changeadb
set /p adbw=Type or copy your adb number (only number): 
echo %adbw%
echo %adbw% > adb.txt
goto:adb

:: What do you want to build
:build
echo 1. YouTube ReVanced Root
echo 2. YouTube Music Revanced Root
echo 3. All Root  
echo 4. YouTube ReVanced Non-Root
echo 5. YouTube Music ReVanced Non-Root
echo 6. All Non-Root
set /P option=You options is: 

if %option%==1 (
    echo "---Uninstalling YouTube---"
    echo ""
    adb -s %adb% uninstall com.google.android.youtube
    echo ""
    echo "---Installing YouTube---"
    echo ""
    adb -s %adb% install youtube1.apk
    echo "---Build Youtube ReVanced Root---"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --mount
    pause
    goto:eof
)
if %option%==2 (
    echo "---Uninstalling YouTube Music---"
    echo ""
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo "---Installing YouTube Music---"
    echo ""
    adb -s %adb% install youtube2.apk
    echo "---Build Youtube Music Revanced Root---"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    pause
    goto:eof
)
if %option%==3 (
    echo "---Uninstalling All---"
    echo ""
    adb -s %adb% uninstall com.google.android.youtube
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo "---Installing YouTube---"
    echo ""
    adb -s %adb% install youtube1.apk
    echo "---Installing YouTube Music---"
    echo ""
    adb -s %adb% install youtube2.apk
    echo "---Build Youtube ReVanced Root---"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --mount
    pause
    echo "---Build Youtube Music Revanced Root---"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    pause
    goto:eof
) 
if %option%==4 (
    echo "---Uninstalling YouTube---"
    echo ""
    adb -s %adb% uninstall com.google.android.youtube
    echo "---Installing Vanced Microg---"
    echo ""
    adb -s %adb% install microg.apk
    echo "---Installing YouTube---"
    adb -s %adb% install youtube1.apk
    echo "---Build Youtube ReVanced Non-Root---"
    echo ""
    echo "If display any warning that prevent instaling app through ADB - apply it!"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls
    pause
    goto:eof
)
if %option%==5 (
    echo "---Uninstalling YouTube Music---"
    echo ""
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo "---Installing Vanced Microg---"
    echo ""
    adb -s %adb% install microg.apk
    echo "---Installing YouTube Music---"
    adb -s %adb% install youtube2.apk
    echo "---Build Youtube Music Revanced Non-Root---"
    echo ""
    echo "If display any warning that prevent instaling app through ADB - apply it!"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk
    pause
    goto:eof
)
if %option%==6 (
    echo "---Uninstalling All---"
    adb -s %adb% uninstall com.google.android.youtube
    adb -s %adb% uninstall com.google.android.apps.youtube.music
    echo ""
    echo "---Installing Vanced Microg---"
    echo ""
    adb -s %adb% install microg.apk
    echo "---Installing YouTube---"
    echo ""
    adb -s %adb% install youtube1.apk
    echo "---Installing YouTube Music---"
    echo ""
    adb -s %adb% install youtube2.apk
    echo "---Build Youtube ReVanced Non-Root---"
    echo ""
    echo "If display any warning that prevent instaling app through ADB - apply it!"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced_youtube.apk -b revanced-patches.jar -m app-release-unsigned.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls
    pause
    echo "---Build Youtube Music Revanced Non-Root---"
    echo ""
    echo "If display any warning that prevent instaling app through ADB - apply it!"
    echo ""
    echo "When building is over, close jar window and press any key"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o revanced_music.apk -b revanced-patches.jar -m app-release-unsigned.apk
    pause
    goto:eof
) else (
    goto:build
)  