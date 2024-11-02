@echo off
SETLOCAL

REM Define the Python executable and script paths
SET PYTHON_EXEC=C:\Users\L33T\AppData\Local\Programs\Python\Python313\python.exe
SET PYTHON_VERSION=3.13
SET REQUIREMENTS_FILE=requirements.txt
SET MAIN_SCRIPT=main.py

REM Check Python installation and version
FOR /F "tokens=2 delims==" %%I IN ('"%PYTHON_EXEC%" --version 2^>nul') DO (
    SET PYTHON_VERSION_INSTALLED=%%I
)

IF NOT DEFINED PYTHON_VERSION_INSTALLED (
    echo Python is not installed or not found at %PYTHON_EXEC%.
    echo Skipping Python version check and moving on...
) ELSE (
    REM Check if the installed version matches the required version
    IF NOT "%PYTHON_VERSION_INSTALLED%"=="%PYTHON_VERSION%" (
        echo Installed Python version is %PYTHON_VERSION_INSTALLED%, but %PYTHON_VERSION% is required.
        pause
        exit /b 1
    )
    echo Python %PYTHON_VERSION% is installed.
)

REM Upgrade pip before installing requirements
echo Upgrading pip...
"%PYTHON_EXEC%" -m pip install --upgrade pip
IF ERRORLEVEL 1 (
    echo Failed to upgrade pip.
    pause
    exit /b 1
)

REM Install requirements from requirements.txt if it exists
IF EXIST "%REQUIREMENTS_FILE%" (
    echo Installing requirements from %REQUIREMENTS_FILE%...
    "%PYTHON_EXEC%" -m pip install -r "%REQUIREMENTS_FILE%"
    
    REM Check if pip installation was successful
    IF ERRORLEVEL 1 (
        echo Failed to install requirements from %REQUIREMENTS_FILE%.
        pause
        exit /b 1
    )
) ELSE (
    echo Requirements file %REQUIREMENTS_FILE% not found.
    pause
)

REM Launch the main.py script
echo Launching main.py...
"%PYTHON_EXEC%" "%MAIN_SCRIPT%"
IF ERRORLEVEL 1 (
    echo An error occurred while running main.py.
    pause
)

ENDLOCAL