@echo off
setlocal enabledelayedexpansion

:: Attempt to set the DesktopPath using the default location
if exist "%userprofile%\Desktop\" (
    set DesktopPath=%userprofile%\Desktop
) else (
    :: If not found, try to fetch the desktop location from the registry
    for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do (
        set DesktopPath=%%b
    )
    :: Replace potential environment variables in the path
    set DesktopPath=!DesktopPath:%USERPROFILE%=%userprofile%!
)

if not defined DesktopPath (
    echo Error: Could not determine Desktop path.
    exit /b
)

set SHORTCUTPATH="!DesktopPath!\StableSwarmUI.url"

(
echo [InternetShortcut]
echo URL="%CD%\launch-windows.bat"
echo IconFile="%CD%\src\wwwroot\favicon.ico"
echo IconIndex=0
) >> !SHORTCUTPATH!
