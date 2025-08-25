const http = require('http');

// Test if the server is running
const testServer = () => {
    const options = {
        hostname: 'localhost',
        port: 3000,
        path: '/',
        method: 'GET'
    };

    const req = http.request(options, (res) => {
        console.log(`✅ Server is running! Status: ${res.statusCode}`);
        console.log(`📱 Website available at: http://localhost:3000`);
        
        if (res.statusCode === 200) {
            console.log(`🎉 Server test successful!`);
        } else {
            console.log(`⚠️  Server responded with status: ${res.statusCode}`);
        }
    });

    req.on('error', (err) => {
        console.log(`❌ Server test failed: ${err.message}`);
        console.log(`💡 Make sure the server is running with: npm start`);
    });

    req.setTimeout(5000, () => {
        console.log(`⏰ Server test timed out`);
        console.log(`💡 Make sure the server is running with: npm start`);
    });

    req.end();
};

// Run the test
console.log('🔍 Testing DriveBackup Pro Website Server...');
console.log('⏳ Waiting for server response...');
testServer();

