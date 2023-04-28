from os import system as System
import os
import time
import platform

if platform.system() == "Linux":
    from brwf.global_variables import ADB_PATH_LINUX as ADB_PATH
else:
    from brwf.global_variables import ADB_PATH_WIN as ADB_PATH


def check_adb():
    print("---Check ADB connection---\n.")
    System(f"{ADB_PATH} kill-server")
    System(f"{ADB_PATH} start-server")

    print(".\nGive ADB access to this PC, if its needed\n")
    # Check that phone connected to PC
    System("adb devices")
    time.sleep(5)
    adb = ""
    if os.path.isfile("./adb.txt") is False:
        adbw = input("Type or copy your adb number (only number): ")
        print(".\n.")
        with open("./adb.txt", "w") as adb_txt:
            print(adbw, file=adb_txt)
            adb_txt.close()
        adb = adbw
    else:
        with open("adb.txt", "r") as adb_txt:
            while True:
                char = adb_txt.read(1)
                if ord(char) == 10:
                    break
                adb += char
        adb_txt.close()

    print(f"Your devices: {adb}\n.\n.")
    print(
        """
        If its diffrent delete adb.txt and run script again
        or
        copy your ADB device number and replace it instead of number in adb.txt\n.\n.\n.\n.
        """
    )
    return adb
