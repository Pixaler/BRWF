import os
import time
import requests
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import re
import zipfile


def downloadyt():  # Download YouTube apk
    print("---Delete previous apk files---\n.")
    try:
        os.remove("youtube1.apk")
    except FileNotFoundError:
        print("File don't exist")
    print(".\n---Download YT---")
    link_yt = "https://android.biblprog.org.ua/ru/youtube/download/"
    # Parsing link for download link
    request_site = requests.get(link_yt)
    html = request_site.text
    soup = BeautifulSoup(html, "lxml")
    # Format received requests
    download_yt = ""
    for tag in soup.find_all("a", href=re.compile("youtube_18.15.40.apk")):
        download_yt = tag["href"]
    print(".\n.\nWait")
    os.system("curl -LJ " + download_yt + " -o youtube1.apk")


def downloadytm():  # Download YouTube Music apk
    print("---Delete previous apk files---\n.")
    try:
        os.remove("youtube2.apk")
    except FileNotFoundError:
        print("File don't exist")
    print(".\n---Download YTM---")
    link_ytm = "https://android.biblprog.org.ua/ru/youtube-music/download/"
    # Parsing link for download link
    request_site = requests.get(link_ytm)
    html = request_site.text
    soup = BeautifulSoup(html, "lxml")
    # Format received requests
    download_ytm = ""
    for tag in soup.find_all(
        "a", href=re.compile("youtube-music-arm64-v8a_5.53.50.apk")
    ):
        download_ytm = tag["href"]
    print(".\n.\nWait")
    os.system("curl -LJ " + download_ytm + " -o youtube2.apk")


def downloadrevanced():  # Download or update revance files
    print("---Delete previous files---\n.\n.")
    # Delete old revanced files
    try:
        os.remove(".\\revanced-integrations.apk")
        os.remove(".\\revanced-cli-all.jar")
        os.remove(".\\revanced-patches.jar")
    except FileNotFoundError:
        print("Files don't found")
        time.sleep(5)

    # Download ReVanced Integrations
    print("---Download ReVanced Integrations---\n.\n.")
    # Parsing link_ri for download link
    link_ri = (
        "https://api.github.com/repos/inotia00/revanced-integrations/releases/latest"
    )
    request_site = requests.get(link_ri)
    data = request_site.json()["assets"][0]["browser_download_url"]
    download_link_ri = data

    os.system("curl -LJ " + download_link_ri + " -o revanced-integrations.apk")
    time.sleep(5)

    print("---Download ReVanced Patches---\n.\n.")
    link_rp = "https://api.github.com/repos/inotia00/revanced-patches/releases/latest"
    # Parsing link_rp for download link
    request_site = requests.get(link_rp)
    data = request_site.json()["assets"][1]["browser_download_url"]
    download_link_rp = data

    os.system("curl -LJ " + download_link_rp + " -o revanced-patches.jar")

    print("---Download ReVanced CLI---\n.\n.")
    link_cli = "https://api.github.com/repos/revanced/revanced-cli/releases/latest"
    # Parsing link_rp for download link
    request_site = requests.get(link_cli)
    data = request_site.json()["assets"][0]["browser_download_url"]
    download_link_cli = data
    # Parsing link_cli for download link
    os.system("curl -LJ " + download_link_cli + " -o revanced-cli-all.jar")


def ytroot(adb):  # Building YT Revanced Root
    print("---Uninstalling YouTube---\n.\n.")
    os.system(
        ".\\platform-tools\\adb.exe -s " + adb + " uninstall com.google.android.youtube"
    )

    print("---Installing YouTube---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " install youtube1.apk")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(
        ".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d "
        + adb
        + " -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e microg-support -e premium-heading  -e sponsorblock -i swipe-controls -e custom-branding-name -e custom-branding-icon-revancify  -e custom-branding-icon-afn-red --mount"
    )
    input("Press Enter to continue.")


def ytnonroot(adb):  # Building YouTube Revanced NonRoot
    print("---Uninstalling YouTube---\n.\n.")
    os.system(
        ".\\platform-tools\\adb.exe -s " + adb + " uninstall com.google.android.youtube"
    )

    print("---Installing YouTube---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " install youtube1.apk")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(
        ".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d "
        + adb
        + " -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e premium-heading -e custom-branding-name -e custom-branding-icon-revancify  -e custom-branding-icon-afn-red -e sponsorblock -i swipe-controls --experimental"
    )
    input("Press Enter to continue.")


