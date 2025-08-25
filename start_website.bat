@echo off
echo ========================================
echo   DriveBackup Pro Website Launcher
echo ========================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo Node.js version:
node --version
echo.

REM Check if package.json exists
if not exist "package.json" (
    echo ERROR: package.json not found
    echo Please run this script from the website directory
    echo.
    pause
    exit /b 1
)

REM Install dependencies if node_modules doesn't exist
if not exist "node_modules" (
    echo Installing dependencies...
    npm install
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install dependencies
        echo.
        pause
        exit /b 1
    )
    echo.
)

echo Starting DriveBackup Pro Website...
echo.
echo The website will be available at:
echo   http://localhost:3000
echo.
echo Press Ctrl+C to stop the server
echo.

npm start

pause

