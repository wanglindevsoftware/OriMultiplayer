@echo off
setlocal
for %%I in ("%~dp0.") do set "GAME=%%~fI"
set "SOURCE=%GAME%\OriMultiplayerMod"
set "HOST=%GAME%\OriMultiplayerTestHost"
set "CLIENT=%GAME%\OriMultiplayerTestClient"
set "HOST_SAVES=%GAME%\OriMultiplayerTestSavesHost"
set "CLIENT_SAVES=%GAME%\OriMultiplayerTestSavesClient"
set "ORI_SAVES=%LOCALAPPDATA%\Ori and the Will of The Wisps"
set "CLIENT_EXE=%GAME%\oriwotw_client.exe"
set "CLIENT_DATA=%GAME%\oriwotw_client_Data"
if not exist "%GAME%\oriwotw.exe" goto missing
if not exist "%SOURCE%\Multiplayer.dll" goto missing
if not exist "%HOST%" mkdir "%HOST%"
if not exist "%CLIENT%" mkdir "%CLIENT%"
if not exist "%HOST_SAVES%" mkdir "%HOST_SAVES%"
if not exist "%CLIENT_SAVES%" mkdir "%CLIENT_SAVES%"
if not exist "%HOST_SAVES%\saveFile*.uberstate" if exist "%ORI_SAVES%\saveFile*.uberstate" copy /y "%ORI_SAVES%\saveFile*.uberstate" "%HOST_SAVES%\" >nul
if not exist "%CLIENT_SAVES%\saveFile*.uberstate" if exist "%ORI_SAVES%\saveFile*.uberstate" copy /y "%ORI_SAVES%\saveFile*.uberstate" "%CLIENT_SAVES%\" >nul
if not exist "%CLIENT_EXE%" copy /y "%GAME%\oriwotw.exe" "%CLIENT_EXE%" >nul
if not exist "%CLIENT_DATA%" mklink /J "%CLIENT_DATA%" "%GAME%\oriwotw_Data" >nul
for %%F in (Modloader.dll Core.dll Multiplayer.dll modloader_config.json) do copy /y "%SOURCE%\%%F" "%HOST%\%%F" >nul
for %%F in (Modloader.dll Core.dll Multiplayer.dll modloader_config.json) do copy /y "%SOURCE%\%%F" "%CLIENT%\%%F" >nul
> "%HOST%\multiplayer.json" (
 echo {
 echo   "address": "127.0.0.1",
 echo   "name": "Host",
 echo   "port": 31415,
 echo   "sync_world": true,
 echo   "sync_progress": true,
 echo   "disable_audio": true,
 echo   "save_folder": "%HOST_SAVES:\=/%"
 echo }
)
> "%CLIENT%\multiplayer.json" (
 echo {
 echo   "address": "127.0.0.1",
 echo   "name": "Client",
 echo   "port": 31415,
 echo   "sync_world": true,
 echo   "sync_progress": true,
 echo   "disable_audio": true,
 echo   "save_folder": "%CLIENT_SAVES:\=/%"
 echo }
)
start "Ori Host" /D "%GAME%" "%GAME%\oriwotw.exe" -m "%HOST%" -screen-fullscreen 0 -screen-width 960 -screen-height 540 -logFile "%HOST%\unity.log"
ping 127.0.0.1 -n 5 >nul
start "Ori Client" /D "%GAME%" "%CLIENT_EXE%" -m "%CLIENT%" -screen-fullscreen 0 -screen-width 960 -screen-height 540 -logFile "%CLIENT%\unity.log"
exit /b 0
:missing
echo Ori Multiplayer is not installed.
pause
exit /b 1
