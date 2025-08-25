@echo off
echo Setting up environment variables for DriveBackup Pro...
echo.

if exist .env (
    echo .env file already exists!
    echo Please backup your current .env file and run this script again.
    pause
    exit /b 1
)

echo Creating .env file from env.example...
copy env.example .env

if exist .env (
    echo.
    echo ✅ .env file created successfully!
    echo.
    echo Please review and update the .env file with your actual credentials:
    echo - GMAIL_USER: Your Gmail username
    echo - GMAIL_PASS: Your Gmail app password
    echo - SUPPORT_EMAIL: Your support email address
    echo.
    echo The .env file is now in your project directory.
    echo Remember: Never commit the .env file to version control!
    echo.
) else (
    echo.
    echo ❌ Failed to create .env file!
    echo Please manually copy env.example to .env and update the values.
    echo.
)

echo Press any key to continue...
pause > nul
