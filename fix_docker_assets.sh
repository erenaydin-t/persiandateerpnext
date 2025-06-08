#!/bin/bash
# Persian Date ERPNext - Docker Asset Quick Fix
# حل سریع مشکل 404 asset ها در Docker

echo "🔧 Persian Date ERPNext - Docker Asset Quick Fix"
echo "==============================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# پیدا کردن backend container
BACKEND_CONTAINER=$(docker ps | grep backend | awk '{print $1}')
if [ -z "$BACKEND_CONTAINER" ]; then
    echo -e "${RED}❌ Backend container not found!${NC}"
    echo "Make sure your Docker services are running:"
    echo "docker service ls"
    exit 1
fi

echo -e "${GREEN}✅ Found backend container: $BACKEND_CONTAINER${NC}"

# حل سریع مشکل assets
echo -e "${BLUE}🛠️ Quick fixing assets...${NC}"
docker exec $BACKEND_CONTAINER bash -c "
set -e
cd /home/frappe/frappe-bench

echo '📂 Creating assets directories...'
mkdir -p sites/assets/persiandateerpnext/css/
mkdir -p sites/assets/persiandateerpnext/js/

echo '📄 Copying assets...'
if [ -d 'apps/persiandateerpnext/persiandateerpnext/public/css' ]; then
    cp apps/persiandateerpnext/persiandateerpnext/public/css/*.css sites/assets/persiandateerpnext/css/
    echo '✅ CSS files copied'
fi

if [ -d 'apps/persiandateerpnext/persiandateerpnext/public/js' ]; then
    cp apps/persiandateerpnext/persiandateerpnext/public/js/*.js sites/assets/persiandateerpnext/js/
    echo '✅ JS files copied'
fi

echo '📦 Creating bundles...'
cat sites/assets/persiandateerpnext/css/*.css > sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css 2>/dev/null || echo 'CSS bundle creation failed'
cat sites/assets/persiandateerpnext/js/*.js > sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js 2>/dev/null || echo 'JS bundle creation failed'

echo '🧹 Clearing cache...'
bench --site frontend clear-cache

echo '✅ Quick fix completed'
"

# Restart frontend service
echo -e "${BLUE}🔄 Restarting frontend service...${NC}"
docker service update --force pwd_frontend

echo -e "${GREEN}🎉 Quick fix completed!${NC}"
echo ""
echo "✅ Next steps:"
echo "1. Wait 10-15 seconds for service restart"
echo "2. Refresh your browser (Ctrl+F5)"
echo "3. Check if 404 errors are gone"
echo ""
echo "🔍 Verify assets:"
echo "docker exec $BACKEND_CONTAINER ls -la /home/frappe/frappe-bench/sites/assets/persiandateerpnext/"
