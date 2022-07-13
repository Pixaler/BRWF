@echo off
set /P answer=Download files or update files?(y/n): 

if %answer%==y (
:: Delete old files
    echo ---Delete previous files-- 
    del /q /s revanced-*.jar
    del /q /s app-release-unsigned.apk

:: Download ReVanced Integrations
    echo ---Download ReVanced Integrations---
    gh release download -R revanced/revanced-integrations -p *.apk

:: Download ReVanced Patches
    echo ---Download ReVanced Patches---
    gh release download -R revanced/revanced-patches -p *.jar

:: Download ReVanced CLI
    echo ---Download ReVanced CLI---
    gh release download -R revanced/revanced-cli -p *.jar

:: Rename files
    echo ---Rename files---
    ren revanced-cli*.jar revanced-cli-all.jar
    ren revanced-patches*.jar revanced-patches.jar
) else (
    goto :adb
)

:adb
:: Check ADB connection
echo ---Check ADB connection---
adb devices

::Input your ADB number devices
if not exist adb.txt (
    set /P adb=Type your adb number: 
    type nul > adb.txt
    echo %adb% > adb.txt
) else (
    if exist adb.txt goto :build
)

:build
::What do you want to build
set /p adb=< %cd%\adb.txt
echo Your devices: %adb%
set /P ans2=Is it right?(y/n): 
 
if %ans2%==n (
    del /q /s adb.txt
    goto :adb
) else (
    break=on
)

echo Choose what you want to build
echo 1. YouTube ReVanced Root
echo 2. Youtube Music Revanced Root
echo 3. All Root  
set /P option=You options is: 

if %option%==1 (
    echo "---Build Youtube ReVanced (Root)--"
    java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
) else (
    if %option%==2 (
    echo "---Build Youtube Music Revanced (Root)---" 
    java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg --mount
    ) else (
    echo "---Build Youtube ReVanced (Root)--"
    java -jar revanced-cli-all.jar -a youtube1.apk -c -d %adb% -o revanced.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount
    echo "---Build Youtube Music Revanced (Root)---"
    java -jar revanced-cli-all.jar -a youtube2.apk -c -d %adb% -o music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg --mount
    )
)
