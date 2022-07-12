@echo off
:: Delete old files
@echo ---Delete previous files--
del /q /s revanced-*.jar
del /q /s app-release-unsigned.apk

:: Download ReVanced Integrations
@echo ---Download ReVanced Integrations---
gh release download -R revanced/revanced-integrations -p *.apk

:: Download ReVanced Patches
@echo ---Download ReVanced Patches---
gh release download -R revanced/revanced-patches -p *.jar

:: Download ReVanced CLI
@echo ---Download ReVanced CLI---
gh release download -R revanced/revanced-cli -p *.jar

:: Rename files
@echo ---Rename files---
ren revanced-cli*.jar revanced-cli-all.jar
ren revanced-patches*.jar revanced-patches.jar

:: Check ADB connection
@echo ---Check ADB connection---
adb devices

:: Build Youtube ReVanced (Root)
@echo ---Build Youtube ReVanced (Root)---
java -jar revanced-cli-all.jar -a youtube1.apk -c -d 721HECT82AFJF -o revanced.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg-support --mount

:: Build Youtube ReVanced (Root)
@echo ---Build Youtube Music Revanced (Root)---
java -jar revanced-cli-all.jar -a youtube2.apk -c -d 721HECT82AFJF -o music.apk -b revanced-patches.jar -m app-release-unsigned.apk -e microg --mount