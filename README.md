# Persian Date ERPNext

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![ERPNext](https://img.shields.io/badge/ERPNext-15.64.1+-blue.svg)](https://github.com/frappe/erpnext)
[![Frappe Framework](https://img.shields.io/badge/Frappe%20Framework-15+-red.svg)](https://github.com/frappe/frappe)

A comprehensive solution to convert ERPNext date and datetime fields to Shamsi (Jalali) Calendar. This application works seamlessly with all date and datetime fields across ERPNext, providing a native Persian calendar experience while maintaining full compatibility with the underlying Gregorian date system.

اپلیکیشن جامع برای تبدیل فیلدهای تاریخ و تاریخ-ساعت ERPNext به تقویم شمسی (جلالی). این برنامه به طور یکپارچه با تمام فیلدهای تاریخ در ERPNext کار می‌کند و تجربه تقویم فارسی بومی را فراهم می‌آورد.

## Features | ویژگی‌ها

### 🗓️ Complete Calendar Integration
- **Seamless Date Conversion**: Automatic conversion between Jalali and Gregorian calendars
- **Universal Field Support**: Works with all Date and Datetime fields across ERPNext
- **Real-time Display**: Shows Gregorian equivalent below selected Jalali dates
- **Smart Storage**: Configurable storage format (Gregorian or Persian)

### 🎯 User Experience
- **Native Persian Interface**: Beautiful Persian datepicker with RTL support
- **Latin Numerals**: Uses Latin digits for better compatibility
- **Auto-close Feature**: Automatically closes picker after date selection
- **Responsive Design**: Works perfectly on all screen sizes

### ⚙️ System Integration
- **System Settings**: Easy enable/disable through ERPNext System Settings
- **Custom Fields**: Automatic creation of required configuration fields
- **Hook Integration**: Proper integration with ERPNext form lifecycle
- **Performance Optimized**: Minimal overhead on system performance

## Requirements | پیش‌نیازها

- **ERPNext**: Version 15.64.1 or higher
- **Frappe Framework**: Version 15 or higher
- **Python**: 3.8+ 
- **Node.js**: 14+ (for building assets)

## Installation | نصب

### Method 1: Using Bench (Recommended)

```bash
# Navigate to your bench directory
cd /path/to/your/bench

# Get the app from GitHub
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git

# Install the app on your site
bench --site [your-site-name] install-app persiandateerpnext

# Build assets
bench build --app persiandateerpnext

# Restart bench
bench restart
```

### Method 2: Manual Installation

```bash
# Clone the repository
git clone https://github.com/erenaydin-t/persiandateerpnext.git

# Move to apps directory
mv persiandateerpnext /path/to/your/bench/apps/

# Install the app
bench --site [your-site-name] install-app persiandateerpnext

# Build and restart
bench build
bench restart
```

### Method 3: Development Installation

```bash
# Clone for development
git clone https://github.com/erenaydin-t/persiandateerpnext.git
cd persiandateerpnext

# Install in development mode
bench --site [your-site-name] install-app persiandateerpnext --dev

# Build assets
bench build --app persiandateerpnext
```

## Configuration | پیکربندی

### 1. Enable Jalali Calendar

1. Login to your ERPNext site as Administrator
2. Go to **Settings → System Settings**
3. Find **"Enable Shamsi (Jalali) Calendar"** checkbox
4. Check the box to enable Jalali calendar
5. Select **Date Storage Format**:
   - **Gregorian (میلادی)**: Stores dates in Gregorian format (recommended for compatibility)
   - **Persian (شمسی)**: Stores dates in Persian format
6. Save the settings

### 2. Clear Cache

```bash
bench --site [your-site-name] clear-cache
bench --site [your-site-name] clear-website-cache
```

### 3. Reload Browser

Refresh your browser to see the Jalali datepicker in action!

## Usage | نحوه استفاده

### Basic Usage

Once enabled, all date and datetime fields throughout ERPNext will automatically use the Jalali calendar:

- **Click any date field**: Jalali datepicker opens automatically
- **Select date**: Use the Persian calendar interface
- **Gregorian display**: See the Gregorian equivalent below the field
- **Save normally**: Data is stored according to your storage format setting

### Storage Modes

#### Gregorian Storage Mode (Recommended)
- **Frontend**: Displays Jalali dates to users
- **Backend**: Stores Gregorian dates in database
- **Compatibility**: Full compatibility with existing ERPNext features
- **Reports**: All reports work without modification

#### Persian Storage Mode
- **Frontend**: Displays Jalali dates to users  
- **Backend**: Stores Persian dates in database
- **Use Case**: When you need Persian dates in reports
- **Note**: May require custom report modifications

## File Structure | ساختار فایل‌ها

```
persiandateerpnext/
├── persiandateerpnext/
│   ├── config/
│   ├── fixtures/
│   │   └── custom_field.json      # System Settings custom fields
│   ├── persian_date_erpnext/       # Main module
│   │   └── doctype/
│   ├── public/
│   │   ├── css/
│   │   │   ├── custom.css         # Custom styling
│   │   │   └── persian-datepicker.min.css
│   │   └── js/
│   │       ├── in_words_cleanup.js    # Removes "Only" suffix
│   │       ├── persian-date.min.js    # Persian date library
│   │       ├── persian-datepicker.min.js
│   │       ├── togregorian_date.js    # Gregorian storage mode
│   │       └── topersian_date.js      # Persian storage mode
│   ├── templates/
│   ├── hooks.py                   # App configuration
│   ├── modules.txt
│   └── patches.txt
├── pyproject.toml                 # Python package configuration
├── README.md
├── LICENSE
└── __init__.py
```

## Technical Details | جزئیات فنی

### JavaScript Libraries Used

- **persian-date.js**: Core Persian date manipulation library
- **persian-datepicker.js**: Beautiful Persian datepicker UI component
- **Custom integration scripts**: Handle ERPNext form lifecycle

### Custom Fields Added

The app automatically adds these custom fields to System Settings:

1. **Enable Shamsi (Jalali) Calendar** (Check): Master enable/disable switch
2. **Date Storage Format** (Select): Choose between Gregorian/Persian storage

### Form Integration

The app integrates with ERPNext forms through:

- **form-load events**: Initialize datepickers on form load
- **form-refresh events**: Re-initialize after form updates
- **before_save hooks**: Convert dates before saving (in Gregorian mode)

## Troubleshooting | عیب‌یابی

### Common Issues

#### 1. Module not found error
If you encounter "No module named 'persiandateerpnext.persian_date_erpnext'" error during installation:

```bash
# This is resolved in the latest version
# If it persists, try:
bench --site [site-name] uninstall-app persiandateerpnext
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git --force
bench --site [site-name] install-app persiandateerpnext
```

#### 2. Datepicker Not Showing
```bash
# Clear cache and rebuild
bench --site [site-name] clear-cache
bench build --app persiandateerpnext
bench restart
```

#### 3. Persian Fonts Not Loading
- Ensure your browser supports Persian fonts
- Check CSS files are loading correctly in browser developer tools

#### 4. Date Conversion Issues
- Verify System Settings configuration
- Check browser console for JavaScript errors
- Ensure all required JS libraries are loaded

#### 5. Installation Errors
```bash
# Check app installation status
bench --site [site-name] list-apps

# Reinstall if necessary
bench --site [site-name] uninstall-app persiandateerpnext
bench --site [site-name] install-app persiandateerpnext
```

### Debug Mode

Enable debug mode to see detailed console logs:

```javascript
// Add this to browser console
localStorage.setItem('persian_debug', 'true');
```

## Development | توسعه

### Setting Up Development Environment

```bash
# Clone repository
git clone https://github.com/erenaydin-t/persiandateerpnext.git
cd persiandateerpnext

# Install in development mode
bench get-app .
bench --site development.localhost install-app persiandateerpnext

# Start development
bench start
```

### Building for Production

```bash
# Build production assets
bench build --app persiandateerpnext --production

# Create production bundle
bench bundle-app persiandateerpnext
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Compatibility | سازگاری

### ERPNext Versions
- ✅ ERPNext 15.64.1+
- ✅ ERPNext 15.x (latest)
- ❓ ERPNext 14.x (may work but not tested)
- ❌ ERPNext 13.x and below

### Browsers
- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+
- ❌ Internet Explorer (not supported)

## License | مجوز

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support | پشتیبانی

- **GitHub Issues**: [Report bugs or request features](https://github.com/erenaydin-t/persiandateerpnext/issues)
- **Email**: ideenemium@gmail.com
- **Documentation**: This README file

## Changelog | تغییرات

### Version 1.0.1
- 🐛 Fixed module structure for proper installation
- ✨ Added persian_date_erpnext module directory
- 📚 Updated installation troubleshooting guide

### Version 1.0.0
- ✨ Initial release
- ✨ Full ERPNext 15.64.1+ compatibility
- ✨ Dual storage mode support
- ✨ Complete form integration
- ✨ Automatic System Settings configuration
- ✨ Production-ready code quality

## Acknowledgments | قدردانی

- [Persian Date Library](https://github.com/babakhani/PersianDate) for core date functionality
- [Persian Datepicker](https://github.com/babakhani/pwt.datepicker) for the beautiful UI component
- ERPNext community for the amazing framework
- All contributors who helped improve this project

---

**Made with ❤️ for the Persian ERPNext community**

**با ❤️ برای جامعه فارسی ERPNext ساخته شده**
