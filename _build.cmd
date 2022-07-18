@echo off
::Download or not download resources
:choice1
set /p answer=Download files or update files?(y/n): 
if %answer%==y (
:: Delete old files
    echo ---Delete previous files-- 
    del /q /s revanced*.jar
    del /q /s revanced*.dex
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
    timeout 5 > NUL /nobreak
:: Rename files
    echo ---Rename files---
    ren revanced-cli*.jar revanced-cli-all.jar
    ren revanced-patches*.jar revanced-patches.jar
    goto:adb
) 
if %answer%==n (
    goto:adb
) else (
    goto:choice1
)

:: Check ADB connection
:adb
echo ---Check ADB connection---
adb devices
echo Garant root to shell on your phone if it's stuck!
adb shell su -c exit

::Read adb number
set /p adb=< %cd%\adb.txt
echo Your devices: %adb%
set /p ans2=Is it right?(y/n): 

if %ans2%==n (
    goto:changeadb
) 
if %ans2%==y (
    goto:choice2
) else (
    goto:adb
)

::Input your ADB number devices
:changeadb
set /p adbw=Type your adb number: 
echo %adbw%
echo %adbw% > adb.txt
goto:adb

::What do you want to builds
:choice2
echo 1. YouTube ReVanced Root
echo 2. Youtube Music Revanced Root
echo 3. All Root  
set /P option=You options is: 
if %option%==1 (
    echo "---Build Youtube ReVanced Root---"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
)
if %option%==2 (
    echo "---Build Youtube Music Revanced (Root)---"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
)
if %option%==3 (
    echo "---Build Youtube ReVanced (Root)---"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    echo "---Build Youtube Music Revanced (Root)---"
    start "" C:/BRWF/zulu17/bin/java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
) else (
    goto:eof    
)


    

   