def ytmroot(adb):
    print("---Uninstalling YouTube Music---\n.\n.")
    os.system(
        ".\\platform-tools\\adb.exe -s "
        + adb
        + " uninstall com.google.android.apps.youtube.music"
    )

    print("---Installing YouTube Music---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " install youtube2.apk")

    print("---Build YouTube Music ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(
        ".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube2.apk -c -d "
        + adb
        + " -o revanced_music.apk -b revanced-patches.jar -m revanced-integrations.apk -e music-microg-support -e custom-branding-music-afn-red -e custom-branding-music-revancify --mount --experimental"
    )
    input("Press Enter to continue.")


def ytmnonroot(adb):  # Building YT Music Revanced NonRoot
    print("---Uninstalling YouTube Music---\n.\n.")
    os.system(
        ".\\platform-tools\\adb.exe -s "
        + adb
        + " uninstall com.google.android.apps.youtube.music"
    )

    print("---Installing YouTube Music---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " install youtube2.apk")

    print("---Build YouTube Music ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(
        ".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube2.apk -c -d "
        + adb
        + " -o revanced_music.apk -b revanced-patches.jar -m revanced-integrations.apk -e custom-branding-music-afn-red -e custom-branding-music-revancify --experimental"
    )
    input("Press Enter to continue.")


# If java not in folder, download it
if os.path.isfile(".\\zulu17\\bin\\java.exe") is False:
    print("---Download Java---\n.\n.")
    os.system(
        "curl -LJ https://cdn.azul.com/zulu/bin/zulu17.42.19-ca-jdk17.0.7-win_x64.zip -o zulu17.zip"
    )
    print("---Extract archive---\n.\n.")
    with zipfile.ZipFile(".\\zulu17.zip", "r") as zip_ref:
        zip_ref.extractall(".\\")
    print("---Rename folder---\n.\n.")
    os.renames("zulu17.42.19-ca-jdk17.0.7-win_x64", "zulu17")
    print("---Delete archive---\n.\n.")
    os.remove("zulu17.zip")

print("Download apk files? (y/n)")
download_apk = input("Your option is: ")
if download_apk == "y":  # Download or not YouTube apk
    downloadyt()
    downloadytm()
if download_apk == "n":
    time.sleep(1)

print("Download revanced files? (y/n)")
download_revanced = input("You options is: ")
if download_revanced == "y":  # Download or not Revanced files
    downloadrevanced()
if download_revanced == "n":
    time.sleep(1)

print("---Check ADB connection---\n.")
os.system(".\\platform-tools\\adb.exe kill-server")
os.system(".\\platform-tools\\adb.exe start-server")

print(".\nGive ADB access to this PC, if its needed\n")
os.system(".\\platform-tools\\adb.exe devices")  # Check that phone connected to PC
time.sleep(5)


if os.path.isfile(".\\adb.txt") is False:
    adbw = input("Type or copy your adb number (only number): ")
    print(".\n.")
    with open(".\\adb.txt", "w") as adb_txt:
        print(adbw, file=adb_txt)
        adb_txt.close()

adb = ""
if os.path.isfile(".\\adb.txt") is True:
    with open(".\\adb.txt", "r") as adb_txt:
        while True:
            char = adb_txt.read(1)
            if ord(char) == 10:
                break
            adb += char
    adb_txt.close()

print(f"Your devices: {adb}\n.\n.")
print(
    "If its diffrent delete adb.txt and run script again or copy your ADB device number and replace it instead of number in adb.txt\n.\n.\n.\n."
)

print("1. YouTube ReVanced Root")
print("2. YouTube ReVanced Non-Root")
print("3. YouTube Music ReVanced Root")
print("4. YouTube Music ReVanced Non-Root")
print("5. All Non-Root")
print("6. All Root")
option = int(input("Your option is: "))

if option == 1:
    ytroot(adb)
if option == 2:
    ytnonroot(adb)
if option == 3:
    ytmroot(adb)
if option == 4:
    ytmnonroot(adb)
if option == 5:
    ytnonroot(adb)
    ytmnonroot(adb)
if option == 6:
    ytroot(adb)
    ytmroot(adb)
