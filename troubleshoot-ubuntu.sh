#!/bin/bash

# DriveBackup Pro - Ubuntu Troubleshooting Script
# This script will diagnose and fix common server issues

echo "========================================"
echo "  DriveBackup Pro - Ubuntu Troubleshooting"
echo "========================================"
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to check if a service is running
check_service() {
    local service_name=$1
    local display_name=$2
    
    if sudo systemctl is-active --quiet $service_name; then
        print_success "✅ $display_name is running"
        return 0
    else
        print_error "❌ $display_name is not running"
        return 1
    fi
}

# Function to check if a port is listening
check_port() {
    local port=$1
    local service_name=$2
    
    if sudo netstat -tlnp | grep -q ":$port "; then
        print_success "✅ Port $port is listening ($service_name)"
        return 0
    else
        print_error "❌ Port $port is not listening ($service_name)"
        return 1
    fi
}

echo "🔍 Starting comprehensive system check..."
echo

# Check 1: Node.js installation
print_status "Checking Node.js installation..."
if command -v node &> /dev/null; then
    node_version=$(node --version)
    print_success "Node.js is installed: $node_version"
else
    print_error "Node.js is not installed!"
    echo "   Run: curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs"
fi

# Check 2: PM2 installation
print_status "Checking PM2 installation..."
if command -v pm2 &> /dev/null; then
    print_success "PM2 is installed"
else
    print_error "PM2 is not installed!"
    echo "   Run: sudo npm install -g pm2"
fi

# Check 3: Application files
print_status "Checking application files..."
if [ -f "server.js" ]; then
    print_success "server.js found"
else
    print_error "server.js not found!"
fi

if [ -f "package.json" ]; then
    print_success "package.json found"
else
    print_error "package.json not found!"
fi

if [ -f "styles.css" ]; then
    print_success "styles.css found"
else
    print_error "styles.css not found!"
fi

if [ -f "script.js" ]; then
    print_success "script.js found"
else
    print_error "script.js not found!"
fi

# Check 4: Environment file
print_status "Checking environment configuration..."
if [ -f ".env" ]; then
    print_success ".env file exists"
    if grep -q "GMAIL_USER" .env; then
        print_success "Gmail credentials configured"
    else
        print_warning "Gmail credentials not found in .env"
    fi
else
    print_error ".env file not found!"
    echo "   Run: cp env.example .env && nano .env"
fi

# Check 5: Dependencies
print_status "Checking dependencies..."
if [ -d "node_modules" ]; then
    print_success "node_modules directory exists"
else
    print_error "Dependencies not installed!"
    echo "   Run: npm install"
fi

# Check 6: PM2 application status
print_status "Checking PM2 application status..."
if pm2 list | grep -q "drivebackup-pro"; then
    if pm2 list | grep -q "drivebackup-pro.*online"; then
        print_success "Application is running in PM2"
    else
        print_error "Application is not running in PM2"
        echo "   Run: pm2 start server.js --name drivebackup-pro"
    fi
else
    print_error "Application not found in PM2"
    echo "   Run: pm2 start server.js --name drivebackup-pro"
fi

# Check 7: Nginx service
print_status "Checking Nginx service..."
check_service nginx "Nginx"

# Check 8: Nginx configuration
print_status "Checking Nginx configuration..."
if sudo nginx -t 2>/dev/null; then
    print_success "Nginx configuration is valid"
else
    print_error "Nginx configuration has errors!"
    echo "   Run: sudo nginx -t"
fi

# Check 9: Port 3000 (Node.js app)
print_status "Checking if Node.js app is listening..."
check_port 3000 "Node.js Application"

# Check 10: Port 80 (Nginx)
print_status "Checking if Nginx is listening..."
check_port 80 "Nginx"

# Check 11: Firewall status
print_status "Checking firewall status..."
if command -v ufw &> /dev/null; then
    ufw_status=$(sudo ufw status | head -1)
    print_status "Firewall status: $ufw_status"
    
    if sudo ufw status | grep -q "Nginx Full"; then
        print_success "Nginx is allowed through firewall"
    else
        print_warning "Nginx might be blocked by firewall"
        echo "   Run: sudo ufw allow 'Nginx Full'"
    fi
else
    print_warning "UFW firewall not installed"
fi

# Check 12: Disk space
print_status "Checking disk space..."
disk_usage=$(df -h . | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$disk_usage" -lt 90 ]; then
    print_success "Disk space is adequate ($disk_usage% used)"
else
    print_warning "Disk space is low ($disk_usage% used)"
fi

# Check 13: Memory usage
print_status "Checking memory usage..."
memory_usage=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
print_status "Memory usage: $memory_usage%"

# Check 14: Test local access
print_status "Testing local application access..."
if curl -s http://localhost:3000 > /dev/null; then
    print_success "Application responds on localhost:3000"
else
    print_error "Application does not respond on localhost:3000"
fi

# Check 15: Test CSS loading
print_status "Testing CSS file access..."
if curl -s -I http://localhost:3000/styles.css | grep -q "text/css"; then
    print_success "CSS file is served with correct MIME type"
else
    print_error "CSS file is not served correctly"
fi

echo
echo "========================================"
echo "  🔧 Quick Fix Commands"
echo "========================================"
echo

echo "If you found issues, run these commands:"
echo
echo "1. Install dependencies:"
echo "   npm install"
echo
echo "2. Set up environment:"
echo "   cp env.example .env"
echo "   nano .env"
echo
echo "3. Start application:"
echo "   pm2 start server.js --name drivebackup-pro"
echo "   pm2 startup"
echo "   pm2 save"
echo
echo "4. Configure Nginx:"
echo "   sudo nginx -t"
echo "   sudo systemctl reload nginx"
echo
echo "5. Check logs:"
echo "   pm2 logs drivebackup-pro"
echo "   sudo tail -f /var/log/nginx/error.log"
echo
echo "6. Restart everything:"
echo "   pm2 restart drivebackup-pro"
echo "   sudo systemctl restart nginx"
echo

# Interactive fix options
echo "Would you like to attempt automatic fixes? (y/n)"
read -p "> " choice

if [[ $choice =~ ^[Yy]$ ]]; then
    echo
    print_status "Attempting automatic fixes..."
    
    # Fix 1: Install dependencies if missing
    if [ ! -d "node_modules" ]; then
        print_status "Installing dependencies..."
        npm install
    fi
    
    # Fix 2: Create .env if missing
    if [ ! -f ".env" ]; then
        print_status "Creating .env file..."
        if [ -f "env.example" ]; then
            cp env.example .env
        else
            cat > .env << EOF
GMAIL_USER=devverge.254@gmail.com
GMAIL_PASS=kgie ntnq dudx ywvg
SUPPORT_EMAIL=drive@mojokgroup.xyz
COMPANY_NAME=Mojok Dev ke. Solutions
PORT=3000
NODE_ENV=production
EOF
        fi
        print_warning "Created .env file. Please edit it with your actual credentials."
    fi
    
    # Fix 3: Start application if not running
    if ! pm2 list | grep -q "drivebackup-pro.*online"; then
        print_status "Starting application..."
        pm2 start server.js --name drivebackup-pro
        pm2 startup
        pm2 save
    fi
    
    # Fix 4: Reload Nginx
    print_status "Reloading Nginx..."
    sudo systemctl reload nginx
    
    echo
    print_success "Automatic fixes completed!"
    echo "Please check the status above and test your website."
fi

echo
echo "🌐 Test your website:"
echo "   http://drive.mojokgroup.xyz"
echo
print_success "Troubleshooting complete! 🚀"
