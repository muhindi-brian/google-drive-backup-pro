# DriveBackup Pro Website - Node.js Setup

This document provides instructions for running the DriveBackup Pro website using Node.js.

## Prerequisites

### 1. Install Node.js
Download and install Node.js from [https://nodejs.org/](https://nodejs.org/)

**Recommended version:** Node.js 14.0.0 or higher

**To verify installation:**
```bash
node --version
npm --version
```

## Quick Start

### Option 1: Using the Launcher Scripts (Recommended)

#### Windows
```bash
cd website
start_website.bat
```

#### Linux/macOS
```bash
cd website
chmod +x start_website.sh
./start_website.sh
```

### Option 2: Manual Setup

1. **Navigate to the website directory:**
   ```bash
   cd website
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Start the server:**
   ```bash
   npm start
   ```

4. **Open your browser and visit:**
   ```
   http://localhost:3000
   ```

## Available Scripts

- `npm start` - Start the production server
- `npm run dev` - Start the development server with auto-reload (requires nodemon)
- `npm test` - Run tests (placeholder)

## Development Mode

For development with auto-reload:

1. **Install nodemon globally (optional):**
   ```bash
   npm install -g nodemon
   ```

2. **Start in development mode:**
   ```bash
   npm run dev
   ```

## Website Structure

The website includes the following pages with clean URLs (no .html extensions):

- **Home** - `/` - Main landing page
- **Features** - `/features` - Detailed feature overview
- **Download** - `/download` - Download options and installation guide
- **Documentation** - `/docs` - Comprehensive documentation
- **Support** - `/support` - Support options and contact form
- **About** - `/about` - Company information and mission
- **Privacy Policy** - `/privacy-policy` - Privacy policy and data handling
- **Terms of Service** - `/terms-of-service` - Terms and conditions

### Clean URL Features
- ✅ No `.html` extensions in URLs
- ✅ Automatic redirects from `.html` URLs to clean URLs
- ✅ SEO-friendly URLs
- ✅ Professional appearance

## Server Configuration

### Environment Variables

- `PORT` - Server port (default: 3000)

### Custom Port
```bash
PORT=8080 npm start
```

### Network Access
The server runs on `0.0.0.0:3000` by default, making it accessible from other devices on the network.

## File Structure

```
website/
├── package.json          # Node.js dependencies and scripts
├── server.js             # Express.js server
├── start_website.bat     # Windows launcher
├── start_website.sh      # Unix/Linux launcher
├── README_NODEJS.md      # This file
├── index.html            # Home page
├── features.html         # Features page
├── download.html         # Download page
├── docs.html            # Documentation page
├── support.html         # Support page
├── about.html           # About page
├── privacy-policy.html  # Privacy policy
├── terms-of-service.html # Terms of service
├── styles.css           # CSS styles
└── script.js            # JavaScript functionality
```

## Troubleshooting

### Common Issues

1. **"Node.js is not installed"**
   - Download and install Node.js from [https://nodejs.org/](https://nodejs.org/)
   - Restart your terminal/command prompt

2. **"Port 3000 is already in use"**
   - Change the port: `PORT=8080 npm start`
   - Or kill the process using port 3000

3. **"npm install failed"**
   - Check your internet connection
   - Try clearing npm cache: `npm cache clean --force`
   - Try using a different npm registry

4. **"Cannot find module 'express'"**
   - Run `npm install` to install dependencies
   - Check if `node_modules` folder exists

### Port Conflicts

If port 3000 is already in use, you can:

1. **Find what's using the port:**
   ```bash
   # Windows
   netstat -ano | findstr :3000
   
   # Linux/macOS
   lsof -i :3000
   ```

2. **Kill the process or use a different port:**
   ```bash
   PORT=8080 npm start
   ```

## Deployment

### Local Network Access
The server is accessible from other devices on your network at:
```
http://[YOUR_IP_ADDRESS]:3000
```

### Production Deployment
For production deployment, consider:

1. **Environment variables:**
   ```bash
   NODE_ENV=production PORT=80 npm start
   ```

2. **Process manager (PM2):**
   ```bash
   npm install -g pm2
   pm2 start server.js --name "drivebackup-website"
   ```

3. **Reverse proxy (nginx):**
   Configure nginx to proxy requests to the Node.js server

## Security Considerations

- The server serves static files only
- No sensitive data is processed on the server
- All Google API interactions happen client-side
- Consider using HTTPS in production

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify Node.js version compatibility
3. Check the browser console for errors
4. Review the server logs for error messages

## License

This website is part of the DriveBackup Pro project and follows the same licensing terms.
