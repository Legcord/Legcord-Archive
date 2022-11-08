import tinydialogs
import strformat
import os
import system
import json
import strutils
import puppy
import osproc
type
  pythonDownload = object
    platform: string
    url: string
    fileExtension: string
const pythonFile = staticRead("engine.py")
let download = [
    pythonDownload(platform: "linux", url:"https://github.com/indygreg/python-build-standalone/releases/download/20221106/cpython-3.8.15+20221106-x86_64-unknown-linux-gnu-pgo+lto-full.tar.zst", fileExtension: ".tar.zst"),
    pythonDownload(platform: "windows", url:"placeholder", fileExtension: ".zip")
]

proc start() =
    var savePath: string
    var config = parseJson(readFile("storage.json"))
    if endsWith(config["pythonPath"].getStr(), "3"):
        savePath = config["pythonPath"].getStr()[.. ^8]
    else:
        savePath = config["pythonPath"].getStr()[.. ^7]
    writeFile(savePath & "engine.py", pythonFile)
    if execCmd(config["pythonPath"].getStr() & " " & savePath & "engine.py") == 0:
        echo "Installed webview engine"
    else:
        discard execCmd(savePath & "pip install pywebview[qt]")

proc install(pythonPath: string) =
    echo fmt"Using `{pythonPath}` executable"
    discard execCmd(pythonPath & " -c 'print(3.0/2)'")
    if execCmd("pip3 install pywebview") == 0:
        echo "Installed webview engine"
    elif execCmd("pip install pywebview") == 0:
        echo "Installed webview engine"
    elif execCmd(pythonPath[.. ^8] & "pip install pywebview") == 0:
        echo "Installed webview engine"
    else:
        echo messageBox("Legcord Installer", "Installation has failed. We weren't able to find pip package manager on your system. Please install it!", Ok, Error, Yes)
    var save = %* {"pythonPath": pythonPath, "isWebviewInstalled": true}
    writeFile("storage.json", $save)
    let choice = messageBox("Legcord Installer", "Would you like to start Legcord?", YesNo, Question, Yes)
    if choice == Cancel:
        quit(0)
    else:
        start()

if fileExists("storage.json"):
    start()
else:
    let choice = messageBox("Legcord Installer", "Would you like to start Legcord installation?", YesNo, Question, Yes)
    if choice == Cancel:
            echo messageBox("Legcord Installer", "Installation has failed.", Ok, Error, Yes)
    else:
        echo "Trying to find working Python install"
        if execCmd("python -c 'print(3.0/2)'") == 0:
            install("python")
        elif execCmd("python3 -c 'print(3.0/2)'") == 0:
            install("python3")
        else:
            let choice = messageBox("Legcord Installer", "We were not able to find Python3 installed on your system, would you like us to install it for you?", YesNo, Question, Yes)
            echo choice
            if choice == Cancel:
                echo messageBox("Legcord Installer", "Installation has failed. Please either install a working Python3 install or let Legcord install it for you.", Ok, Error, Yes)
            elif choice == Yes:
                echo "Installing python"
                for pythonDownload in download:
                    if pythonDownload.platform == hostOS:
                        if fileExists("python" & pythonDownload.fileExtension):
                            echo("Python is already saved locally, if you would like to redownload it then just remove the file.")
                        else:
                            writeFile("python" & pythonDownload.fileExtension, fetch(pythonDownload.url))
                        if hostOS == "linux":
                            if execCmd("tar -xf python" & pythonDownload.fileExtension) == 0:
                                install("python/install/bin/python3")
                            else:
                                echo messageBox("Legcord Installer", "Installation has failed. Check if you have tar installed or if you have stable internet connection", Ok, Error, Yes)
                        elif hostOS == "windows":
                            writeFile(getTempDir() & "tar.exe", fetch("https://armcord.xyz/tar.exe"))
                            writeFile(getTempDir() & "libiconv-2.dll", fetch("https://armcord.xyz/libiconv-2.dll"))
                            writeFile(getTempDir() & "libintl-2.dll", fetch("https://armcord.xyz/libintl-2.dll"))
                            if execCmd(getTempDir() & "tar.exe -xf " & getCurrentDir() & pythonDownload.fileExtension) == 0:
                                install("") #todo
                            else:
                                echo messageBox("Legcord Installer", "Installation has failed. Check if you have tar installed or if you have stable internet connection", Ok, Error, Yes)