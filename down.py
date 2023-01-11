from asyncio.windows_events import NULL
import os
import time
import webbrowser
from urllib.request import Request, urlopen
from turtle import clear
from bs4 import BeautifulSoup
import re

link = "https://android.biblprog.org.ua/ru/youtube/download/"
# Parsing link for download link
request_site = Request(link)
page = urlopen(request_site)
html = page.read().decode("ansi")
soup = BeautifulSoup(html, "lxml")
# Format received requests
for tag in soup.find_all("a", href=re.compile("youtube_17.49.37.apk")):
    print(tag['href'])
# formated_link = re.sub(r"\['\"browser_download_url\":\"", "", link)
# formated_link = re.sub(r"\"']", "", formated_link)




# download_link = formated_link
# # Parsing link_ri for download link
# os.system('.\wget\wget.exe --content-disposition ' + download_link + ' -O revanced-patches.jar')
# time.sleep(5)
