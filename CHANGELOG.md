# Changelog

All notable changes to the Persian Date ERPNext project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-06-08

### Added
- ✨ Complete ERPNext 15.64.1+ compatibility
- ✨ Dual storage mode support (Gregorian/Persian)
- ✨ Automatic System Settings configuration with custom fields
- ✨ Seamless integration with all Date and Datetime fields
- ✨ Real-time Gregorian date display below Jalali fields
- ✨ Beautiful Persian datepicker with RTL support
- ✨ Smart "Only"/"فقط" suffix cleanup for in_words fields
- ✨ Responsive design for mobile devices
- ✨ Dark mode support
- ✨ Complete form lifecycle integration
- ✨ Production-ready code quality with proper error handling
- ✨ Comprehensive documentation and installation guide
- ✨ MIT license for open source distribution

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
