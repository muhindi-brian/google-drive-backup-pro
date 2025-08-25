# DriveBackup Pro Website

A professional, modern, and responsive website for the Google Drive Backup Tool application.

## 🚀 Features

### Multi-Page Structure
- **Home Page** (`index.html`) - Landing page with hero section, features overview, and call-to-action
- **Features Page** (`features.html`) - Detailed feature showcase with comparison table
- **Download Page** (`download.html`) - Download options, system requirements, and installation guide
- **Documentation Page** (`docs.html`) - Comprehensive documentation with API reference
- **Support Page** (`support.html`) - Support options, contact form, and community links
- **About Page** (`about.html`) - Company information, mission, team, and compliance details
- **Privacy Policy** (`privacy-policy.html`) - Comprehensive privacy policy meeting Google API requirements
- **Terms of Service** (`terms-of-service.html`) - Detailed terms of service with legal protections

### Google API Verification Compliance
The website has been updated to meet Google's API verification requirements:

#### Legal Pages
- **Privacy Policy**: Comprehensive policy covering data collection, usage, security, and user rights
- **Terms of Service**: Detailed terms including user obligations, service limitations, and legal protections
- **Google API Compliance**: Specific sections addressing Google's API Services User Data Policy

#### Compliance Features
- Minimum necessary permissions only
- No data used for advertising purposes
- Clear data usage information
- Easy access revocation
- Secure OAuth 2.0 implementation
- Privacy-first design principles

### Design Features
- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Modern UI**: Clean, professional design with smooth animations
- **Interactive Elements**: FAQ accordions, tabbed navigation, contact forms
- **Accessibility**: Semantic HTML and keyboard navigation support
- **Performance**: Optimized CSS and JavaScript for fast loading

### Technical Features
- **CSS Grid & Flexbox**: Modern layout techniques
- **CSS Custom Properties**: Consistent theming and easy customization
- **JavaScript Interactivity**: Smooth scrolling, form handling, and dynamic content
- **Font Awesome Icons**: Professional iconography throughout
- **Google Fonts**: Inter font family for modern typography

## 📁 File Structure

```
website/
├── index.html              # Home page
├── features.html           # Features page
├── download.html           # Download page
├── docs.html              # Documentation page
├── support.html           # Support page
├── about.html             # About page
├── privacy-policy.html    # Privacy policy (Google API compliant)
├── terms-of-service.html  # Terms of service (Google API compliant)
├── styles.css             # Main stylesheet
├── script.js              # JavaScript functionality
├── deploy_website.py      # Deployment script
└── README_WEBSITE.md      # This file
```

## 🎨 Design System

### Color Palette
- **Primary**: Blue gradient (#667eea to #764ba2)
- **Secondary**: Blue (#3b82f6)
- **Success**: Green (#10b981)
- **Warning**: Orange (#f59e0b)
- **Error**: Red (#ef4444)
- **Text**: Dark gray (#1e293b)
- **Background**: Light gray (#f8fafc)

### Typography
- **Font Family**: Inter (Google Fonts)
- **Weights**: 300, 400, 500, 600, 700
- **Sizes**: Responsive scaling from 0.875rem to 3rem

### Components
- **Buttons**: Primary, secondary, and outline variants
- **Cards**: Feature cards, team cards, and value cards
- **Forms**: Contact forms with validation
- **Navigation**: Responsive navbar with mobile menu
- **Tables**: Comparison tables and data tables

## 🚀 Getting Started

### Local Development

#### Option 1: Using Node.js (Recommended)

The website now includes a complete Node.js setup with Express.js server:

1. **Navigate to the website directory:**
   ```bash
   cd website
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Start the server:**
   ```bash
   npm start
   ```

4. **Open your browser and visit:**
   ```
   http://localhost:3000
   ```

**Quick Start Scripts:**
- Windows: `start_website.bat`
- Linux/macOS: `./start_website.sh`

For detailed Node.js instructions, see [README_NODEJS.md](README_NODEJS.md).

#### Option 2: Using Python (Simple HTTP Server)

1. **Clone or download the website files**
2. **Open `index.html` in your web browser**
3. **Or use a local server:**
   ```bash
   cd website
   python -m http.server 8000
   ```
4. **Visit `http://localhost:8000`**

#### Option 3: Using Node.js HTTP Server

```bash
cd website
npx http-server -p 8000
```

### Deployment Options
The website can be deployed to various platforms:

#### GitHub Pages
1. Create a new repository
2. Upload all website files
3. Enable GitHub Pages in repository settings
4. Select source branch (usually `main`)

#### Netlify
1. Drag and drop the website folder to Netlify
2. Or connect your GitHub repository
3. Automatic deployment on push

#### Vercel
1. Install Vercel CLI: `npm i -g vercel`
2. Run `vercel` in the website directory
3. Follow the prompts

#### Traditional Hosting
1. Upload files via FTP/SFTP
2. Ensure all files are in the correct directory structure
3. Update any absolute paths if necessary

## 📱 Responsive Breakpoints

- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

## 🔧 Customization

### Colors
Update CSS custom properties in `styles.css`:
```css
:root {
    --primary-color: #3b82f6;
    --secondary-color: #1d4ed8;
    --accent-color: #10b981;
    /* ... */
}
```

### Content
- Update text content in HTML files
- Replace placeholder images with your own
- Modify contact information and links

### Styling
- Customize component styles in `styles.css`
- Add new CSS classes as needed
- Modify responsive breakpoints

## 📄 Legal Compliance

### Google API Requirements
The website includes comprehensive legal pages that meet Google's API verification requirements:

1. **Privacy Policy**: Covers all required aspects of data handling
2. **Terms of Service**: Includes user obligations and service limitations
3. **Data Usage**: Clear information about how data is collected and used
4. **Access Control**: Easy ways for users to revoke access
5. **Security**: Information about data protection measures

### Key Compliance Features
- Minimum necessary permissions
- No advertising use of data
- Clear data usage information
- Easy access revocation
- Secure OAuth 2.0 implementation
- Privacy-first design

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test across different devices and browsers
5. Submit a pull request

## 📞 Support

For support with the website:
- Check the documentation page
- Contact support through the support page
- Review the FAQ section

## 📄 License

This website is part of the DriveBackup Pro project. See the main project license for details.

---

**Note**: This website is designed to meet Google API verification requirements and includes all necessary legal documentation for compliance with Google's API Services User Data Policy.
