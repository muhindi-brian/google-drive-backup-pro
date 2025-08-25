@echo off
echo ========================================
echo   Google Verification Deployment
echo   DriveBackup Pro
echo ========================================
echo.

echo 🚀 Starting Google verification deployment...
echo.

echo 1. Checking current setup...
if not exist .env (
    echo ❌ .env file missing! Creating from template...
    copy env.example .env
    echo ⚠️  Please edit .env file with your credentials
    notepad .env
) else (
    echo ✅ .env file exists
)

echo.
echo 2. Installing dependencies...
npm install

echo.
echo 3. Starting server for testing...
echo.
echo 📋 Google Verification Checklist:
echo    ✅ Company information added to homepage
echo    ✅ SEO meta tags added
echo    ✅ Privacy policy and terms accessible
echo    ✅ Contact information displayed
echo    ✅ Professional design implemented
echo.
echo 🌐 Your website will be available at:
echo    Local: http://localhost:3000
echo    Live: https://drive.mojokgroup.xyz
echo.
echo 🔧 Next Steps for Google Verification:
echo    1. Add your Google verification code to index.html
echo    2. Verify domain ownership in Google Search Console
echo    3. Update app information in Google Cloud Console
echo    4. Reply to Google's Trust and Safety team
echo.
echo 📞 Contact Information for Google:
echo    Company: Mojok Dev ke. Solutions
echo    Email: drive@mojokgroup.xyz
echo    Phone: +254798564925
echo    Address: Residence 13, Ongata Rongai, Kajiado Kenya
echo.
echo Press any key to start the server...
pause >nul

echo.
echo 🚀 Starting DriveBackup Pro server...
echo.
npm start
