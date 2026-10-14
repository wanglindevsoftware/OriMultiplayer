@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Ori Multiplayer - Network Alpha version - Wang Lin
echo Ori Multiplayer - Network Alpha version
echo Author: Wang Lin
set "ORI_MULTIPLAYER_NO_AUDIO=1"
if /I "%~1"=="--sound" set "ORI_MULTIPLAYER_NO_AUDIO="
if defined ORI_MULTIPLAYER_NO_AUDIO (
    echo Safe launch: sound is disabled to avoid the Wwise startup crash.
) else (
    echo Sound enabled by request. The Wwise startup crash may return.
)
if not exist "%~dp0oriwotw.exe" (
    echo Extract the archive contents into the game folder, next to oriwotw.exe.
    goto failed
)
for %%F in ("GameAssembly.dll" "winhttp.dll" "OriMultiplayerMod\Modloader.dll" "OriMultiplayerMod\Core.dll" "OriMultiplayerMod\Multiplayer.dll" "OriMultiplayerMod\modloader_config.json") do (
    if not exist "%~dp0%%~F" (
        echo Missing file: %%~F
        echo Extract all files from the archive before starting the game.
        goto failed
    )
)
for %%F in ("%~dp0GameAssembly.dll") do if not "%%~zF"=="73937920" (
    echo Unsupported game version. This mod requires the April 2020 version.
    goto failed
)
start "" /D "%~dp0" "%~dp0oriwotw.exe" -m "%~dp0OriMultiplayerMod" -logFile "%~dp0OriMultiplayerMod\unity.log"
if errorlevel 1 goto failed
exit /b 0
:failed
pause
exit /b 1
