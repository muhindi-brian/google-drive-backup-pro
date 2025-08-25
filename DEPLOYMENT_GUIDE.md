# DriveBackup Pro Website Deployment Guide

## 🚨 **Current Issue: CSS Not Loading on Live Server**

Your live website at [https://drive.mojokgroup.xyz/](https://drive.mojokgroup.xyz/) is missing the CSS styling because the server is not properly configured to serve static files.

## 🔧 **Solution: Deploy Node.js Application**

### **Option 1: Deploy Node.js App (Recommended)**

#### **Step 1: Upload Files to Server**
Upload these files to your server:
- `server.js`
- `package.json`
- `deploy-config.js`
- All HTML files (`index.html`, `features.html`, etc.)
- `styles.css`
- `script.js`
- `.env` (with your credentials)

#### **Step 2: Install Dependencies on Server**
```bash
npm install
```

#### **Step 3: Set Up Environment Variables**
```bash
# Create .env file on server
cp env.example .env
# Edit .env with your actual credentials
nano .env
```

#### **Step 4: Start the Application**
```bash
# For development
npm run dev

# For production (with PM2)
npm install -g pm2
pm2 start server.js --name "drivebackup-pro"
pm2 startup
pm2 save
```

#### **Step 5: Configure Reverse Proxy (Nginx/Apache)**

**Nginx Configuration:**
```nginx
server {
    listen 80;
    server_name drive.mojokgroup.xyz;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

**Apache Configuration:**
```apache
<VirtualHost *:80>
    ServerName drive.mojokgroup.xyz
    
    ProxyPreserveHost On
    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/
    
    ErrorLog ${APACHE_LOG_DIR}/drivebackup_error.log
    CustomLog ${APACHE_LOG_DIR}/drivebackup_access.log combined
</VirtualHost>
```

### **Option 2: Static File Server (Quick Fix)**

If you can't deploy Node.js, configure your current web server to serve static files properly.

#### **For Apache:**
Create `.htaccess` file in your website root:
```apache
# Enable static file serving
<IfModule mod_mime.c>
    AddType text/css .css
    AddType application/javascript .js
    AddType text/html .html
</IfModule>

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE text/html
</IfModule>

# Set cache headers
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType text/html "access plus 1 hour"
</IfModule>

# Enable CORS for API
<IfModule mod_headers.c>
    Header always set Access-Control-Allow-Origin "*"
    Header always set Access-Control-Allow-Methods "GET, POST, OPTIONS"
    Header always set Access-Control-Allow-Headers "Content-Type"
</IfModule>
```

#### **For Nginx:**
Update your nginx configuration:
```nginx
server {
    listen 80;
    server_name drive.mojokgroup.xyz;
    root /path/to/your/website;
    index index.html;

    # Serve static files
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
        try_files $uri =404;
    }

    # Handle HTML files
    location ~* \.html$ {
        try_files $uri =404;
    }

    # API endpoint (if you have a separate API server)
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Default location
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

## 🚀 **Deployment Scripts**

### **Windows Deployment Script:**
```batch
@echo off
echo Deploying DriveBackup Pro Website...
echo.

echo 1. Installing dependencies...
npm install

echo.
echo 2. Setting up environment variables...
if not exist .env (
    copy env.example .env
    echo Please edit .env file with your credentials
)

echo.
echo 3. Starting the server...
npm start
```

### **Linux/Mac Deployment Script:**
```bash
#!/bin/bash
echo "Deploying DriveBackup Pro Website..."

echo "1. Installing dependencies..."
npm install

echo "2. Setting up environment variables..."
if [ ! -f .env ]; then
    cp env.example .env
    echo "Please edit .env file with your credentials"
fi

echo "3. Starting the server..."
npm start
```

## 🔍 **Troubleshooting**

### **CSS Still Not Loading:**
1. **Check file permissions:** Ensure CSS files are readable
2. **Check file paths:** Verify `styles.css` is in the correct location
3. **Check MIME types:** Ensure server serves CSS with correct content-type
4. **Check browser console:** Look for 404 errors on CSS files

### **Common Issues:**
1. **404 on CSS files:** Server not configured to serve static files
2. **CORS errors:** Missing CORS headers for API calls
3. **Permission denied:** File permissions not set correctly
4. **Port conflicts:** Another service using port 3000

### **Debugging Steps:**
1. **Check server logs:** Look for error messages
2. **Test locally:** Run `npm start` and visit `http://localhost:3000`
3. **Check file structure:** Ensure all files are in the correct locations
4. **Verify environment:** Check if `.env` file exists and has correct values

## 📋 **File Structure for Deployment**

```
/var/www/drivebackup-pro/
├── server.js              # Main server file
├── package.json           # Dependencies
├── deploy-config.js       # Deployment configuration
├── .env                   # Environment variables (create from env.example)
├── env.example            # Example environment file
├── index.html             # Homepage
├── features.html          # Features page
├── download.html          # Download page
├── docs.html              # Documentation page
├── support.html           # Support page
├── about.html             # About page
├── styles.css             # Main stylesheet
├── script.js              # JavaScript file
├── privacy-policy.html    # Privacy policy
├── terms-of-service.html  # Terms of service
└── node_modules/          # Dependencies (created by npm install)
```

## 🔐 **Security Considerations**

1. **Environment Variables:** Never commit `.env` file to version control
2. **HTTPS:** Use SSL certificates for production
3. **Firewall:** Configure firewall to allow only necessary ports
4. **Updates:** Keep dependencies updated for security patches
5. **Monitoring:** Set up logging and monitoring for the application

## 📞 **Support**

If you need help with deployment:
1. Check the troubleshooting section above
2. Review server logs for error messages
3. Test the application locally first
4. Ensure all dependencies are installed
5. Verify environment variables are set correctly

## 🎯 **Quick Fix for Immediate Issue**

If you need a quick fix right now:

1. **Upload the CSS file manually** to your server
2. **Check the file path** in your HTML files
3. **Verify the server can serve CSS files** with correct MIME type
4. **Test by accessing the CSS file directly** in your browser

The CSS file should be accessible at: `https://drive.mojokgroup.xyz/styles.css`
