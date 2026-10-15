@echo off
rem Creates a new addon - double-click this file, or run tools\new-addon.bat from the repo root
rem Any arguments are passed on to new-addon.ps1, e.g. tools\new-addon.bat -Name my_addon

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0new-addon.ps1" %*
set "EXITCODE=%ERRORLEVEL%"

rem Keep the window open when started by double-click, so the result can be read
rem A double-click runs: cmd.exe /c ""<path>\new-addon.bat" "   - the trailing space is what sets it apart from a terminal
set "LAUNCHER=%CMDCMDLINE:"=%"
if /i "%LAUNCHER:~-5%"==".bat " pause

exit /b %EXITCODE%
