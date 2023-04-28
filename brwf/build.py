from os import system as System
import platform

if platform.system():
    from brwf.global_variables import JAVA_PATH_LINUX as JAVA_PATH, ADB_PATH_LINUX as ADB_PATH
else:
    from brwf.global_variables import JAVA_PATH_WIN as JAVA_PATH, ADB_PATH_WIN as ADB_PATH


def ytroot(adb):
    print("---Uninstalling YouTube---\n.\n.")
    System(f"{ADB_PATH} -s {adb} uninstall com.google.android.youtube")

    print("---Installing YouTube---\n.\n.")
    System(f"{ADB_PATH} -s {adb} install youtube1.apk")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    System(
        f"{JAVA_PATH} -jar revanced-cli-all.jar -a youtube1.apk -c -d {adb} -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e microg-support -e premium-heading  -e sponsorblock -i swipe-controls -e custom-branding-name -e custom-branding-icon-revancify  -e custom-branding-icon-afn-red --mount"
    )
    input("Press Enter to continue.")


def ytnonroot(adb):  # Building YouTube Revanced NonRoot
    print("---Uninstalling YouTube---\n.\n.")
    System(f"{ADB_PATH} -s {adb} uninstall com.google.android.youtube")

    print("---Build YouTube ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    System(f"{JAVA_PATH} -jar revanced-cli-all.jar -a youtube1.apk -c -d {adb} -o revanced_youtube.apk -b revanced-patches.jar -m revanced-integrations.apk -e premium-heading -e custom-branding-name -e custom-branding-icon-revancify  -e custom-branding-icon-afn-red -e sponsorblock -i swipe-controls --experimental")

    input("Press Enter to continue.")


def ytmroot(adb):  # Building YT Music Revanced NonRoot
    print("---Uninstalling YouTube Music---\n.\n.")
    System(f"ADB_PATH -s {adb} uninstall com.google.android.apps.youtube.music")

    print("---Installing YouTube Music---\n.\n.")
    System(f"ADB_PATH -s {adb} install youtube2.apk")

    print("---Build YouTube Music ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    System(f"{JAVA_PATH} -jar revanced-cli-all.jar -a youtube2.apk -c -d {adb} -o revanced_music.apk -b revanced-patches.jar -m revanced-integrations.apk -e music-microg-support -e custom-branding-music-afn-red -e custom-branding-music-revancify --mount --experimental"
    )
    input("Press Enter to continue.")


def ytmnonroot(adb):  # Building YT Music Revanced NonRoot
    print("---Uninstalling YouTube Music---\n.\n.")
    System(f"ADB_PATH -s {adb} uninstall com.google.android.apps.youtube.music")

    print("---Build YouTube Music ReVanced Root---\n.\n.")
    print("When building is over, close app in your phone")
    System(f"{JAVA_PATH} -jar revanced-cli-all.jar -a youtube2.apk -c -d {adb} -o revanced_music.apk -b revanced-patches.jar -m revanced-integrations.apk -e custom-branding-music-afn-red -e custom-branding-music-revancify --experimental"
    )
    input("Press Enter to continue.")
