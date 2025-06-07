# Contributing to Persian Date ERPNext

Thank you for your interest in contributing to the Persian Date ERPNext project! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

### Our Standards

- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

## Getting Started

### Prerequisites

- ERPNext 15.64.1+
- Frappe Framework 15+
- Python 3.8+
- Node.js 14+
- Git

### Development Setup

1. **Fork the repository**
   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/erenaydin-t/persiandateerpnext.git
   cd persiandateerpnext
   ```

2. **Set up development environment**
   ```bash
   # Navigate to your Frappe bench
   cd /path/to/your/bench
   
   # Get the app in development mode
   bench get-app /path/to/persiandateerpnext --branch main
   
   # Install on your development site
   bench --site development.localhost install-app persiandateerpnext
   
   # Start development server
   bench start
   ```

3. **Create a branch for your feature**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Contributing Guidelines

### Types of Contributions

We welcome several types of contributions:

- 🐛 **Bug fixes**: Help us identify and fix issues
- ✨ **New features**: Add functionality that benefits the community
- 📚 **Documentation**: Improve docs, add examples, fix typos
- 🎨 **UI/UX improvements**: Enhance the user experience
- 🔧 **Performance optimizations**: Make the app faster and more efficient
- 🌐 **Translations**: Help translate the app to other languages
- 🧪 **Tests**: Add or improve test coverage

### Before You Start

1. **Check existing issues**: Look for existing issues or feature requests
2. **Create an issue**: If none exists, create one to discuss your idea
3. **Get feedback**: Wait for maintainer feedback before starting work
4. **Start small**: Begin with small, focused contributions

## Pull Request Process

### 1. Prepare Your Changes

```bash
# Make your changes
# Test thoroughly
# Update documentation if needed

# Stage your changes
git add .
git commit -m "feat: add awesome new feature"
```

### 2. Commit Message Format

Use the [Conventional Commits](https://conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

**Examples:**
```
feat: add Persian storage mode for dates
fix: resolve datepicker positioning in modals
docs: update installation instructions
style: improve CSS for mobile responsiveness
```

### 3. Submit Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create pull request on GitHub
```

### 4. Pull Request Template

When creating a PR, please include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement

## Testing
- [ ] Tested on ERPNext 15.64.1+
- [ ] Tested on multiple browsers
- [ ] Tested with both storage modes

## Screenshots (if applicable)
Add screenshots to help explain your changes

## Checklist
- [ ] Code follows project coding standards
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
```

## Testing

### Manual Testing Checklist

Before submitting a PR, test the following:

#### Date Field Testing
- [ ] Date picker opens correctly
- [ ] Persian date selection works
- [ ] Gregorian equivalent displays correctly
- [ ] Date saves properly in chosen format
- [ ] Form validation works

#### Datetime Field Testing
- [ ] Datetime picker opens correctly
- [ ] Time selection works
- [ ] Persian datetime selection works
- [ ] Datetime saves properly

#### Cross-Browser Testing
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)

#### Responsive Testing
- [ ] Desktop (1920x1080)
- [ ] Tablet (768x1024)
- [ ] Mobile (375x667)

#### ERPNext Integration
- [ ] System Settings configuration
- [ ] Various DocTypes (Sales Invoice, Purchase Order, etc.)
- [ ] Grid/Table fields
- [ ] Filter fields
- [ ] Report date fields

### Testing Commands

```bash
# Build assets for testing
bench build --app persiandateerpnext

# Clear cache
bench --site [site-name] clear-cache

# Restart services
bench restart

# Check for JavaScript errors in browser console
# Test in incognito/private mode
```

## Development

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

## Community

### Getting Help

- 🐛 **Issues**: [GitHub Issues](https://github.com/erenaydin-t/persiandateerpnext/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/erenaydin-t/persiandateerpnext/discussions)

### Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- GitHub contributor graphs

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Persian Date ERPNext! 🎉

**با تشکر از مشارکت شما در پروژه تقویم شمسی ERPNext!** 🙏
