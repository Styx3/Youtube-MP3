@echo off

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

IF NOT EXIST "music.lst" (
:loop
    SET /p input="Enter URL:"
timeout 1 > nul
youtube-dl.exe --audio-format mp3 --ffmpeg-location "." --extract-audio -o "../%%(title)s.(ext)s" %input%
call :colorEcho a0 "Finished!"
echo.
goto loop

) ELSE (
youtube-dl.exe -a "music.lst" --audio-format mp3 --ffmpeg-location "." --extract-audio -o "../%%(title)s.(ext)s"
exit 0
)

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i