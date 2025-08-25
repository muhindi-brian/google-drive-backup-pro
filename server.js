const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files (CSS, JS, images)
app.use(express.static(__dirname));

// Set up routes for all HTML pages (without .html extension)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/features', (req, res) => {
    res.sendFile(path.join(__dirname, 'features.html'));
});

app.get('/download', (req, res) => {
    res.sendFile(path.join(__dirname, 'download.html'));
});

app.get('/docs', (req, res) => {
    res.sendFile(path.join(__dirname, 'docs.html'));
});

app.get('/support', (req, res) => {
    res.sendFile(path.join(__dirname, 'support.html'));
});

app.get('/about', (req, res) => {
    res.sendFile(path.join(__dirname, 'about.html'));
});

app.get('/privacy-policy', (req, res) => {
    res.sendFile(path.join(__dirname, 'privacy-policy.html'));
});

app.get('/terms-of-service', (req, res) => {
    res.sendFile(path.join(__dirname, 'terms-of-service.html'));
});

// Handle .html extensions and redirect to clean URLs
app.get('/index.html', (req, res) => {
    res.redirect('/');
});

app.get('/features.html', (req, res) => {
    res.redirect('/features');
});

app.get('/download.html', (req, res) => {
    res.redirect('/download');
});

app.get('/docs.html', (req, res) => {
    res.redirect('/docs');
});

app.get('/support.html', (req, res) => {
    res.redirect('/support');
});

app.get('/about.html', (req, res) => {
    res.redirect('/about');
});

app.get('/privacy-policy.html', (req, res) => {
    res.redirect('/privacy-policy');
});

app.get('/terms-of-service.html', (req, res) => {
    res.redirect('/terms-of-service');
});

// Handle 404 errors
app.use((req, res) => {
    res.status(404).sendFile(path.join(__dirname, 'index.html'));
});

// Start server
app.listen(PORT, () => {
    console.log(`🚀 DriveBackup Pro Website is running!`);
    console.log(`📱 Local: http://localhost:${PORT}`);
    console.log(`🌐 Network: http://0.0.0.0:${PORT}`);
    console.log(`📋 Press Ctrl+C to stop the server`);
    console.log(`\n📁 Available pages (Clean URLs):`);
    console.log(`   • Home: http://localhost:${PORT}/`);
    console.log(`   • Features: http://localhost:${PORT}/features`);
    console.log(`   • Download: http://localhost:${PORT}/download`);
    console.log(`   • Documentation: http://localhost:${PORT}/docs`);
    console.log(`   • Support: http://localhost:${PORT}/support`);
    console.log(`   • About: http://localhost:${PORT}/about`);
    console.log(`   • Privacy Policy: http://localhost:${PORT}/privacy-policy`);
    console.log(`   • Terms of Service: http://localhost:${PORT}/terms-of-service`);
    console.log(`\n✨ Clean URLs enabled - no .html extensions needed!`);
});
