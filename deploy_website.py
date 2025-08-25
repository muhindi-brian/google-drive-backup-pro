#!/usr/bin/env python3
"""
Website Deployment Script for Google Drive Backup Tool
=====================================================

This script helps deploy the website to various platforms.

Usage:
    python deploy_website.py [option]

Options:
    local     - Start local development server
    github    - Prepare for GitHub Pages deployment
    netlify   - Prepare for Netlify deployment
    vercel    - Prepare for Vercel deployment
    validate  - Validate HTML and CSS
    optimize  - Optimize files for production
"""

import os
import sys
import subprocess
import shutil
import json
from pathlib import Path

def check_files():
    """Check if required website files exist"""
    required_files = ['index.html', 'styles.css', 'script.js']
    missing_files = []
    
    for file in required_files:
        if not os.path.exists(file):
            missing_files.append(file)
    
    if missing_files:
        print(f"❌ Missing required files: {', '.join(missing_files)}")
        return False
    
    print("✅ All required website files found")
    return True

def start_local_server():
    """Start a local development server"""
    print("🌐 Starting local development server...")
    
    try:
        # Try Python 3 first
        subprocess.run([sys.executable, "-m", "http.server", "8000"], check=True)
    except subprocess.CalledProcessError:
        try:
            # Try Python 2
            subprocess.run([sys.executable, "-m", "SimpleHTTPServer", "8000"], check=True)
        except subprocess.CalledProcessError:
            print("❌ Failed to start local server")
            print("Please install a local server manually:")
            print("  - Python: python -m http.server 8000")
            print("  - Node.js: npx http-server")
            return False
    
    print("✅ Local server started at http://localhost:8000")
    print("Press Ctrl+C to stop the server")
    return True

def prepare_github_pages():
    """Prepare files for GitHub Pages deployment"""
    print("📦 Preparing for GitHub Pages deployment...")
    
    # Create .nojekyll file to bypass Jekyll processing
    with open('.nojekyll', 'w') as f:
        f.write('')
    
    # Create GitHub Pages configuration
    config = {
        "name": "Google Drive Backup Tool Website",
        "description": "Professional website for Google Drive Backup Tool",
        "homepage": "https://username.github.io/repo-name",
        "scripts": {
            "build": "echo 'No build step required'"
        }
    }
    
    with open('package.json', 'w') as f:
        json.dump(config, f, indent=2)
    
    print("✅ GitHub Pages files created:")
    print("  - .nojekyll (bypasses Jekyll processing)")
    print("  - package.json (basic configuration)")
    print("\n📋 Next steps:")
    print("1. Create a new GitHub repository")
    print("2. Push these files to the repository")
    print("3. Go to Settings > Pages")
    print("4. Select 'Deploy from a branch'")
    print("5. Choose 'main' branch and '/ (root)' folder")
    print("6. Your site will be available at: https://username.github.io/repo-name")
    
    return True

def prepare_netlify():
    """Prepare files for Netlify deployment"""
    print("📦 Preparing for Netlify deployment...")
    
    # Create Netlify configuration
    netlify_config = """
# Netlify configuration
[build]
  publish = "."
  command = "echo 'No build command required'"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[build.environment]
  NODE_VERSION = "16"
"""
    
    with open('netlify.toml', 'w') as f:
        f.write(netlify_config)
    
    # Create _redirects file for SPA routing
    with open('_redirects', 'w') as f:
        f.write("/* /index.html 200")
    
    print("✅ Netlify files created:")
    print("  - netlify.toml (deployment configuration)")
    print("  - _redirects (SPA routing)")
    print("\n📋 Next steps:")
    print("1. Go to https://netlify.com")
    print("2. Sign up/Login with GitHub")
    print("3. Click 'New site from Git'")
    print("4. Connect your repository")
    print("5. Deploy settings will be auto-detected")
    print("6. Click 'Deploy site'")
    
    return True

def prepare_vercel():
    """Prepare files for Vercel deployment"""
    print("📦 Preparing for Vercel deployment...")
    
    # Create Vercel configuration
    vercel_config = {
        "version": 2,
        "builds": [
            {
                "src": "*.html",
                "use": "@vercel/static"
            }
        ],
        "routes": [
            {
                "src": "/(.*)",
                "dest": "/index.html"
            }
        ]
    }
    
    with open('vercel.json', 'w') as f:
        json.dump(vercel_config, f, indent=2)
    
    print("✅ Vercel files created:")
    print("  - vercel.json (deployment configuration)")
    print("\n📋 Next steps:")
    print("1. Install Vercel CLI: npm i -g vercel")
    print("2. Run: vercel login")
    print("3. Run: vercel")
    print("4. Follow the prompts to deploy")
    
    return True

