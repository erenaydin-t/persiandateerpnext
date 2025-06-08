# Changelog

All notable changes to the Persian Date ERPNext project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2025-06-08

### Added
- 🔧 **CRITICAL FIX**: Manual assets copy system to resolve 404 errors
- 📜 Auto-fix script (fix_assets.sh) for manual troubleshooting
- 🔍 Enhanced installation hooks with asset verification
- 📚 Comprehensive TROUBLESHOOTING.md with 404 solutions

### Fixed
- 🐛 **MAJOR**: Assets not loading (404 errors) - now auto-copied during install
- 🔧 ERPNext 15+ compatibility with proper asset paths
- 🎯 Production and development mode asset serving

### Improved
- 🚀 Installation process with automatic asset copying
- 🧹 Asset cleanup during uninstall
- 📖 Installation documentation with troubleshooting

## [1.0.1] - 2025-06-08

### Fixed
- 🐛 Module structure for proper installation
- ✨ Added persian_date_erpnext module directory
- 📚 Updated installation troubleshooting guide

## [1.0.0] - 2025-06-08

### Added
- ✨ Initial release
- ✨ Complete ERPNext 15.64.1+ compatibility
- ✨ Dual storage mode support (Gregorian/Persian)
- ✨ Complete form integration
- ✨ Automatic System Settings configuration
- ✨ Production-ready code quality

### Technical Features
- 🔧 Proper hooks.py configuration for ERPNext 15+
- 🔧 pyproject.toml for modern Python package management
- 🔧 Custom CSS with ERPNext theme integration
- 🔧 JavaScript modules with proper error handling
- 🔧 Fixture-based custom field management
- 🔧 Asset optimization and caching support
- 🔧 Cross-browser compatibility
- 🔧 Performance optimized initialization

### Documentation
- 📚 Comprehensive README with installation instructions
- 📚 Configuration guide with screenshots
- 📚 Troubleshooting section
- 📚 Development setup instructions
- 📚 API documentation
- 📚 License file (MIT)
- 📚 Changelog tracking

### Infrastructure
- 🏗️ Clean project structure following ERPNext conventions
- 🏗️ Proper .gitignore for Python/JavaScript projects
- 🏗️ manifest.json for app metadata
- 🏗️ Version management across all files
- 🏗️ Development and production build configurations

### Storage Modes

#### Gregorian Storage Mode
- Displays Jalali dates in UI
- Stores Gregorian dates in database
- Full compatibility with existing ERPNext features
- Recommended for production use

#### Persian Storage Mode  
- Displays Jalali dates in UI
- Stores Persian dates in database
- Useful for Persian-only reporting requirements
- Requires custom report modifications

### Browser Support
- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+
- ❌ Internet Explorer (not supported)

### Known Issues
- None currently identified

### Migration Notes
- Fresh installation recommended
- Backup existing data before installation
- Clear cache after installation
- Test in development environment first

---

## [Unreleased]

### Planned Features
- 🔮 Integration with ERPNext Reports
- 🔮 Custom print format support
- 🔮 Bulk date conversion utilities
- 🔮 Advanced calendar customization options
- 🔮 Multi-language support (Persian/English/Arabic)
- 🔮 Holiday management integration
- 🔮 Time zone awareness
- 🔮 Calendar widget for dashboards

### Possible Improvements
- Performance optimizations for large forms
- Enhanced mobile experience
- Better accessibility features
- Integration with Frappe Desk calendar
- Custom field type for Jalali dates
- Automated testing suite

---

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Support

- 🐛 [Report bugs](https://github.com/erenaydin-t/persiandateerpnext/issues)
- 💡 [Request features](https://github.com/erenaydin-t/persiandateerpnext/issues)
- 📧 Email: ideenemium@gmail.com

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
