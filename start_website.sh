#!/bin/bash

echo "========================================"
echo "  DriveBackup Pro Website Launcher"
echo "========================================"
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed or not in PATH"
    echo "Please install Node.js from https://nodejs.org/"
    echo
    exit 1
fi

echo "Node.js version:"
node --version
echo

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "ERROR: package.json not found"
    echo "Please run this script from the website directory"
    echo
    exit 1
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to install dependencies"
        echo
        exit 1
    fi
    echo
fi

echo "Starting DriveBackup Pro Website..."
echo
echo "The website will be available at:"
echo "  http://localhost:3000"
echo
echo "Press Ctrl+C to stop the server"
echo

npm start

