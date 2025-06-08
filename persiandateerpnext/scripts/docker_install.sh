#!/bin/bash
# Docker installation script for Persian Date ERPNext
# اسکریپت نصب Docker برای Persian Date ERPNext

set -e

echo "🐳 Persian Date ERPNext - Docker Installation Script"
echo "==================================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to find backend container
find_backend_container() {
    BACKEND_CONTAINER=$(docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | grep -E "(backend|erpnext)" | head -1 | awk '{print $1}')
    if [ -z "$BACKEND_CONTAINER" ]; then
        echo -e "${RED}❌ Backend container not found!${NC}"
        echo "Available containers:"
        docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}"
        echo ""
        echo "Make sure your ERPNext Docker services are running."
        exit 1
    fi
    echo -e "${GREEN}✅ Found backend container: $BACKEND_CONTAINER${NC}"
}

# Function to get site name
get_site_name() {
    echo -e "${BLUE}🔍 Finding site name...${NC}"
    SITE_NAME=$(docker exec $BACKEND_CONTAINER bash -c "cd /home/frappe/frappe-bench && ls sites/ | grep -v assets | grep -v common_site_config.json | grep -v apps.txt | head -1")
    
    if [ -z "$SITE_NAME" ]; then
        echo -e "${YELLOW}⚠️ Auto-detection failed. Common site names:${NC}"
        echo "- frontend"
        echo "- localhost"
        echo "- your-domain.com"
        read -p "Enter your site name: " SITE_NAME
    fi
    
    echo -e "${GREEN}✅ Using site: $SITE_NAME${NC}"
}

# Function to uninstall existing installation
uninstall_existing() {
    echo -e "${YELLOW}🗑️ Removing existing installation...${NC}"
    docker exec $BACKEND_CONTAINER bash -c "
    cd /home/frappe/frappe-bench
    bench --site $SITE_NAME uninstall-app persiandateerpnext --yes 2>/dev/null || echo 'App not installed'
    bench remove-app persiandateerpnext 2>/dev/null || echo 'App not in apps directory'
    rm -rf apps/persiandateerpnext 2>/dev/null || true
    rm -rf sites/assets/persiandateerpnext 2>/dev/null || true
    echo '✅ Cleanup completed'
    " || true
}

# Function to install app
install_app() {
    echo -e "${BLUE}📦 Installing Persian Date ERPNext...${NC}"
    docker exec $BACKEND_CONTAINER bash -c "
    set -e
    cd /home/frappe/frappe-bench
    
    echo '📥 Getting app from GitHub...'
    bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
    
    echo '⚙️ Installing app on site...'
    bench --site $SITE_NAME install-app persiandateerpnext
    
    echo '🔄 Running migrations...'
    bench --site $SITE_NAME migrate
    
    echo '✅ App installation completed'
    "
}

