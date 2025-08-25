# Email Setup for DriveBackup Pro Website

## Overview
The contact form on the support page now sends emails using Gmail SMTP. When users submit the form, it sends:
1. A notification email to `drive@mojokgroup.xyz` with the user's message
2. A confirmation email to the user thanking them for their message

## Setup Instructions

### 1. Set Up Environment Variables
**Windows:**
```bash
setup-env.bat
```

**Manual setup:**
```bash
# Copy the example environment file
copy env.example .env

# Edit the .env file with your actual credentials
notepad .env
```

### 2. Install Dependencies
Run one of these commands in your project directory:

**Windows:**
```bash
install.bat
```

**Manual installation:**
```bash
npm install
```

### 3. Configure Environment Variables
Edit the `.env` file with your actual credentials:

```env
# Gmail SMTP Configuration
GMAIL_USER=devverge.254@gmail.com
GMAIL_PASS=kgie ntnq dudx ywvg

# Email Configuration
SUPPORT_EMAIL=drive@mojokgroup.xyz
COMPANY_NAME="DriveBackup Pro by Mojok Dev Ke. Solutions"

# Server Configuration
PORT=3000
NODE_ENV=development
```

### 4. Start the Server
```bash
npm start
```

For development with auto-restart:
```bash
npm run dev
```

### 5. Test the Contact Form
1. Open your browser and go to `http://localhost:3000/support`
2. Fill out the contact form
3. Submit the form
4. Check both email addresses for the messages

## Security Features

### Environment Variables
- **Credentials are stored securely** in `.env` file
- **`.env` file is ignored by Git** (see `.gitignore`)
- **No sensitive data in code** - all credentials use environment variables
- **Example file provided** (`env.example`) for easy setup

### Git Security
- **`.gitignore`** excludes sensitive files from version control
- **Environment variables** keep credentials out of source code
- **Example files** show required configuration without exposing secrets

## Email Configuration

### Gmail SMTP Settings
- **Username:** `devverge.254@gmail.com` (from environment variable)
- **Password:** `kgie ntnq dudx ywvg` (from environment variable)
- **SMTP Server:** smtp.gmail.com
- **Port:** 587 (TLS)

### Email Flow
1. **User submits form** → Form data is validated
2. **Email sent to support** → `drive@mojokgroup.xyz` receives the user's message
3. **Confirmation sent to user** → User receives a thank you email

## Email Templates

### Support Notification Email
- **To:** `drive@mojokgroup.xyz` (from environment variable)
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
- Environment variable protection
- Git ignore for sensitive files

## Troubleshooting

### Common Issues

1. **"Authentication failed" error**
   - Check if the Gmail app password is correct in `.env` file
   - Ensure 2-factor authentication is enabled on the Gmail account

2. **"Connection timeout" error**
   - Check your internet connection
   - Verify Gmail SMTP settings

3. **Form not submitting**
   - Check browser console for JavaScript errors
   - Ensure the server is running on port 3000
   - Verify `.env` file exists and has correct values

4. **Environment variables not loading**
   - Ensure `.env` file exists in project root
   - Check that `dotenv` package is installed
   - Restart the server after creating `.env` file

### Gmail App Password Setup
If you need to generate a new app password:

1. Go to your Google Account settings
2. Navigate to Security
3. Enable 2-Step Verification if not already enabled
4. Go to App passwords
5. Generate a new app password for "Mail"
6. Update the `GMAIL_PASS` in your `.env` file

## File Structure
```
├── server.js              # Main server with email functionality
├── package.json           # Dependencies and scripts
├── support.html           # Support page with contact form
├── .env                   # Environment variables (create from env.example)
├── env.example            # Example environment file
├── .gitignore             # Git ignore rules
├── install.bat            # Windows installation script
├── setup-env.bat          # Environment setup script
└── EMAIL_SETUP_README.md  # This file
```

## API Endpoint
- **URL:** `POST /api/contact`
- **Content-Type:** `application/json`
- **Body:** `{ name, email, subject, message, priority }`

## Security Best Practices
1. **Never commit `.env` file** to version control
2. **Use strong app passwords** for Gmail
3. **Keep credentials secure** and don't share them
4. **Regularly update dependencies** for security patches
5. **Monitor server logs** for any suspicious activity

## Support
If you encounter any issues with the email functionality, check:
1. Gmail account settings and app password
2. Network connectivity
3. Server logs for error messages
4. Browser console for JavaScript errors
5. Environment variable configuration
