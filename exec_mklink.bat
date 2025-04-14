@echo off
REM A simple bat script to create the symlinks on Windows
REM this is a simple equivalent to the stow script

echo Creating the Windows configuration symlinks...
echo Current env variables:
echo - AppData Local: %LOCALAPPDATA%
echo - AppData Roaming: %APPDATA%
echo - Home: %USERPROFILE%
echo - PWD: %CD%

call :crea_conf "%CD%\src\autohotkey\.config\autohotkey\"               "%USERPROFILE%\.local\bin\autohotkey\"
call :crea_conf "%CD%\src\nvim\.config\nvim\"                           "%LOCALAPPDATA%\nvim\"
call :crea_conf "%CD%\src\git\.config\git\config"                       "%USERPROFILE%\.gitconfig"
call :crea_conf "%CD%\src\powershell\.config\powershell\config.ps1"     "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
call :crea_conf "%CD%\src\powershell\.config\powershell\config.ps1"     "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
call :crea_conf "%CD%\src\yazi\.config\yazi\yazi.toml"                  "%APPDATA%\yazi\config\yazi.toml"

REM Stop the script here, otherwise the functions will be run without parameters
goto :eof

REM ----------------------------------------------------------------------------
REM Function mklink_config
REM Create symlink to a folder config
REM ----------------------------------------------------------------------------
:crea_conf
SET config_src_path=%1
SET config_dst_path=%2
if exist "%config_dst_path%" (
    echo [OK] Config already set: %config_dst_path%
    goto :eof
)
if not exist "%config_src_path%" (
    echo [ERR] Invalid src path: %config_src_path% does not exist
    goto :eof
) else (
    REM Check if it is a folder to use the righ mklink parameter (\D for folder)
    REM It is about the "\" at the end
    if exist "%config_src_path%\" (
        mklink /D "%config_dst_path%" "%config_src_path%"
    ) else (
        mklink %config_dst_path% %config_src_path%
    )
    if %errorlevel% neq 0 (
        echo [ERR] Failed to create symlink for %config_dst_path%
    )
)
goto :eof
REM ----------------------------------------------------------------------------

