#!/bin/bash

# Ultimate Assets Fix for ERPNext - Complete Solution
echo "🔧 Ultimate ERPNext Assets Fix - v1.0.7"
echo "========================================="

# Check if we're in bench directory
if [ ! -d "apps" ] || [ ! -d "sites" ]; then
    echo "❌ Error: Please run this script from your bench directory"
    exit 1
fi

echo "🛑 Stopping all services..."
bench stop 2>/dev/null || true

echo "🧹 Cleaning old assets..."
rm -rf sites/assets/frappe/dist/ 2>/dev/null || true
rm -rf sites/assets/erpnext/dist/ 2>/dev/null || true
rm -rf sites/assets/persiandateerpnext/ 2>/dev/null || true

echo "🔨 Force rebuilding assets..."
bench build --force

echo "📂 Creating directory structure..."
mkdir -p sites/assets/frappe/dist/{css,css-rtl,js}
mkdir -p sites/assets/erpnext/dist/{css,css-rtl,js}
mkdir -p sites/assets/persiandateerpnext/{css,js}

echo "📄 Copying Frappe assets..."
if [ -d "apps/frappe/frappe/public/dist" ]; then
    cp -r apps/frappe/frappe/public/dist/* sites/assets/frappe/dist/ 2>/dev/null || true
    echo "✅ Frappe assets copied"
    
    # List copied files for verification
    echo "📋 Frappe CSS files:"
    find sites/assets/frappe/dist/css/ -name "*.css" -type f | head -5
else
    echo "❌ Frappe dist directory not found"
fi

echo "📄 Copying ERPNext assets..."
if [ -d "apps/erpnext/erpnext/public/dist" ]; then
    cp -r apps/erpnext/erpnext/public/dist/* sites/assets/erpnext/dist/ 2>/dev/null || true
    echo "✅ ERPNext assets copied"
    
    # List copied files for verification
    echo "📋 ERPNext CSS files:"
    find sites/assets/erpnext/dist/css/ -name "*.css" -type f | head -5
else
    echo "❌ ERPNext dist directory not found"
fi

echo "📄 Copying Persian Date ERPNext assets..."
if [ -d "apps/persiandateerpnext/persiandateerpnext/public" ]; then
    cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/ 2>/dev/null || true
    cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/ 2>/dev/null || true
    echo "✅ Persian Date ERPNext assets copied"
else
    echo "❌ Persian Date ERPNext not found"
fi

echo "🔧 Setting permissions..."
chmod -R 755 sites/assets/

# Change ownership if running as root
if [ "$EUID" -eq 0 ]; then
    chown -R frappe:frappe sites/assets/ 2>/dev/null || true
fi

echo "✅ Verifying assets..."

# Check critical ERPNext CSS files
echo "🔍 Checking ERPNext CSS files..."
ERPNEXT_CSS_COUNT=$(find sites/assets/erpnext/dist/css/ -name "*.css" -type f | wc -l)
echo "📊 Found $ERPNEXT_CSS_COUNT ERPNext CSS files"

if [ $ERPNEXT_CSS_COUNT -gt 0 ]; then
    echo "✅ ERPNext CSS files available:"
    find sites/assets/erpnext/dist/css/ -name "*.css" -type f | head -3
else
    echo "❌ No ERPNext CSS files found!"
fi

# Check critical Frappe CSS files  
echo "🔍 Checking Frappe CSS files..."
FRAPPE_CSS_COUNT=$(find sites/assets/frappe/dist/css/ -name "*.css" -type f | wc -l)
echo "📊 Found $FRAPPE_CSS_COUNT Frappe CSS files"

if [ $FRAPPE_CSS_COUNT -gt 0 ]; then
    echo "✅ Frappe CSS files available:"
    find sites/assets/frappe/dist/css/ -name "*.css" -type f | head -3
else
    echo "❌ No Frappe CSS files found!"
fi

# Check Persian Date ERPNext files
echo "🔍 Checking Persian Date ERPNext files..."
PERSIAN_CSS_COUNT=$(find sites/assets/persiandateerpnext/css/ -name "*.css" -type f 2>/dev/null | wc -l)
PERSIAN_JS_COUNT=$(find sites/assets/persiandateerpnext/js/ -name "*.js" -type f 2>/dev/null | wc -l)

echo "📊 Found $PERSIAN_CSS_COUNT CSS and $PERSIAN_JS_COUNT JS Persian files"

echo "🧹 Clearing caches..."
bench --site all clear-cache 2>/dev/null || true
bench --site all clear-website-cache 2>/dev/null || true

echo "🔄 Starting services..."
bench start &

# Wait a moment for services to start
sleep 3

echo ""
echo "🎉 Ultimate Assets Fix completed!"
echo ""
echo "📋 Summary:"
echo "- Frappe CSS files: $FRAPPE_CSS_COUNT"
echo "- ERPNext CSS files: $ERPNEXT_CSS_COUNT" 
echo "- Persian CSS files: $PERSIAN_CSS_COUNT"
echo "- Persian JS files: $PERSIAN_JS_COUNT"
echo ""
echo "Next steps:"
echo "1. Wait for services to fully start (30 seconds)"
echo "2. Open your ERPNext site in browser"
echo "3. Check browser console (F12) for any remaining 404 errors"
echo "4. Go to Settings → System Settings" 
echo "5. Enable 'Shamsi (Jalali) Calendar'"
echo "6. Set Date Storage Format to 'Gregorian'"
echo "7. Save and refresh browser (Ctrl+F5)"
echo ""
echo "If you still see 404 errors, the hash names may have changed."
echo "Check the actual file names in sites/assets/ directories."
