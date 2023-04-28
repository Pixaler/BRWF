from asyncio.windows_events import NULL
import os
import time
from urllib.request import Request ,urlopen
from turtle import clear
from bs4 import BeautifulSoup
import re
import zipfile

def downloadyt(): # Download YouTube apk
    print("---Delete previous apk files---\n.")
    try:
        os.remove("youtube1.apk")
    except:
        print("File don't exist")
    print(".\n---Download YT---")
    link_yt = "https://android.biblprog.org.ua/ru/youtube/download/"
    # Parsing link for download link
    request_site = Request(link_yt)
    page = urlopen(request_site)
    html = page.read().decode("ansi")
    soup = BeautifulSoup(html, "lxml")
    # Format received requests
    for tag in soup.find_all("a", href=re.compile("youtube_17.49.37.apk")):
        download_yt = tag['href']
    print(".\n.\nWait")
    os.system(".\wget\wget.exe " + download_yt +  " -O youtube1.apk")

def downloadytm(): # Download YouTube Music apk
    print("---Delete previous apk files---\n.")
    try:
        os.remove("youtube2.apk")
    except:
        print("File don't exist")
    print(".\n---Download YTM---")
    link_ytm = "https://android.biblprog.org.ua/ru/youtube-music/download/"
    # Parsing link for download link
    request_site = Request(link_ytm)
    page = urlopen(request_site)
    html = page.read().decode("ansi")
    soup = BeautifulSoup(html, "lxml")
    # Format received requests
    for tag in soup.find_all("a", href=re.compile("youtube-music-arm64-v8a_5.36.51.apk")):
        download_ytm = tag['href']
    print(".\n.\nWait")
    os.system(".\wget\wget.exe " + download_ytm +  " -O youtube2.apk")

def downloadrevanced(): # Download or update revance files
    print("---Delete previous files---\n.\n.")
    # Delete old revanced files 
    try:
        os.remove(".\\revanced-integrations.apk")
        os.remove(".\\revanced-cli-all.jar")
        os.remove(".\\revanced-patches.jar")
    except:
        print("Files don't found")
        time.sleep(5)

    # Download ReVanced Integrations
    print("---Download ReVanced Integrations---\n.\n.")
    # Parsing link_ri for download link
    link_ri = "https://api.github.com/repos/revanced/revanced-integrations/releases/latest"
    request_site = Request(link_ri, headers={"User-Agent": "Mozilla/5.0"})
    page = urlopen(request_site)
    html = page.read().decode("ansi")
    soup = BeautifulSoup(html, "lxml").text
    # Format received requests
    link = str(re.findall(r'"browser_download_url":"\S+.apk"', soup))
    formated_link = re.sub(r"\['\"browser_download_url\":\"", "", link)
    formated_link = re.sub(r"\"']", "", formated_link)
    download_link_ri = formated_link
    
    os.system('.\wget\wget.exe --content-disposition ' + download_link_ri + ' -O revanced-integrations.apk')
    time.sleep(5)


    print("---Download ReVanced Patches---\n.\n.")
    link_rp = "https://api.github.com/repos/revanced/revanced-patches/releases/latest"
    # Parsing link_rp for download link
    request_site = Request(link_rp, headers={"User-Agent": "Mozilla/5.0"})
    page = urlopen(request_site)
    html = page.read().decode("ansi")
    soup = BeautifulSoup(html, "lxml").text
    # Format received requests
    link = str(re.findall(r'"browser_download_url":"\S+.jar"', soup))
    link = re.sub(r"\[\'\"browser_download_url", "", link)
    link = str(re.findall(r'"browser_download_url":"\S+.jar"', link))
    formated_link = re.sub(r"\['\"browser_download_url\":\"", "", link)
    formated_link = re.sub(r"\"']", "", formated_link)
    download_link_rp = formated_link

    os.system(".\wget\wget.exe --content-disposition " + download_link_rp + ' -O revanced-patches.jar')

    print("---Download ReVanced CLI---\n.\n.")
    link_cli = "https://api.github.com/repos/revanced/revanced-cli/releases/latest"
    # Parsing link_rp for download link
    request_site = Request(link_cli, headers={"User-Agent": "Mozilla/5.0"})
    page = urlopen(request_site)
    html = page.read().decode("ansi")
    soup = BeautifulSoup(html, "lxml").text
    # Format received requests
    link = str(re.findall(r'"browser_download_url":"\S+.jar"', soup))
    formated_link = re.sub(r"\['\"browser_download_url\":\"", "", link)
    formated_link = re.sub(r"\"']", "", formated_link)
    download_link_cli = formated_link
    # Parsing link_cli for download link
    os.system(".\wget\wget.exe --content-disposition " + download_link_cli + ' -O revanced-cli-all.jar')

