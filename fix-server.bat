@echo off
echo ========================================
echo   Fixing DriveBackup Pro Server Issues
echo ========================================
echo.

echo 🔍 Checking current server status...
echo.

echo 1. Checking if Node.js is installed...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)
echo ✅ Node.js is installed

echo.
echo 2. Checking dependencies...
if not exist node_modules (
    echo 📦 Installing dependencies...
    npm install
) else (
    echo ✅ Dependencies already installed
)

echo.
echo 3. Checking .env file...
if not exist .env (
    echo ⚠️  .env file missing! Creating from template...
    copy env.example .env
    echo Please edit .env file with your credentials
    notepad .env
) else (
    echo ✅ .env file exists
)

echo.
echo 4. Testing server locally...
echo Starting server on http://localhost:3000
echo.
echo 📋 Server Configuration:
echo    - Static files: CSS, JS, HTML properly served
echo    - MIME types: Correct content types set
echo    - Security headers: CORS and security configured
echo    - Contact form: Email functionality ready
echo.

echo 🚀 Starting DriveBackup Pro server...
echo.
echo 🌐 Access your website at:
echo    Local: http://localhost:3000
echo    Live: https://drive.mojokgroup.xyz (after server setup)
echo.
echo ⚠️  IMPORTANT: For live server deployment:
echo    1. Upload all files to your server
echo    2. Run 'npm install' on the server
echo    3. Set up .env file with production credentials
echo    4. Configure reverse proxy (Nginx/Apache)
echo    5. Use PM2 for process management
echo.
echo Press any key to start the server...
pause >nul

echo.
echo 🚀 Starting server...
npm start