def validate_files():
    """Validate HTML and CSS files"""
    print("🔍 Validating website files...")
    
    # Check HTML structure
    try:
        with open('index.html', 'r', encoding='utf-8') as f:
            html_content = f.read()
        
        # Basic HTML validation
        if '<!DOCTYPE html>' not in html_content:
            print("⚠️  Warning: Missing DOCTYPE declaration")
        
        if '<html' not in html_content:
            print("❌ Error: Missing <html> tag")
            return False
        
        if '<head>' not in html_content:
            print("❌ Error: Missing <head> tag")
            return False
        
        if '<body>' not in html_content:
            print("❌ Error: Missing <body> tag")
            return False
        
        print("✅ HTML structure is valid")
        
    except Exception as e:
        print(f"❌ Error reading HTML file: {e}")
        return False
    
    # Check CSS file
    try:
        with open('styles.css', 'r', encoding='utf-8') as f:
            css_content = f.read()
        
        if len(css_content.strip()) == 0:
            print("❌ Error: CSS file is empty")
            return False
        
        print("✅ CSS file is valid")
        
    except Exception as e:
        print(f"❌ Error reading CSS file: {e}")
        return False
    
    # Check JavaScript file
    try:
        with open('script.js', 'r', encoding='utf-8') as f:
            js_content = f.read()
        
        if len(js_content.strip()) == 0:
            print("❌ Error: JavaScript file is empty")
            return False
        
        print("✅ JavaScript file is valid")
        
    except Exception as e:
        print(f"❌ Error reading JavaScript file: {e}")
        return False
    
    print("✅ All files validated successfully")
    return True

def optimize_files():
    """Optimize files for production"""
    print("⚡ Optimizing files for production...")
    
    # Create optimized directory
    if not os.path.exists('dist'):
        os.makedirs('dist')
    
    # Copy files to dist directory
    files_to_copy = ['index.html', 'styles.css', 'script.js']
    
    for file in files_to_copy:
        if os.path.exists(file):
            shutil.copy2(file, f'dist/{file}')
            print(f"✅ Copied {file} to dist/")
    
    # Create robots.txt
    robots_content = """User-agent: *
Allow: /

Sitemap: https://yourdomain.com/sitemap.xml
"""
    
    with open('dist/robots.txt', 'w') as f:
        f.write(robots_content)
    
    # Create sitemap.xml
    sitemap_content = """<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yourdomain.com/</loc>
    <lastmod>2024-12-01</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
"""
    
    with open('dist/sitemap.xml', 'w') as f:
        f.write(sitemap_content)
    
    print("✅ Production files created in dist/ directory:")
    print("  - index.html")
    print("  - styles.css")
    print("  - script.js")
    print("  - robots.txt")
    print("  - sitemap.xml")
    print("\n📋 Remember to:")
    print("1. Update URLs in robots.txt and sitemap.xml")
    print("2. Add your domain name")
    print("3. Update lastmod dates")
    
    return True

def show_help():
    """Show help information"""
    print("🌐 Google Drive Backup Tool - Website Deployment")
    print("=" * 50)
    print("\nUsage: python deploy_website.py [option]")
    print("\nOptions:")
    print("  local     - Start local development server")
    print("  github    - Prepare for GitHub Pages deployment")
    print("  netlify   - Prepare for Netlify deployment")
    print("  vercel    - Prepare for Vercel deployment")
    print("  validate  - Validate HTML and CSS files")
    print("  optimize  - Optimize files for production")
    print("  help      - Show this help message")
    print("\nExamples:")
    print("  python deploy_website.py local")
    print("  python deploy_website.py github")
    print("  python deploy_website.py validate")

def main():
    """Main function"""
    if len(sys.argv) < 2:
        show_help()
        return
    
    option = sys.argv[1].lower()
    
    # Check if required files exist
    if not check_files():
        return
    
    if option == 'local':
        start_local_server()
    elif option == 'github':
        prepare_github_pages()
    elif option == 'netlify':
        prepare_netlify()
    elif option == 'vercel':
        prepare_vercel()
    elif option == 'validate':
        validate_files()
    elif option == 'optimize':
        optimize_files()
    elif option == 'help':
        show_help()
    else:
        print(f"❌ Unknown option: {option}")
        show_help()

if __name__ == "__main__":
    main()
