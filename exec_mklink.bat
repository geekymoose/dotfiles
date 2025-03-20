@echo off
REM A simple bat script to create the symlinks on Windows
REM this is a simple equivalent to the stow script

echo Creating the Windows configuration symlinks...
echo Current env variables:
echo - AppData: %LOCALAPPDATA%
echo - Home: %USERPROFILE%
echo - PWD: %CD%

call :mklink_config "%LOCALAPPDATA%\nvim\"          "%CD%\src\nvim\.config\nvim\"
call :mklink_config "%USERPROFILE%\.gitconfig"      "%CD%\src\git\.config\git\config"


REM ----------------------------------------------------------------------------
REM Function mklink_config
REM Create symlink to a folder config
REM ----------------------------------------------------------------------------

:mklink_config

SET config_dst_path=%1
SET config_src_path=%2

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

