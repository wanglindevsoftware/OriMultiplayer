@echo off
setlocal
for %%I in ("%~dp0.") do set "GAME=%%~fI"
set "HOST=%GAME%\OriMultiplayerTestHost"
set "CLIENT=%GAME%\OriMultiplayerTestClient"
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "STAMP=%%I"
set "OUT=%GAME%\OriMultiplayerLogs-%STAMP%"
mkdir "%OUT%\Host" >nul 2>nul
mkdir "%OUT%\Client" >nul 2>nul
for %%F in (multiplayer_sync.log modloader_log.csv unity.log) do if exist "%HOST%\%%F" copy /y "%HOST%\%%F" "%OUT%\Host\%%F" >nul
for %%F in (multiplayer_sync.log modloader_log.csv unity.log) do if exist "%CLIENT%\%%F" copy /y "%CLIENT%\%%F" "%OUT%\Client\%%F" >nul
powershell -NoProfile -Command "$d='%LOCALAPPDATA%\CrashDumps'; if(Test-Path -LiteralPath $d){ Get-ChildItem -LiteralPath $d -Filter 'oriwotw.exe.*.dmp' | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | Copy-Item -Destination '%OUT%\Host'; Get-ChildItem -LiteralPath $d -Filter 'oriwotw_client.exe.*.dmp' | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | Copy-Item -Destination '%OUT%\Client' }"
powershell -NoProfile -Command "$start=(Get-Date).AddDays(-1); Get-WinEvent -FilterHashtable @{LogName='Application'; StartTime=$start; Id=1000,1001} -ErrorAction SilentlyContinue | Where-Object { $_.Message -match 'oriwotw' } | Select-Object TimeCreated,Id,ProviderName,Message | Format-List | Out-File -Encoding utf8 '%OUT%\crash-events.txt'"
powershell -NoProfile -Command "Compress-Archive -LiteralPath '%OUT%' -DestinationPath '%OUT%.zip' -Force"
echo Logs saved to:
echo %OUT%.zip
pause
