@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

:loop
    SET /p input="Enter URL: "
"youtube-dl.exe" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]" -o "../%%(title)s" %input%
call :colorEcho a0 "Finished!"
echo.
goto loop

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i