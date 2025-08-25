# Email Setup for DriveBackup Pro Website

## Overview
The contact form on the support page now sends emails using Gmail SMTP. When users submit the form, it sends:
1. A notification email to `drive@mojokgroup.xyz` with the user's message
2. A confirmation email to the user thanking them for their message

## Setup Instructions

### 1. Install Dependencies
Run one of these commands in your project directory:

**Windows:**
```bash
install.bat
```

**Manual installation:**
```bash
npm install
```

### 2. Start the Server
```bash
npm start
```

For development with auto-restart:
```bash
npm run dev
```

### 3. Test the Contact Form
1. Open your browser and go to `http://localhost:3000/support`
2. Fill out the contact form
3. Submit the form
4. Check both email addresses for the messages

## Email Configuration

### Gmail SMTP Settings
- **Username:** `devverge.254@gmail.com`
- **Password:** `kgie ntnq dudx ywvg` (App Password)
- **SMTP Server:** smtp.gmail.com
- **Port:** 587 (TLS)

### Email Flow
1. **User submits form** → Form data is validated
2. **Email sent to support** → `drive@mojokgroup.xyz` receives the user's message
3. **Confirmation sent to user** → User receives a thank you email

## Email Templates

### Support Notification Email
- **To:** `drive@mojokgroup.xyz`
- **Subject:** `[DriveBackup Pro Support] {user's subject}`
- **Content:** Professional HTML template with user's message details

### User Confirmation Email
- **To:** User's email address
- **Subject:** `Thank you for contacting DriveBackup Pro Support`
- **Content:** Thank you message with contact details and response time

## Features

### Form Validation
- Required field validation
- Email format validation
- Real-time error messages

### User Experience
- Loading states during submission
- Success/error notifications
- Form reset after successful submission
- Responsive design

### Security
- Input sanitization
- CORS protection
- Error handling
- Rate limiting (basic)

## Troubleshooting

### Common Issues

1. **"Authentication failed" error**
   - Check if the Gmail app password is correct
   - Ensure 2-factor authentication is enabled on the Gmail account

2. **"Connection timeout" error**
   - Check your internet connection
   - Verify Gmail SMTP settings

3. **Form not submitting**
   - Check browser console for JavaScript errors
   - Ensure the server is running on port 3000

### Gmail App Password Setup
If you need to generate a new app password:

1. Go to your Google Account settings
2. Navigate to Security
3. Enable 2-Step Verification if not already enabled
4. Go to App passwords
5. Generate a new app password for "Mail"
6. Update the password in `server.js`

## File Structure
```
├── server.js              # Main server with email functionality
├── package.json           # Dependencies and scripts
├── support.html           # Support page with contact form
├── install.bat            # Windows installation script
└── EMAIL_SETUP_README.md  # This file
```

## API Endpoint
- **URL:** `POST /api/contact`
- **Content-Type:** `application/json`
- **Body:** `{ name, email, subject, message, priority }`

## Support
If you encounter any issues with the email functionality, check:
1. Gmail account settings
2. Network connectivity
3. Server logs for error messages
4. Browser console for JavaScript errors
