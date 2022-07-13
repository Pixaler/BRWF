# Script for building ReVanced (BRWF)
Scripts that automatically download and build Youtube Revanced

## Requirements
- [platform-tools](https://developer.android.com/studio/releases/platform-tools)
- [Zulu JDK 17](https://www.azul.com/downloads/?version=java-17-lts&os=windows&architecture=x86-64-bit&package=jdk)
- [GitHub CLI](https://cli.github.com/)
- [YouTube](https://www.apkmirror.com/apk/google-inc/youtube/) and [YouTube Music](https://www.apkmirror.com/apk/google-inc/youtube-music/) apk
## Instalation
1. Rename YouTube apk to ***youtube1.apk***. YouTube Music apk to ***youtube2.apk***.
I recommend do patch to version which pointed in [ReVanced Documentaion](https://github.com/revanced/revanced-documentation/wiki/Prerequisites)
2. Put apk into platform-tools folder
3. Run build.cmd
# Notice
- When run script first time type this before:
```
adb shell su -c exit
```
It is necessary to check root access 
- Don't forget to trust your PC when it try to connect to your phone
