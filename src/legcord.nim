import tinydialogs
import strformat
import os
import osproc

proc install(pythonPath: string) =
    echo fmt"Using `{pythonPath}` executable"

if fileExists("storage.json"):
    echo("no way")
else:
    let choice = messageBox("Legcord Installer", "Would you like to start Legcord installation?", YesNo, Question, Yes)
    if choice == Cancel:
            echo messageBox("Legcord Installer", "Installation has failed.", Ok, Error, Yes)
    else:
        echo "Trying to find working Python install"
        if execCmd("pythfon -c 'print(3.0/2)'") == 0:
            install("python")
        elif execCmd("pythfon3 -c 'print(3.0/2)'") == 0:
            install("python3")
        else:
            let choice = messageBox("Legcord Installer", "We were not able to find Python3 installed on your system, would you like us to install it for you?", YesNo, Question, Yes)
            echo choice
            if choice == Cancel:
                echo messageBox("Legcord Installer", "Installation has failed. Please either install a working Python3 install or let Legcord install it for you.", Ok, Error, Yes)
            elif choice == Yes:
                echo "yes"