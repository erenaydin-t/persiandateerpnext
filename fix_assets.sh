#!/bin/bash

# Persian Date ERPNext - Manual Assets Fix Script
# Use this script if assets are not loading automatically

echo "🔧 Persian Date ERPNext - Manual Assets Fix"
echo "=========================================="

# Check if we're in a bench directory
if [ ! -d "apps" ] || [ ! -d "sites" ]; then
    echo "❌ Error: Please run this script from your bench directory"
    exit 1
fi

# Check if app exists
if [ ! -d "apps/persiandateerpnext" ]; then
    echo "❌ Error: persiandateerpnext app not found in apps directory"
    echo "Please install the app first: bench get-app https://github.com/erenaydin-t/persiandateerpnext.git"
    exit 1
fi

echo "📂 Creating assets directories..."
mkdir -p sites/assets/persiandateerpnext/css/
mkdir -p sites/assets/persiandateerpnext/js/

echo "📄 Copying CSS files..."
cp apps/persiandateerpnext/persiandateerpnext/public/css/*.css sites/assets/persiandateerpnext/css/

echo "📄 Copying JS files..."
cp apps/persiandateerpnext/persiandateerpnext/public/js/*.js sites/assets/persiandateerpnext/js/

# Remove any .deleted files
find sites/assets/persiandateerpnext/ -name "*.deleted" -delete

echo "✅ Verifying copied files:"
echo "CSS files:"
ls -la sites/assets/persiandateerpnext/css/

echo "JS files:" 
ls -la sites/assets/persiandateerpnext/js/

echo "🏗️ Building assets with force..."
bench build --app persiandateerpnext --force

echo "🧹 Clearing cache..."
bench --site all clear-cache

echo "🔄 Restarting bench..."
bench restart

echo "🔍 Verifying bundle files..."
if [ -f "sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css" ]; then
    echo "✅ CSS bundle created successfully"
else
    echo "❌ CSS bundle missing - trying individual files..."
    # Fallback: copy individual files with bundle-compatible names
    cp apps/persiandateerpnext/persiandateerpnext/public/css/*.css sites/assets/persiandateerpnext/css/
    cat sites/assets/persiandateerpnext/css/persian-datepicker.min.css sites/assets/persiandateerpnext/css/custom.css > sites/assets/persiandateerpnext/css/persiandateerpnext.bundle.css
fi

if [ -f "sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js" ]; then
    echo "✅ JS bundle created successfully"
else
    echo "❌ JS bundle missing - trying individual files..."
    # Fallback: copy and concatenate individual files
    cp apps/persiandateerpnext/persiandateerpnext/public/js/*.js sites/assets/persiandateerpnext/js/
    cat sites/assets/persiandateerpnext/js/conflict_resolver.js sites/assets/persiandateerpnext/js/debug_check.js sites/assets/persiandateerpnext/js/persian-date.min.js sites/assets/persiandateerpnext/js/persian-datepicker.min.js sites/assets/persiandateerpnext/js/togregorian_date.js sites/assets/persiandateerpnext/js/topersian_date.js sites/assets/persiandateerpnext/js/in_words_cleanup.js > sites/assets/persiandateerpnext/js/persiandateerpnext.bundle.js
fi

echo ""
echo "✅ Manual assets fix completed!"
echo ""
echo "Next steps:"
echo "1. Go to Settings → System Settings"
echo "2. Enable 'Shamsi (Jalali) Calendar'"
echo "3. Set Date Storage Format to 'Gregorian'"
echo "4. Save and refresh browser (Ctrl+F5)"
echo ""
echo "If you still have issues, check browser console for errors."
