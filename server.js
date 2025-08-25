const express = require('express');
const nodemailer = require('nodemailer');
const path = require('path');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('.'));

// Gmail SMTP Configuration
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'devverge.254@gmail.com',
        pass: 'kgie ntnq dudx ywvg'
    }
});

// Email template function
function createEmailTemplate(formData) {
    return `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f8fafc;">
            <div style="background-color: #07553B; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0;">
                <h2 style="margin: 0;">New Support Request</h2>
            </div>
            
            <div style="background-color: white; padding: 20px; border-radius: 0 0 8px 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h3 style="color: #07553B; margin-top: 0;">Contact Information</h3>
                <p><strong>Name:</strong> ${formData.name}</p>
                <p><strong>Email:</strong> ${formData.email}</p>
                <p><strong>Subject:</strong> ${formData.subject}</p>
                <p><strong>Priority:</strong> ${formData.priority}</p>
                
                <h3 style="color: #07553B;">Message</h3>
                <div style="background-color: #f8fafc; padding: 15px; border-radius: 5px; border-left: 4px solid #07553B;">
                    <p style="margin: 0; white-space: pre-wrap;">${formData.message}</p>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e5e7eb;">
                
                <p style="color: #6b7280; font-size: 14px; margin: 0;">
                    This message was sent from the DriveBackup Pro support form.<br>
                    Timestamp: ${new Date().toLocaleString()}
                </p>
            </div>
        </div>
    `;
}

// Contact form endpoint
app.post('/api/contact', async (req, res) => {
    try {
        const { name, email, subject, message, priority } = req.body;

        // Validation
        if (!name || !email || !subject || !message) {
            return res.status(400).json({
                success: false,
                message: 'All required fields must be filled out'
            });
        }

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({
                success: false,
                message: 'Please enter a valid email address'
            });
        }

        // Email options
        const mailOptions = {
            from: '"DriveBackup Pro by Mojok Dev Ke. Solutions" <drive@mojokgroup.xyz>',
            to: 'drive@mojokgroup.xyz',
            subject: `[DriveBackup Pro Support] ${subject}`,
            html: createEmailTemplate({ name, email, subject, message, priority })
        };

        // Send email
        await transporter.sendMail(mailOptions);

        // Send confirmation email to user
        const userMailOptions = {
            from: '"DriveBackup Pro Support" <drive@mojokgroup.xyz>',
            to: email,
            subject: 'Thank you for contacting DriveBackup Pro Support',
            html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f8fafc;">
                    <div style="background-color: #07553B; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0;">
                        <h2 style="margin: 0;">Thank You!</h2>
                    </div>
                    
                    <div style="background-color: white; padding: 20px; border-radius: 0 0 8px 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                        <h3 style="color: #07553B;">Hello ${name},</h3>
                        
                        <p>Thank you for contacting DriveBackup Pro Support. We have received your message and will get back to you as soon as possible.</p>
                        
                        <div style="background-color: #f8fafc; padding: 15px; border-radius: 5px; margin: 20px 0;">
                            <h4 style="margin-top: 0; color: #07553B;">Your Message Details:</h4>
                            <p><strong>Subject:</strong> ${subject}</p>
                            <p><strong>Priority:</strong> ${priority}</p>
                            <p><strong>Submitted:</strong> ${new Date().toLocaleString()}</p>
                        </div>
                        
                        <p>Our support team typically responds within 24 hours. If you have an urgent issue, you can also reach us at:</p>
                        
                        <ul style="color: #6b7280;">
                            <li>Email: drive@mojokgroup.xyz</li>
                            <li>Phone: +254798564925</li>
                        </ul>
                        
                        <p>Best regards,<br>
                        <strong>The DriveBackup Pro Team</strong></p>
                        
                        <hr style="margin: 20px 0; border: none; border-top: 1px solid #e5e7eb;">
                        
                        <p style="color: #6b7280; font-size: 14px; margin: 0;">
                            This is an automated response. Please do not reply to this email.
                        </p>
                    </div>
                </div>
            `
        };

        await transporter.sendMail(userMailOptions);

        res.json({
            success: true,
            message: 'Thank you! Your message has been sent successfully. We will get back to you soon.'
        });

    } catch (error) {
        console.error('Email sending error:', error);
        res.status(500).json({
            success: false,
            message: 'Sorry, there was an error sending your message. Please try again later.'
        });
    }
});

// Serve static files
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

// Start server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    console.log('Contact form endpoint: POST /api/contact');
});
