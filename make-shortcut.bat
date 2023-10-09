@echo off

:: Check if the default desktop location exists
if exist "%userprofile%\Desktop\" (
    set DesktopPath=%userprofile%\Desktop
) else (
    :: Fetch the desktop location from the registry
    for /f "tokens=2* delims=   " %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set DesktopPath=%%b
    :: Replace %USERPROFILE% environment variables in the path
    set DesktopPath=%DesktopPath:%USERPROFILE%=%userprofile%
)

set SHORTCUTPATH="%DesktopPath%\StableSwarmUI.url"

(
echo [InternetShortcut]
echo URL="%CD%\launch-windows.bat"
echo IconFile="%CD%\src\wwwroot\favicon.ico"
echo IconIndex=0
) >> "%SHORTCUTPATH%"

pause
