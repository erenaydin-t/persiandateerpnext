# Persian Date ERPNext

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![ERPNext](https://img.shields.io/badge/ERPNext-15.64.1+-blue.svg)](https://github.com/frappe/erpnext)
[![Frappe Framework](https://img.shields.io/badge/Frappe%20Framework-15+-red.svg)](https://github.com/frappe/frappe)

A comprehensive solution to convert ERPNext date and datetime fields to Shamsi (Jalali) Calendar. This application works seamlessly with all date and datetime fields across ERPNext, providing a native Persian calendar experience while maintaining full compatibility with the underlying Gregorian date system.

اپلیکیشن جامع برای تبدیل فیلدهای تاریخ و تاریخ-ساعت ERPNext به تقویم شمسی (جلالی). این برنامه به طور یکپارچه با تمام فیلدهای تاریخ در ERPNext کار می‌کند و تجربه تقویم فارسی بومی را فراهم می‌آورد.

## 🚨 مشکل Assets Loading دارید؟
**راه‌حل فوری**: مراجعه کنید به [TROUBLESHOOTING.md](TROUBLESHOOTING.md) برای حل مشکل کامل گام به گام!

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

# Get the app from GitHub (latest v1.0.3)
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git

# Install the app on your site
bench --site [your-site-name] install-app persiandateerpnext

# Run migrations to install custom fields
bench --site [your-site-name] migrate

# Build assets with force flag
bench build --app persiandateerpnext --force

# Clear cache
bench --site [your-site-name] clear-cache

# Restart bench
bench restart
```

### 🚨 اگر مشکل Assets دارید:

```bash
# Complete reinstall process:
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
bench --site [site-name] install-app persiandateerpnext
bench --site [site-name] migrate
bench build --app persiandateerpnext --force
bench restart
```

## Configuration | پیکربندی

### 1. Enable Jalali Calendar

1. Login to your ERPNext site as Administrator
2. Go to **Settings → System Settings**
3. Find **"Enable Shamsi (Jalali) Calendar"** checkbox
4. Check the box to enable Jalali calendar ✅
5. Select **Date Storage Format**:
   - **Gregorian (میلادی)**: Stores dates in Gregorian format (recommended for compatibility)
   - **Persian (شمسی)**: Stores dates in Persian format
6. Save the settings
7. **Refresh your browser** (Ctrl+F5)

### 2. Verify Installation

Open browser console (F12) and look for these messages:
```
🔍 Persian Date ERPNext Debug Check
✅ Persian Date library loaded
✅ Persian Datepicker library loaded
✅ Shamsi Calendar is ENABLED
📅 Storage Format: Gregorian
✅ Persian Datepicker CSS loaded
```

## Troubleshooting | عیب‌یابی

### ⚠️ اگر Persian datepicker نمایش داده نمی‌شود:

1. **برای راه‌حل کامل**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md) را مطالعه کنید
2. **فوری**: نسخه v1.0.3 را نصب کنید که مشکل assets حل شده
3. **چک کنید**: Browser console برای error های JavaScript

### Quick Fix:
```bash
# Force rebuild everything:
bench build --app persiandateerpnext --force
bench --site [site-name] clear-cache
bench restart

# Check assets exist:
ls -la sites/assets/persiandateerpnext/css/
ls -la sites/assets/persiandateerpnext/js/
```

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

## Support | پشتیبانی

- **🔧 Troubleshooting**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **🐛 GitHub Issues**: [Report bugs](https://github.com/erenaydin-t/persiandateerpnext/issues)
- **📧 Email**: ideenemium@gmail.com

## Changelog | تغییرات

### Version 1.0.4 (Current - Assets Fix)
- 🔧 **CRITICAL FIX**: Manual assets copy system to resolve 404 errors
- 📜 **Add**: Auto-fix script (fix_assets.sh) for manual troubleshooting
- 🔍 **Add**: Enhanced installation hooks with asset verification
- 📚 **Add**: Comprehensive TROUBLESHOOTING.md with 404 solutions

### Version 1.0.2
- 🐛 **Fix**: Asset bundling and loading issues
- ✨ **Add**: Installation hooks with user notifications
- 📚 **Update**: Comprehensive troubleshooting guide
- 🔧 **Improve**: Build process and cache management

### Version 1.0.1
- 🐛 **Fix**: Module structure for proper installation
- ✨ **Add**: persian_date_erpnext module directory
- 📚 **Update**: Installation troubleshooting guide

### Version 1.0.0
- ✨ Initial release
- ✨ Full ERPNext 15.64.1+ compatibility
- ✨ Dual storage mode support
- ✨ Complete form integration
- ✨ Automatic System Settings configuration
- ✨ Production-ready code quality

---

**Made with ❤️ for the Persian ERPNext community**

**با ❤️ برای جامعه فارسی ERPNext ساخته شده**
