#!/bin/bash

# DriveBackup Pro - Ubuntu Server Deployment Script
# This script will set up your Node.js application on Ubuntu server

echo "========================================"
echo "  DriveBackup Pro - Ubuntu Deployment"
echo "========================================"
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root. Please run as a regular user with sudo privileges."
   exit 1
fi

print_status "Starting Ubuntu server deployment..."

# Step 1: Update system packages
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System packages updated"

# Step 2: Install Node.js and npm
print_status "Installing Node.js and npm..."
if ! command -v node &> /dev/null; then
    # Install Node.js 18.x (LTS)
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    print_success "Node.js installed"
else
    print_warning "Node.js already installed"
fi

# Step 3: Install PM2 globally
print_status "Installing PM2 process manager..."
sudo npm install -g pm2
print_success "PM2 installed"

# Step 4: Install Nginx
print_status "Installing Nginx..."
sudo apt install -y nginx
print_success "Nginx installed"

# Step 5: Install dependencies
print_status "Installing project dependencies..."
if [ -f "package.json" ]; then
    npm install
    print_success "Dependencies installed"
else
    print_error "package.json not found! Please run this script from your project directory."
    exit 1
fi

# Step 6: Set up environment file
print_status "Setting up environment configuration..."
if [ ! -f ".env" ]; then
    if [ -f "env.example" ]; then
        cp env.example .env
        print_warning "Created .env file from template. Please edit it with your credentials:"
        echo "   GMAIL_USER=devverge.254@gmail.com"
        echo "   GMAIL_PASS=kgie ntnq dudx ywvg"
        echo "   SUPPORT_EMAIL=drive@mojokgroup.xyz"
        echo "   COMPANY_NAME=Mojok Dev ke. Solutions"
        echo "   PORT=3000"
        echo "   NODE_ENV=production"
        echo
        read -p "Press Enter to edit .env file with nano (or Ctrl+C to edit manually later)..."
        nano .env
    else
        print_error "env.example not found! Creating basic .env file..."
        cat > .env << EOF
GMAIL_USER=devverge.254@gmail.com
GMAIL_PASS=kgie ntnq dudx ywvg
SUPPORT_EMAIL=drive@mojokgroup.xyz
COMPANY_NAME=Mojok Dev ke. Solutions
PORT=3000
NODE_ENV=production
EOF
        print_warning "Created basic .env file. Please edit it with your actual credentials."
    fi
else
    print_success ".env file already exists"
fi

# Step 7: Create Nginx configuration
print_status "Creating Nginx configuration..."
sudo tee /etc/nginx/sites-available/drive.mojokgroup.xyz > /dev/null << EOF
server {
    listen 80;
    server_name drive.mojokgroup.xyz www.drive.mojokgroup.xyz;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    
    # Proxy to Node.js application
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
        proxy_read_timeout 86400;
    }
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private must-revalidate auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/javascript;
}
EOF

# Step 8: Enable Nginx site
print_status "Enabling Nginx site..."
sudo ln -sf /etc/nginx/sites-available/drive.mojokgroup.xyz /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

# Test Nginx configuration
if sudo nginx -t; then
    sudo systemctl reload nginx
    print_success "Nginx configuration applied"
else
    print_error "Nginx configuration test failed!"
    exit 1
fi

# Step 9: Start application with PM2
print_status "Starting application with PM2..."
pm2 start server.js --name "drivebackup-pro"
pm2 startup
pm2 save
print_success "Application started with PM2"

# Step 10: Set up firewall (if UFW is enabled)
if command -v ufw &> /dev/null && sudo ufw status | grep -q "Status: active"; then
    print_status "Configuring firewall..."
    sudo ufw allow 'Nginx Full'
    sudo ufw allow ssh
    print_success "Firewall configured"
fi

# Step 11: Set up SSL with Let's Encrypt (optional)
print_status "Setting up SSL certificate..."
if command -v certbot &> /dev/null; then
    print_warning "Certbot is installed. To set up SSL, run:"
    echo "   sudo certbot --nginx -d drive.mojokgroup.xyz"
else
    print_warning "To install SSL certificate, first install certbot:"
    echo "   sudo apt install certbot python3-certbot-nginx"
    echo "   sudo certbot --nginx -d drive.mojokgroup.xyz"
fi

# Step 12: Final status check
print_status "Performing final status check..."
sleep 3

if pm2 list | grep -q "drivebackup-pro.*online"; then
    print_success "✅ Application is running"
else
    print_error "❌ Application failed to start"
    pm2 logs drivebackup-pro --lines 10
fi

if sudo systemctl is-active --quiet nginx; then
    print_success "✅ Nginx is running"
else
    print_error "❌ Nginx is not running"
fi

echo
echo "========================================"
echo "  🎉 Deployment Complete!"
echo "========================================"
echo
print_success "Your DriveBackup Pro website is now deployed!"
echo
echo "🌐 Access your website:"
echo "   Local: http://localhost:3000"
echo "   Live: http://drive.mojokgroup.xyz"
echo
echo "📋 Useful commands:"
echo "   Check app status: pm2 status"
echo "   View app logs: pm2 logs drivebackup-pro"
echo "   Restart app: pm2 restart drivebackup-pro"
echo "   Stop app: pm2 stop drivebackup-pro"
echo
echo "🔧 Nginx commands:"
echo "   Test config: sudo nginx -t"
echo "   Reload: sudo systemctl reload nginx"
echo "   Status: sudo systemctl status nginx"
echo
echo "🔒 SSL Setup (recommended):"
echo "   sudo apt install certbot python3-certbot-nginx"
echo "   sudo certbot --nginx -d drive.mojokgroup.xyz"
echo
print_success "Your navigation bar and dropdown should now work perfectly! 🚀"
