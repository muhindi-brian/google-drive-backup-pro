# Server Fix Guide - DriveBackup Pro

## 🚨 **Current Issue: Navigation Broken on Live Server**

Your navigation bar is messed up and dropdown isn't working on the live server because the server isn't properly serving CSS and JavaScript files.

## 🔧 **Root Cause**

The live server at `https://drive.mojokgroup.xyz/` is likely:
1. **Not running the Node.js application**
2. **Serving static files incorrectly** (wrong MIME types)
3. **Missing proper server configuration**

## ✅ **Solution: Deploy Node.js Application**

### **Step 1: Upload Files to Server**

Upload these files to your server root directory:
```
📁 Server Files:
├── server.js              # Main server file
├── package.json           # Dependencies
├── deploy-config.js       # Deployment configuration
├── .env                   # Environment variables
├── env.example            # Example environment file

📁 Website Files:
├── index.html             # Homepage
├── features.html          # Features page
├── download.html          # Download page
├── docs.html              # Documentation page
├── support.html           # Support page
├── about.html             # About page
├── privacy-policy.html    # Privacy policy
├── terms-of-service.html  # Terms of service
├── styles.css             # Main stylesheet
├── script.js              # JavaScript file
└── google-verification.html # Google verification page
```

### **Step 2: Install Dependencies on Server**

SSH into your server and run:
```bash
cd /path/to/your/website
npm install
```

### **Step 3: Set Up Environment Variables**

```bash
# Copy environment template
cp env.example .env

# Edit with your credentials
nano .env
```

Add your credentials:
```env
GMAIL_USER=devverge.254@gmail.com
GMAIL_PASS=kgie ntnq dudx ywvg
SUPPORT_EMAIL=drive@mojokgroup.xyz
COMPANY_NAME=Mojok Dev ke. Solutions
PORT=3000
NODE_ENV=production
```

### **Step 4: Start the Application**

#### **Option A: Direct Start (Testing)**
```bash
node server.js
```

#### **Option B: PM2 (Production)**
```bash
# Install PM2 globally
npm install -g pm2

# Start the application
pm2 start server.js --name "drivebackup-pro"

# Save PM2 configuration
pm2 startup
pm2 save
```

### **Step 5: Configure Reverse Proxy**

#### **Nginx Configuration**
Create/edit `/etc/nginx/sites-available/drive.mojokgroup.xyz`:

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

Enable the site:
```bash
ln -s /etc/nginx/sites-available/drive.mojokgroup.xyz /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

#### **Apache Configuration**
Create/edit `/etc/apache2/sites-available/drive.mojokgroup.xyz.conf`:

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

Enable the site:
```bash
a2ensite drive.mojokgroup.xyz
a2enmod proxy
a2enmod proxy_http
systemctl reload apache2
```

## 🚀 **Quick Fix Script**

Run this on your server:

```bash
#!/bin/bash
echo "Fixing DriveBackup Pro Server..."

# Install dependencies
npm install

# Set up environment
if [ ! -f .env ]; then
    cp env.example .env
    echo "Please edit .env file with your credentials"
fi

# Start with PM2
npm install -g pm2
pm2 start server.js --name "drivebackup-pro"
pm2 startup
pm2 save

echo "Server should now be running properly!"
```

## 🔍 **Troubleshooting**

### **Navigation Still Broken?**
1. **Check if Node.js is running:**
   ```bash
   pm2 status
   # or
   ps aux | grep node
   ```

2. **Check server logs:**
   ```bash
   pm2 logs drivebackup-pro
   # or
   tail -f /var/log/nginx/error.log
   ```

3. **Test CSS loading:**
   ```bash
   curl -I https://drive.mojokgroup.xyz/styles.css
   # Should return: Content-Type: text/css
   ```

4. **Check file permissions:**
   ```bash
   ls -la styles.css script.js
   # Should be readable by web server
   ```

### **Common Issues:**

1. **CSS not loading:**
   - Server not running Node.js app
   - Wrong MIME types
   - File permissions issue

2. **Dropdown not working:**
   - JavaScript not loading
   - CSS not applied
   - Server serving static files incorrectly

3. **Contact form not working:**
   - Node.js app not running
   - Environment variables not set
   - Email credentials incorrect

## 📋 **Verification Checklist**

- [ ] Node.js application running on port 3000
- [ ] All files uploaded to server
- [ ] Dependencies installed (`npm install`)
- [ ] Environment variables set (`.env` file)
- [ ] Reverse proxy configured (Nginx/Apache)
- [ ] PM2 managing the process
- [ ] CSS files loading with correct MIME type
- [ ] JavaScript files loading properly
- [ ] Navigation dropdown working
- [ ] Contact form functional

## 🎯 **Expected Result**

After proper deployment:
- ✅ Navigation bar perfectly aligned and centered
- ✅ Support dropdown working smoothly
- ✅ All CSS styles applied correctly
- ✅ JavaScript functionality working
- ✅ Contact form sending emails
- ✅ Professional appearance on all devices

## 📞 **Need Help?**

If you're still having issues:
1. Check server logs for error messages
2. Verify all files are uploaded correctly
3. Ensure Node.js is running on the server
4. Test the application locally first
5. Contact your hosting provider for Node.js support

---

**Remember:** The key is running the Node.js application on your server, not just serving static files. This ensures proper MIME types, security headers, and dynamic functionality.
