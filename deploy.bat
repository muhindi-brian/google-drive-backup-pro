@echo off
echo ========================================
echo   DriveBackup Pro Website Deployment
echo ========================================
echo.

echo 🚀 Starting deployment process...
echo.

echo 1. Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)
echo ✅ Node.js is installed

echo.
echo 2. Installing dependencies...
npm install
if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies!
    pause
    exit /b 1
)
echo ✅ Dependencies installed successfully

echo.
echo 3. Setting up environment variables...
if not exist .env (
    echo Creating .env file from template...
    copy env.example .env
    echo.
    echo ⚠️  IMPORTANT: Please edit the .env file with your actual credentials:
    echo    - GMAIL_USER: Your Gmail username
    echo    - GMAIL_PASS: Your Gmail app password
    echo    - SUPPORT_EMAIL: Your support email address
    echo.
    echo Press any key to open .env file for editing...
    pause >nul
    notepad .env
) else (
    echo ✅ .env file already exists
)

echo.
echo 4. Testing the application...
echo Starting server on http://localhost:3000
echo.
echo 📋 Deployment Summary:
echo    - Server will run on port 3000
echo    - CSS files will be served with proper MIME types
echo    - Contact form will send emails via Gmail SMTP
echo    - All static files are properly configured
echo.
echo 🌐 To access your website:
echo    Local: http://localhost:3000
echo    Live: https://drive.mojokgroup.xyz (after server setup)
echo.
echo 🔧 For production deployment:
echo    1. Upload all files to your server
echo    2. Run 'npm install' on the server
echo    3. Set up .env file with production credentials
echo    4. Configure reverse proxy (Nginx/Apache)
echo    5. Use PM2 for process management
echo.
echo Press any key to start the server...
pause >nul

echo.
echo 🚀 Starting DriveBackup Pro server...
echo.
npm start
