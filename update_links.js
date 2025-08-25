const fs = require('fs');
const path = require('path');

// Function to update HTML files to use clean URLs
function updateHtmlLinks() {
    const htmlFiles = [
        'index.html',
        'features.html',
        'download.html',
        'docs.html',
        'support.html',
        'about.html',
        'privacy-policy.html',
        'terms-of-service.html'
    ];

    console.log('🔄 Updating HTML files to use clean URLs...');

    htmlFiles.forEach(file => {
        if (fs.existsSync(file)) {
            let content = fs.readFileSync(file, 'utf8');
            
            // Replace .html extensions in href attributes
            content = content.replace(/href="([^"]+)\.html"/g, 'href="$1"');
            
            // Special case: index.html should be just "/"
            content = content.replace(/href="index"/g, 'href="/"');
            
            fs.writeFileSync(file, content, 'utf8');
            console.log(`✅ Updated ${file}`);
        } else {
            console.log(`⚠️  File not found: ${file}`);
        }
    });

    console.log('\n🎉 All HTML files updated successfully!');
    console.log('📝 Clean URLs are now active:');
    console.log('   • / (Home)');
    console.log('   • /features');
    console.log('   • /download');
    console.log('   • /docs');
    console.log('   • /support');
    console.log('   • /about');
    console.log('   • /privacy-policy');
    console.log('   • /terms-of-service');
}

// Run the update
updateHtmlLinks();

