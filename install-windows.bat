@echo off

set INSTALL_PATH=%~dp0

echo | set /p dummy=Enter the installation path (default is the current directory): 
set /p USER_PATH=

if not "%USER_PATH%"=="" set INSTALL_PATH=%USER_PATH%

if not exist "%INSTALL_PATH%" (
    echo The provided path does not exist.
    pause
    exit
)

cd /d "%INSTALL_PATH%"

echo Installation path selected is "%INSTALL_PATH%StableSwarmUI". Continue? [Y/n]
set /p userChoice=Press Enter to continue or type 'n' to cancel:
if /i "%userChoice%"=="n" (
    echo Installation cancelled.
    exit
)


if exist StableSwarmUI (
    echo StableSwarmUI is already installed in this folder. If this is incorrect, delete the 'StableSwarmUI' folder and try again.
    pause
    exit
)

if exist StableSwarmUI.sln (
    echo StableSwarmUI is already installed in this folder. If this is incorrect, delete 'StableSwarmUI.sln' and try again.
    pause
    exit
)

echo Checking other components installation ...

winget show Microsoft.DotNet.SDK.7 >NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Microsoft.DotNet.SDK.7 is already installed.
) else (
    echo Installing Microsoft.DotNet.SDK.7 ...
    winget install Microsoft.DotNet.SDK.7 --accept-source-agreements --accept-package-agreements
)

winget show Git.Git >NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Git is already installed.
) else (
    echo Installing Git ...
    winget install --id Git.Git -e --source winget --accept-source-agreements --accept-package-agreements
)

git clone https://github.com/arafatx/StableSwarmUI 
cd StableSwarmUI

call .\make-shortcut.bat
call .\launch-windows.bat --launch_mode webinstall
IF %ERRORLEVEL% NEQ 0 ( pause )
