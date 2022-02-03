# Package

version       = "1.0.0"
author        = "smartfrigde"
description   = "A minimal custom client for Discord that keeps everything lightweight while using official web app"
license       = "MIT"
srcDir        = "src"
bin           = @["legcord"]


# Dependencies

requires "nim >= 1.6.2", "https://github.com/ArmCord/LegUI.git == 1.0.0"