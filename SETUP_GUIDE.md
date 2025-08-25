# 🚀 DriveBackup Pro Website - Node.js Setup Guide

This guide will walk you through setting up and running the DriveBackup Pro website using Node.js.

## ✅ Prerequisites Check

First, let's verify you have Node.js installed:

### Windows (PowerShell/Command Prompt)
```powershell
node --version
npm --version
```

### Linux/macOS (Terminal)
```bash
node --version
npm --version
```

**Expected Output:**
- Node.js version: v14.0.0 or higher
- npm version: 6.0.0 or higher

## 🛠️ Installation Steps

### Step 1: Navigate to Website Directory
```bash
cd website
```

### Step 2: Install Dependencies
```bash
npm install
```

**Expected Output:**
```
added 103 packages, and audited 104 packages in 12s
found 0 vulnerabilities
```

### Step 3: Start the Server

#### Option A: Using npm start
```bash
npm start
```

#### Option B: Using the Launcher Script (Windows)
```bash
start_website.bat
```

#### Option C: Using the Launcher Script (Linux/macOS)
```bash
chmod +x start_website.sh
./start_website.sh
```

## 🎯 Expected Results

### Server Startup Output
```
🚀 DriveBackup Pro Website is running!
📱 Local: http://localhost:3000
🌐 Network: http://0.0.0.0:3000
📋 Press Ctrl+C to stop the server

📁 Available pages:
   • Home: http://localhost:3000/
   • Features: http://localhost:3000/features
   • Download: http://localhost:3000/download
   • Documentation: http://localhost:3000/docs
   • Support: http://localhost:3000/support
   • About: http://localhost:3000/about
   • Privacy Policy: http://localhost:3000/privacy-policy
   • Terms of Service: http://localhost:3000/terms-of-service
```

### Browser Access
Open your web browser and navigate to:
```
http://localhost:3000
```

You should see the DriveBackup Pro homepage with:
- Modern, responsive design
- Navigation menu
- Hero section with call-to-action buttons
- Feature highlights
- Footer with links

## 🧪 Testing the Setup

### Test Server Connection
```bash
node test_server.js
```

**Expected Output:**
```
🔍 Testing DriveBackup Pro Website Server...
⏳ Waiting for server response...
✅ Server is running! Status: 200
📱 Website available at: http://localhost:3000
🎉 Server test successful!
```

### Test All Pages
Visit each page to ensure they load correctly:
- http://localhost:3000/ (Home)
- http://localhost:3000/features
- http://localhost:3000/download
- http://localhost:3000/docs
- http://localhost:3000/support
- http://localhost:3000/about
- http://localhost:3000/privacy-policy
- http://localhost:3000/terms-of-service

**Note:** All URLs are clean (no .html extensions) for a professional appearance!

## 🔧 Troubleshooting

### Issue 1: "Node.js is not installed"
**Solution:**
1. Download Node.js from https://nodejs.org/
2. Install with default settings
3. Restart your terminal/command prompt
4. Verify installation: `node --version`

### Issue 2: "Port 3000 is already in use"
**Solution:**
```bash
# Use a different port
PORT=8080 npm start

# Or find and kill the process using port 3000
# Windows:
netstat -ano | findstr :3000
# Then kill the process ID

# Linux/macOS:
lsof -i :3000
# Then kill the process ID
```

### Issue 3: "npm install failed"
**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Try installing again
npm install

# Or use a different registry
npm install --registry https://registry.npmjs.org/
```

### Issue 4: "Cannot find module 'express'"
**Solution:**
```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

## 🚀 Development Mode

For development with auto-reload:

1. **Install nodemon globally:**
   ```bash
   npm install -g nodemon
   ```

2. **Start in development mode:**
   ```bash
   npm run dev
   ```

3. **Make changes to files and see them automatically reload**

## 🌐 Network Access

The server is accessible from other devices on your network:
```
http://[YOUR_IP_ADDRESS]:3000
```

To find your IP address:
- **Windows:** `ipconfig`
- **Linux/macOS:** `ifconfig` or `ip addr`

## 📱 Mobile Testing

Test the responsive design on mobile devices:
1. Start the server
2. Find your computer's IP address
3. Connect your mobile device to the same network
4. Visit `http://[YOUR_IP]:3000` on your mobile browser

## 🛑 Stopping the Server

To stop the server:
- Press `Ctrl+C` in the terminal
- Or close the terminal window

## 📚 Additional Resources

- [Node.js Documentation](https://nodejs.org/docs/)
- [Express.js Documentation](https://expressjs.com/)
- [README_NODEJS.md](README_NODEJS.md) - Detailed Node.js documentation
- [README_WEBSITE.md](README_WEBSITE.md) - General website documentation

## 🆘 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Review the error messages carefully
3. Verify Node.js version compatibility
4. Check the browser console for errors
5. Review the server logs for error messages

## ✅ Success Checklist

- [ ] Node.js installed and working
- [ ] Dependencies installed successfully
- [ ] Server starts without errors
- [ ] Homepage loads in browser
- [ ] All navigation links work
- [ ] Responsive design works on mobile
- [ ] No console errors in browser
- [ ] Server test passes

🎉 **Congratulations!** Your DriveBackup Pro website is now running with Node.js!
