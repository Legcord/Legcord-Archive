# Legcord
A minimal experimental alternative to official Discord client. Built using webview which allows it to be small and fast!    
# Functionality
| **Feature**  | **ArmCord** | **Legcord** |
|--------------------|-------------|-------------|
| Tray icon          |     ✔️     |      ❌     |
| Graphical settings |     ✔️     |      ❌     |
| Smaller size       |      ❌     |     ✔️     |
| Client modding     |     ✔️     |      ❌     |
| Blocks trackers    |     ✔️     |      ❌     |
| Screen sharing     |     ✔️     |      ❌     |
| Portable           |      ❌     |     ✔️     |  
## Why this and not ArmCord?
While ArmCord is more feature rich and generally more stable, Legcord is made to be minimal and fast. ArmCord is built using Electron framework which limits control over resource usage. It is famous for having poor performance (if not used properly) and bundling entire web browser with every app, causing it to take a lot of hard drive space. While this is still not perfect (still a web browser), it gives user choice for web engine which they wanna use. It doesn't bundle web engines in itself but uses built-in system ones which saves space and usually makes it run more efficiently.
# Installation
Download the executable from [releases tab](https://github.com/ArmCord/Legcord/releases) and move it into some folder. Legcord will store it's files and configurations there. There are plans to add an automatic installer.
# Dependencies
## Windows
To use this you need [WebView2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/). CEF framework support is also planned in the future.
## Linux
### GTK
To install dependencies, run the following command (ubuntu):
```sh
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-webkit2-4.0
```
Note that WebKit2 version 2.22 or greater is required for certain features to work correctly. If your distribution ships with an older version, you may need to install it manually from a backport.
### Qt
> :warning: **Qt is not the default engine**: To force it set this env value `PYWEBVIEW_GUI=qt`!   

Legcord supports both QtWebChannel (newer and preferred) and QtWebKit implementations. Use QtWebChannel, unless it is not available on your system.   
To install QtWebChannel on Debial-based systems (more modern, preffered):
```sh
sudo apt install python3-pyqt5 python3-pyqt5.qtwebengine python3-pyqt5.qtwebchannel libqt5webkit5-dev
```
To install QtWebKit (legacy, but available on more platforms):
```sh
sudo apt install python3-pyqt5 python3-pyqt5.qtwebkit python-pyqt5 python-pyqt5.qtwebkit libqt5webkit5-dev
```
### Which one is better?
From my own testing Qt tends to be slower but more compatible. I'm on Wayland and I couldn't get the GTK webkit to load, however maybe you'll have more luck
# Supported web engines
| Platform | Code         | Renderer | Provider                                          | Browser compatibility |
|----------|--------------|----------|---------------------------------------------------|-----------------------|
| GTK      | gtk          | WebKit   | WebKit2                                           |                       |
| macOS    |              | WebKit   | WebKit.WKWebView (bundled with OS)                |                       |
| QT       | qt           | WebKit   | QtWebEngine / QtWebKit                            |                       |
| Windows  | edgechromium | Chromium | > .NET Framework 4.6.2 and Edge Runtime installed | Ever-green Chromium   |
| Windows  | edgehtml     | EdgeHTML | > .NET Framework 4.6.2 and Windows 10 build 17110 |                       |
| Windows  | mshtml (unsupported) | MSHTML   | MSHTML via .NET / System.Windows.Forms.WebBrowser | IE11 (Windows 10/8/7) |
| Windows  | cef          | CEF      | CEF Python                                        | Chrome 66             |

On Windows renderer is chosen in the following order: `edgechromium`, `edgehtml`, `mshtml`. `mshtml` is the only renderer that is guaranteed to be available on any system. Note that Edge Runtime must be installed in order to use Edge Chromium on Windows. You can download it from [here](https://developer.microsoft.com/en-us/microsoft-edge/webview2/). Distribution guidelines are found [here](https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution).

To change a default renderer set `PYWEBVIEW_GUI` environment variable. Check for available values in the Code column from the table above.

For example to use CEF on Windows

``` bash
PYWEBVIEW_GUI=cef
```
To force QT on Linux systems

``` bash
PYWEBVIEW_GUI=qt
```
# Known issues and limitations
## CEF Windows
Basically unimplemented and untested however I want to add it as a replacement for Edge runtime on machines running Windows pre-10.
## Poor Wayland support
For some reason Legcord has really poor performance on Wayland. It also struggles with compability (GTK Webkit doesn't work on some systems).
## No context menus
We need to reimplement them manually on some platforms.
## No macOS support
I don't own anything running macOS which means I simply can't develop for it.