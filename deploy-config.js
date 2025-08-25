// DriveBackup Pro Website Deployment Configuration
// This file helps configure the server for proper static file serving

const express = require('express');
const path = require('path');

// Enhanced static file serving configuration
function configureStaticFiles(app) {
    // Serve static files with proper MIME types
    app.use(express.static('.', {
        setHeaders: (res, path, stat) => {
            // Set proper MIME types for CSS and JS files
            if (path.endsWith('.css')) {
                res.set('Content-Type', 'text/css');
            } else if (path.endsWith('.js')) {
                res.set('Content-Type', 'application/javascript');
            } else if (path.endsWith('.html')) {
                res.set('Content-Type', 'text/html');
            }
        }
    }));
}

// Security headers for production
function configureSecurityHeaders(app) {
    app.use((req, res, next) => {
        // Security headers
        res.setHeader('X-Content-Type-Options', 'nosniff');
        res.setHeader('X-Frame-Options', 'DENY');
        res.setHeader('X-XSS-Protection', '1; mode=block');
        res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
        
        // CORS headers for API endpoints
        if (req.path.startsWith('/api/')) {
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
            res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
        }
        
        next();
    });
}

// Error handling middleware
function configureErrorHandling(app) {
    // 404 handler
    app.use((req, res, next) => {
        if (req.accepts('html')) {
            res.status(404).sendFile(path.join(__dirname, 'index.html'));
            return;
        }
        
        if (req.accepts('json')) {
            res.status(404).json({ error: 'Not found' });
            return;
        }
        
        res.status(404).type('txt').send('Not found');
    });
    
    // Error handler
    app.use((err, req, res, next) => {
        console.error(err.stack);
        res.status(500).json({ error: 'Something broke!' });
    });
}

module.exports = {
    configureStaticFiles,
    configureSecurityHeaders,
    configureErrorHandling
};