def ytroot(adb): # Building YT Revanced Root
    print("---Uninstalling YouTube---\n.\n.")
    os.system("\\platform-tools\\adb.exe -s " + adb + "uninstall com.google.android.youtube")

    print("---Installing YouTube---\n.\n.")
    os.system("\\platform-tools\\adb.exe -s " + adb + "install youtube1.apk")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d " + adb + " -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e microg-support -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --experimental --mount")
    wait = input("Press Enter to continue.")

def ytnonroot(adb): # Building YouTube Revanced NonRoot
    print("---Uninstalling YouTube---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + "uninstall com.google.android.youtube")

    print("---Installing YouTube---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + "install youtube1.apk")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube1.apk -c -d " + adb + " -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e premium-heading -e custom-branding -e sponsorblock -i swipe-controls --experimental")
    wait = input("Press Enter to continue.")

def ytmnonroot(adb): # Building YT Music Revanced NonRoot
    print("---Uninstalling YouTube Music---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " uninstall com.google.android.apps.youtube.music")

    print("---Installing YouTube Music---\n.\n.")
    os.system(".\\platform-tools\\adb.exe -s " + adb + " install youtube2.apk")

    print("---Build YouTube Music ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    os.system(".\\zulu17\\bin\\java.exe -jar revanced-cli-all.jar -a youtube2.apk -c -d " + adb + " -o revanced_music.apk -b revanced-patches.jar -m revanced-integrations.apk --experimental")
    wait = input("Press Enter to continue.")

if os.path.isfile (".\\zulu17\\bin\\java.exe") == False: # If java not in folder, download it
    print("---Download Java---\n.\n.")
    os.system(".\\wget\\wget.exe https://cdn.azul.com/zulu/bin/zulu17.36.13-ca-jdk17.0.4-win_x64.zip")
    print("---Extract archive---\\n.\\n.")
    with zipfile.ZipFile(".\\zulu17.36.13-ca-jdk17.0.4-win_x64.zip", 'r') as zip_ref:
        zip_ref.extractall(".\\")
    print("---Rename folder---\n.\n.")
    os.renames("zulu17.36.13-ca-jdk17.0.4-win_x64", "zulu17") 
    print("---Delete archive---\n.\n.")
    os.remove("zulu17.36.13-ca-jdk17.0.4-win_x64.zip")

print("Download apk files? (y/n)") 
download_apk = input("Your option is: ")
if download_apk == 'y': # Download or not YouTube apk
    downloadyt()
    downloadytm()
if download_apk == 'n':
    time.sleep(1)

print("Download revanced files? (y/n)")
download_revanced = input("You options is: ") 
if download_revanced == 'y': # Download or not Revanced files
    downloadrevanced()
if download_revanced == 'n':
    time.sleep(1)

print ("---Check ADB connection---\n.") 
os.system(".\\platform-tools\\adb.exe kill-server")
os.system(".\\platform-tools\\adb.exe start-server")
try: 
    print(".\nGive ADB access to this PC, if its needed\n")
    os.system(".\\platform-tools\\adb.exe devices") # Check that phone connected to PC
    time.sleep(5)
except:
    print("Something went wrong")

if os.path.isfile(".\\adb.txt") == False:
    adbw = input("Type or copy your adb number (only number): ")
    print(".\n.")
    with open(".\\adb.txt", "w") as adb_txt:
        print(adbw, file = adb_txt) 
        adb_txt.close()

adb = ""
if os.path.isfile(".\\adb.txt") == True:
    with open(".\\adb.txt", "r") as adb_txt:
        while True:
            char = adb_txt.read(1)
            if ord(char) == 10:
                break
            adb += char
    adb_txt.close()

print (f"Your devices: {adb}\n.\n.")
print("If its diffrent delete adb.txt and run script again or copy your ADB device number and replace it instead of number in adb.txt\n.\n.\n.\n.")

print ("1. YouTube ReVanced Root")
print ("2. YouTube ReVanced Non-Root")
print ("3. YouTube Music ReVanced Non-Root")
print ("4. All Non-Root")
option = int(input("Your option is: "))

if option == 1:
    ytroot(adb)
if option == 2:
    ytnonroot(adb)
if option == 3:
    ytmnonroot(adb)
if option == 4:
    ytnonroot(adb)
    ytmnonroot(adb)
