#!/bin/bash

# Persian Date ERPNext - Complete Reinstall Script
# اسکریپت کامل برای نصب مجدد و حل مشکلات کانفلیکت

echo "🚀 Persian Date ERPNext - Complete Reinstall & Conflict Fix"
echo "=========================================================="

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check requirements
check_requirements() {
    echo -e "${BLUE}📋 Checking requirements...${NC}"
    
    if [ ! -d "apps" ] || [ ! -d "sites" ]; then
        echo -e "${RED}❌ Error: Please run this script from your bench directory${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Requirements check passed${NC}"
}

# Get site name
get_site_name() {
    if [ -z "$1" ]; then
        echo "Available sites:"
        ls sites/*/site_config.json | sed 's/sites\///g' | sed 's/\/site_config.json//g'
        echo ""
        read -p "Enter your site name: " SITE_NAME
    else
        SITE_NAME=$1
    fi
    
    if [ ! -f "sites/$SITE_NAME/site_config.json" ]; then
        echo -e "${RED}❌ Error: Site '$SITE_NAME' not found${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Using site: $SITE_NAME${NC}"
}

# Complete uninstall
complete_uninstall() {
    echo -e "${YELLOW}🗑️ Removing existing installation...${NC}"
    
    # Uninstall app if exists
    if [ -d "apps/persiandateerpnext" ]; then
        bench --site $SITE_NAME uninstall-app persiandateerpnext --yes || true
        bench remove-app persiandateerpnext || true
        echo -e "${GREEN}✅ App uninstalled${NC}"
    fi
    
    # Clean assets
    rm -rf sites/assets/persiandateerpnext/ || true
    echo -e "${GREEN}✅ Assets cleaned${NC}"
}

# Fresh installation
fresh_install() {
    echo -e "${BLUE}📦 Installing fresh copy...${NC}"
    
    # Get app
    bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
    
    # Install app
    bench --site $SITE_NAME install-app persiandateerpnext
    
    # Run migrations
    bench --site $SITE_NAME migrate
    
    echo -e "${GREEN}✅ Fresh installation completed${NC}"
}

# Fix assets and conflicts
fix_assets_and_conflicts() {
    echo -e "${BLUE}🔧 Fixing assets and conflicts...${NC}"
    
    # Create assets directories
    mkdir -p sites/assets/persiandateerpnext/css/
    mkdir -p sites/assets/persiandateerpnext/js/
    
    # Copy assets
    cp apps/persiandateerpnext/persiandateerpnext/public/css/*.css sites/assets/persiandateerpnext/css/
    cp apps/persiandateerpnext/persiandateerpnext/public/js/*.js sites/assets/persiandateerpnext/js/
    
    # Remove deleted files
    find sites/assets/persiandateerpnext/ -name "*.deleted" -delete
    
    # Create bundles manually
    echo -e "${YELLOW}📦 Creating bundles...${NC}"
    
    # CSS Bundle
    cat sites/assets/persiandateerpnext/css/persian-datepicker.min.css \
        sites/assets/persiandateerpnext/css/custom.css \
        > sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css
    
    # JS Bundle
    cat sites/assets/persiandateerpnext/js/conflict_resolver.js \
        sites/assets/persiandateerpnext/js/debug_check.js \
        sites/assets/persiandateerpnext/js/persian-date.min.js \
        sites/assets/persiandateerpnext/js/persian-datepicker.min.js \
        sites/assets/persiandateerpnext/js/togregorian_date.js \
        sites/assets/persiandateerpnext/js/topersian_date.js \
        sites/assets/persiandateerpnext/js/in_words_cleanup.js \
        > sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js
    
    echo -e "${GREEN}✅ Bundles created${NC}"
}

# Build and restart
build_and_restart() {
    echo -e "${BLUE}🏗️ Building and restarting...${NC}"
    
    # Force build
    bench build --app persiandateerpnext --force
    
    # Clear cache
    bench --site $SITE_NAME clear-cache
    
    # Restart
    bench restart
    
    echo -e "${GREEN}✅ Build and restart completed${NC}"
}

# Verify installation
verify_installation() {
    echo -e "${BLUE}🔍 Verifying installation...${NC}"
    
    # Check bundle files
    if [ -f "sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css" ]; then
        echo -e "${GREEN}✅ CSS bundle exists${NC}"
    else
        echo -e "${RED}❌ CSS bundle missing${NC}"
    fi
    
    if [ -f "sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js" ]; then
        echo -e "${GREEN}✅ JS bundle exists${NC}"
    else
        echo -e "${RED}❌ JS bundle missing${NC}"
    fi
    
    # List all assets
    echo ""
    echo "📄 Available CSS files:"
    ls -la sites/assets/persiandateerpnext/css/ 2>/dev/null || echo "No CSS files found"
    
    echo ""
    echo "📄 Available JS files:"
    ls -la sites/assets/persiandateerpnext/js/ 2>/dev/null || echo "No JS files found"
}

# Main execution
main() {
    echo -e "${BLUE}Starting complete reinstall process...${NC}"
    
    check_requirements
    get_site_name $1
    
    # Ask for confirmation
    echo ""
    echo -e "${YELLOW}⚠️ This will completely remove and reinstall Persian Date ERPNext${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 1
    fi
    
    complete_uninstall
    fresh_install
    fix_assets_and_conflicts
    build_and_restart
    verify_installation
    
    echo ""
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Go to Settings → System Settings"
    echo "2. Enable 'Shamsi (Jalali) Calendar'"
    echo "3. Set Date Storage Format to 'Gregorian'"
    echo "4. Save and refresh browser (Ctrl+F5)"
    echo ""
    echo "If you still have issues:"
    echo "1. Check browser console (F12) for errors"
    echo "2. Verify assets are loading correctly"
    echo "3. Try hard refresh (Ctrl+Shift+R)"
}

# Run main function with all arguments
main "$@"