# Function to fix assets
fix_assets() {
    echo -e "${BLUE}🛠️ Fixing assets...${NC}"
    docker exec $BACKEND_CONTAINER bash -c "
    cd /home/frappe/frappe-bench
    
    echo '📂 Creating assets directories...'
    mkdir -p sites/assets/persiandateerpnext/css/
    mkdir -p sites/assets/persiandateerpnext/js/
    
    echo '📄 Copying CSS files...'
    if [ -d 'apps/persiandateerpnext/persiandateerpnext/public/css' ]; then
        cp apps/persiandateerpnext/persiandateerpnext/public/css/*.css sites/assets/persiandateerpnext/css/
        echo '✅ CSS files copied'
    else
        echo '❌ CSS source directory not found'
        exit 1
    fi
    
    echo '📄 Copying JS files...'
    if [ -d 'apps/persiandateerpnext/persiandateerpnext/public/js' ]; then
        cp apps/persiandateerpnext/persiandateerpnext/public/js/*.js sites/assets/persiandateerpnext/js/
        echo '✅ JS files copied'
    else
        echo '❌ JS source directory not found'
        exit 1
    fi
    
    # Remove .deleted files
    find sites/assets/persiandateerpnext/ -name '*.deleted' -delete 2>/dev/null || true
    
    echo '📦 Creating CSS bundle...'
    cat sites/assets/persiandateerpnext/css/persian-datepicker.min.css sites/assets/persiandateerpnext/css/custom.css > sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css
    
    echo '📦 Creating JS bundle...'
    JS_FILES='conflict_resolver.js debug_check.js persian-date.min.js persian-datepicker.min.js togregorian_date.js topersian_date.js in_words_cleanup.js'
    > sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js
    for file in \$JS_FILES; do
        if [ -f \"sites/assets/persiandateerpnext/js/\$file\" ]; then
            cat \"sites/assets/persiandateerpnext/js/\$file\" >> sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js
            echo ';' >> sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js
        fi
    done
    
    echo '🏗️ Building assets...'
    bench build --app persiandateerpnext --hard-link
    
    echo '🧹 Clearing cache...'
    bench --site $SITE_NAME clear-cache
    
    echo '✅ Assets fix completed'
    "
}

# Function to restart services
restart_services() {
    echo -e "${BLUE}🔄 Restarting Docker services...${NC}"
    
    # Get service names (handle different naming patterns)
    SERVICES=$(docker service ls --format "{{.Name}}" | grep -E "(backend|frontend|websocket)" || docker stack ls --format "{{.Name}}" | head -1)
    
    if [ -z "$SERVICES" ]; then
        echo -e "${YELLOW}⚠️ Could not auto-detect services. Manual restart needed.${NC}"
        echo "Run these commands manually:"
        echo "docker service update --force YOUR_PREFIX_backend"
        echo "docker service update --force YOUR_PREFIX_frontend"
        return
    fi
    
    # Try common service name patterns
    docker service update --force pwd_backend 2>/dev/null || docker service update --force backend 2>/dev/null || echo "Backend service not found"
    sleep 10
    docker service update --force pwd_frontend 2>/dev/null || docker service update --force frontend 2>/dev/null || echo "Frontend service not found" 
    sleep 5
    docker service update --force pwd_websocket 2>/dev/null || docker service update --force websocket 2>/dev/null || echo "Websocket service not found"
    
    echo -e "${GREEN}✅ Services restart completed${NC}"
}

# Function to verify installation
verify_installation() {
    echo -e "${BLUE}🔍 Verifying installation...${NC}"
    
    # Check if app is in list
    APP_CHECK=$(docker exec $BACKEND_CONTAINER bench --site $SITE_NAME list-apps | grep persian || echo "not found")
    if [ "$APP_CHECK" != "not found" ]; then
        echo -e "${GREEN}✅ App found in app list${NC}"
    else
        echo -e "${RED}❌ App not found in app list${NC}"
    fi
    
    # Check assets
    CSS_BUNDLE=$(docker exec $BACKEND_CONTAINER ls -la /home/frappe/frappe-bench/sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css 2>/dev/null && echo "exists" || echo "missing")
    JS_BUNDLE=$(docker exec $BACKEND_CONTAINER ls -la /home/frappe/frappe-bench/sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js 2>/dev/null && echo "exists" || echo "missing")
    
    if [ "$CSS_BUNDLE" == "exists" ]; then
        echo -e "${GREEN}✅ CSS bundle exists${NC}"
    else
        echo -e "${RED}❌ CSS bundle missing${NC}"
    fi
    
    if [ "$JS_BUNDLE" == "exists" ]; then
        echo -e "${GREEN}✅ JS bundle exists${NC}"
    else
        echo -e "${RED}❌ JS bundle missing${NC}"
    fi
}

# Main execution
main() {
    echo -e "${BLUE}Starting installation process...${NC}"
    
    # Check if Docker is running
    docker ps >/dev/null 2>&1 || {
        echo -e "${RED}❌ Docker is not running or accessible${NC}"
        exit 1
    }
    
    find_backend_container
    get_site_name
    
    # Confirm with user
    echo ""
    echo -e "${YELLOW}⚠️ This will install/reinstall Persian Date ERPNext${NC}"
    echo "Container: $BACKEND_CONTAINER"
    echo "Site: $SITE_NAME"
    read -p "Continue? (y/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 1
    fi
    
    uninstall_existing
    install_app
    fix_assets
    restart_services
    verify_installation
    
    echo ""
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Wait 30 seconds for services to fully restart"
    echo "2. Open your ERPNext site in browser"
    echo "3. Go to Settings → System Settings"
    echo "4. Enable 'Shamsi (Jalali) Calendar'"
    echo "5. Set 'Date Storage Format' to 'Gregorian'"
    echo "6. Save and refresh browser (Ctrl+F5)"
    echo ""
    echo -e "${BLUE}Troubleshooting:${NC}"
    echo "- Check browser console (F12) for errors"
    echo "- Verify assets: docker exec $BACKEND_CONTAINER ls -la /home/frappe/frappe-bench/sites/assets/persiandateerpnext/"
    echo "- Manual asset test: curl -I http://localhost:8080/assets/persiandateerpnext/css/persiandateerpnext.bundle.css"
}

# Run main function
main "$@"
