import os
import time
import platform

if platform.system() == "Linux":
    from brwf.global_variables import JAVA_PATH_LINUX as JAVA_PATH
else:
    from brwf.global_variables import JAVA_PATH_WIN as JAVA_PATH

from brwf.download import download_java, download_yt, download_ytm, download_revanced
from brwf.build import ytroot, ytnonroot, ytmroot, ytmnonroot
from brwf.adb import check_adb


# If java not in folder, download it
if os.path.isfile(JAVA_PATH) is False:
    download_java()

print("Download apk files? (y/n)")
download_apk = input("Your option is: ")
if download_apk == "y":  # Download or not YouTube apk
    download_yt()
    download_ytm()
if download_apk == "n":
    time.sleep(1)

print("Download revanced files? (y/n)")
download_rev = input("You options is: ")
if download_rev == "y":  # Download or not Revanced files
    download_revanced()
if download_revanced == "n":
    time.sleep(1)

adb = check_adb()

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
