@echo off
SETLOCAL

REM Verifica se a pasta atual já é um repositório Git
IF EXIST ".git" (
    echo Detected ponasound-track-shop repository at the current directory. Checking if its correctly tracking the expected remote branch...
    for /f "tokens=*" %%i in ('git remote get-url origin') do set CURRENT_REMOTE=%%i
    set EXPECTED_REMOTE=git@github.com:SatouYuri/ponasound-track-shop.git
    IF /I "%CURRENT_REMOTE%"=="%EXPECTED_REMOTE%" (
        echo Correct origin asserted. Executing git pull...
        git pull origin main
    ) ELSE (
        echo This folder is a git repository, but its origin is incorrect.
        echo Correcting origin to: %EXPECTED_REMOTE%
        git remote set-url origin %EXPECTED_REMOTE%
        git pull origin main
    )
) ELSE (
    echo Current directory doesn't correspond to ponasound-track-shop repository and it's not even a git repository itself. 
    echo Cloning updated ponasound-track-shop to the current directory...

    git clone %EXPECTED_REMOTE% temp-clone
    xcopy temp-clone\* . /E /H /C /I /Y
    rmdir /S /Q temp-clone

    echo Finished cloning ponasound-track-shop. You can execute this .bat again to get the latest songs, if any. Have fun!
)

ENDLOCAL
pause
