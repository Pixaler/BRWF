from os import system as System, remove as Remove
import os
import re
import requests
import zipfile
from bs4 import BeautifulSoup
import time
import platform

if platform.system() == "Linux":
    from brwf.global_variables import JAVA_FOLDER_NAME_LINUX as JAVA_FOLDER_NAME
else:
    from brwf.global_variables import JAVA_FOLDER_NAME_WIN as JAVA_FOLDER_NAME


def download_java():
    print("---Download Java---\n.\n.")
    System(f"curl https://cdn.azul.com/zulu/bin/{JAVA_FOLDER_NAME}.zip -o zulu17.zip")
    print("---Extract archive---\n.\n.")
    with zipfile.ZipFile("./zulu17.zip", "r") as zip_ref:
        zip_ref.extractall("./")
    print("---Rename folder---\n.\n.")
    os.renames(JAVA_FOLDER_NAME, "zulu17")
    print("---Delete archive---\n.\n.")
    Remove("zulu17.zip")


def download_yt():
    '''Download YouTube apk'''
    print("---Delete previous apk files---\n.")
    try:
        Remove("youtube1.apk")
    except FileNotFoundError:
        print("File don't exist")
    print(".\n---Download YT---")

    # Download YouTube apk
    link_yt = "https://android.biblprog.org.ua/ru/youtube/download/"
    request_site = requests.get(link_yt)
    html = request_site.text
    soup = BeautifulSoup(html, "lxml")

    # Search for a download link
    down_link_yt = soup.find("a", href=re.compile(r'youtube\S+.apk'))["href"]
    print(".\n.\nWait")
    System(f"curl -LJ {down_link_yt} -o youtube1.apk")


def download_ytm():
    '''Download YouTube Music apk'''
    print("---Delete previous apk files---\n.")
    try:
        Remove("youtube2.apk")
    except FileNotFoundError:
        print("File don't exist")
    print(".\n---Download YTM---")
    link_ytm = "https://android.biblprog.org.ua/ru/youtube-music/download/"

    # Parsing link for download link
    request_site = requests.get(link_ytm)
    html = request_site.text
    soup = BeautifulSoup(html, "lxml")

    # Format received requests
    down_link_ytm = soup.find("a", href=re.compile("youtube-music-arm64-v8a"))["href"]
    print(".\n.\nWait")
    System(f"curl -LJ {down_link_ytm} -o youtube2.apk")

def download_microg():
    print("---Delete previous apk files---\n.")
    try:
        Remove("microg.apk")
    except FileNotFoundError:
        print("File don't exist")
    print(".\n---Download mMicroG---")
    git_microg = "https://api.github.com/repos/inotia00/mMicroG/releases/latest"
    request_site = requests.get(git_microg)
    data = request_site.json()["assets"][0]["browser_download_url"]
    download_link_microg = data
    
    # Format received requests
    print(".\n.\nWait")
    System(f"curl -LJ {download_link_microg} -o microg.apk")


def download_revanced():  # Download or update revance files
    print("---Delete previous files---\n.\n.")
    # Delete old revanced files
    try:
        Remove("./revanced-integrations.apk")
        Remove("./revanced-cli-all.jar")
        Remove("./revanced-patches.jar")
    except FileNotFoundError:
        print("Files not found")
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

    System("curl -LJ " + download_link_ri + " -o revanced-integrations.apk")
    time.sleep(5)

    print("---Download ReVanced Patches---\n.\n.")
    link_rp = "https://api.github.com/repos/inotia00/revanced-patches/releases/latest"
    # Parsing link_rp for download link
    request_site = requests.get(link_rp)
    data = request_site.json()["assets"][1]["browser_download_url"]
    download_link_rp = data
    System("curl -LJ " + download_link_rp + " -o revanced-patches.jar")

    print("---Download ReVanced CLI---\n.\n.")
    link_cli = "https://api.github.com/repos/revanced/revanced-cli/releases/latest"
    # Parsing link_rp for download link
    request_site = requests.get(link_cli)
    data = request_site.json()["assets"][0]["browser_download_url"]
    download_link_cli = data
    # Parsing link_cli for download link
    System("curl -LJ " + download_link_cli + " -o revanced-cli-all.jar")
