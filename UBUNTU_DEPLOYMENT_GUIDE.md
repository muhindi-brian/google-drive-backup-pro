# Ubuntu Server Deployment Guide - DriveBackup Pro

## 🚨 **Current Issue: Navigation Broken on Live Server**

Your navigation bar is messed up and dropdown isn't working on `https://drive.mojokgroup.xyz/` because the Ubuntu server isn't properly running the Node.js application.

## 🎯 **Solution Overview**

We need to deploy your Node.js application on Ubuntu with:
- ✅ **Node.js** running on port 3000
- ✅ **Nginx** as reverse proxy
- ✅ **PM2** for process management
- ✅ **Proper MIME types** for CSS/JS files
- ✅ **SSL certificate** (optional but recommended)

## 📋 **Prerequisites**

- Ubuntu server (18.04, 20.04, or 22.04)
- SSH access to your server
- Domain pointing to your server (`drive.mojokgroup.xyz`)
- Sudo privileges

## 🚀 **Step-by-Step Deployment**

### **Step 1: Upload Files to Server**

First, upload all your website files to your Ubuntu server:

```bash
# On your local machine, upload files to server
scp -r * user@your-server-ip:/home/user/drivebackup-pro/
```

**Required Files:**
```
📁 Server Files:
├── server.js              # Main server file
├── package.json           # Dependencies
├── deploy-config.js       # Deployment configuration
├── .env                   # Environment variables
├── env.example            # Example environment file
├── deploy-ubuntu.sh       # Ubuntu deployment script
└── troubleshoot-ubuntu.sh # Troubleshooting script

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

### **Step 2: SSH into Your Server**

```bash
ssh user@your-server-ip
cd /home/user/drivebackup-pro
```

### **Step 3: Run the Ubuntu Deployment Script**

```bash
# Make script executable
chmod +x deploy-ubuntu.sh

# Run the deployment script
./deploy-ubuntu.sh
```

**What the script does:**
- ✅ Installs Node.js 18.x (LTS)
- ✅ Installs PM2 process manager
- ✅ Installs Nginx web server
- ✅ Installs project dependencies
- ✅ Sets up environment variables
- ✅ Configures Nginx reverse proxy
- ✅ Starts application with PM2
- ✅ Configures firewall rules
- ✅ Sets up SSL certificate (optional)

### **Step 4: Configure Environment Variables**

The script will prompt you to edit the `.env` file. Add your credentials:

```env
GMAIL_USER=devverge.254@gmail.com
GMAIL_PASS=kgie ntnq dudx ywvg
SUPPORT_EMAIL=drive@mojokgroup.xyz
COMPANY_NAME=Mojok Dev ke. Solutions
PORT=3000
NODE_ENV=production
```

### **Step 5: Verify Deployment**

After the script completes, verify everything is working:

```bash
# Check application status
pm2 status

# Check Nginx status
sudo systemctl status nginx

# Test local access
curl http://localhost:3000

# Check if CSS is served correctly
curl -I http://localhost:3000/styles.css
```

## 🔧 **Manual Deployment (Alternative)**

If you prefer manual deployment or the script fails:

### **Install Node.js**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

### **Install PM2**
```bash
sudo npm install -g pm2
```

### **Install Nginx**
```bash
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

### **Install Dependencies**
```bash
npm install
```

### **Set Up Environment**
```bash
cp env.example .env
nano .env
# Add your credentials as shown above
```

### **Create Nginx Configuration**
```bash
sudo nano /etc/nginx/sites-available/drive.mojokgroup.xyz
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name drive.mojokgroup.xyz www.drive.mojokgroup.xyz;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    
    # Proxy to Node.js application
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
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/javascript;
}
```

### **Enable Nginx Site**
```bash
sudo ln -sf /etc/nginx/sites-available/drive.mojokgroup.xyz /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

### **Start Application**
```bash
pm2 start server.js --name "drivebackup-pro"
pm2 startup
pm2 save
```

### **Configure Firewall**
```bash
sudo ufw allow 'Nginx Full'
sudo ufw allow ssh
```

## 🔍 **Troubleshooting**

If you encounter issues, run the troubleshooting script:

```bash
chmod +x troubleshoot-ubuntu.sh
./troubleshoot-ubuntu.sh
```

### **Common Issues & Solutions**

#### **1. Navigation Still Broken**
```bash
# Check if Node.js app is running
pm2 status

# Check if CSS is served correctly
curl -I http://localhost:3000/styles.css
# Should return: Content-Type: text/css

# Check Nginx logs
sudo tail -f /var/log/nginx/error.log
```

#### **2. Application Not Starting**
```bash
# Check PM2 logs
pm2 logs drivebackup-pro

# Check if port 3000 is in use
sudo netstat -tlnp | grep :3000

# Restart application
pm2 restart drivebackup-pro
```

#### **3. Nginx Configuration Errors**
```bash
# Test Nginx configuration
sudo nginx -t

# Check Nginx status
sudo systemctl status nginx

# Reload Nginx
sudo systemctl reload nginx
```

#### **4. Permission Issues**
```bash
# Fix file permissions
sudo chown -R $USER:$USER /home/user/drivebackup-pro
chmod +x *.sh
```

## 🔒 **SSL Certificate Setup (Recommended)**

For HTTPS (recommended for production):

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d drive.mojokgroup.xyz

# Auto-renewal (already configured by certbot)
sudo crontab -l
```

## 📊 **Monitoring & Maintenance**

### **Useful Commands**
```bash
# Check application status
pm2 status

# View application logs
pm2 logs drivebackup-pro

# Monitor system resources
pm2 monit

# Restart application
pm2 restart drivebackup-pro

# Update application
pm2 reload drivebackup-pro

# Check Nginx status
sudo systemctl status nginx

# View Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### **Automatic Updates**
```bash
# Create update script
nano update-app.sh
```

Add this content:
```bash
#!/bin/bash
cd /home/user/drivebackup-pro
git pull origin main
npm install
pm2 reload drivebackup-pro
```

Make it executable:
```bash
chmod +x update-app.sh
```

## 🎯 **Expected Results**

After successful deployment:

- ✅ **Navigation bar perfectly aligned and centered**
- ✅ **Support dropdown working smoothly**
- ✅ **All CSS styles applied correctly**
- ✅ **JavaScript functionality working**
- ✅ **Contact form sending emails**
- ✅ **Professional appearance on all devices**
- ✅ **Fast loading times**
- ✅ **SSL certificate (if configured)**

## 🚀 **Quick Start Commands**

For experienced users, here's the quick deployment:

```bash
# 1. Upload files to server
# 2. SSH into server
ssh user@your-server-ip
cd /home/user/drivebackup-pro

# 3. Run deployment script
chmod +x deploy-ubuntu.sh
./deploy-ubuntu.sh

# 4. Configure SSL (optional)
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d drive.mojokgroup.xyz

# 5. Test website
curl http://drive.mojokgroup.xyz
```

## 📞 **Support**

If you encounter issues:

1. **Run troubleshooting script**: `./troubleshoot-ubuntu.sh`
2. **Check logs**: `pm2 logs drivebackup-pro`
3. **Verify configuration**: `sudo nginx -t`
4. **Test locally**: `curl http://localhost:3000`

Your navigation bar and dropdown will work perfectly once the Node.js application is properly deployed! 🚀✨
