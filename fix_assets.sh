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

echo "🏗️ Building assets..."
bench build

echo "🧹 Clearing cache..."
bench --site all clear-cache

echo "🔄 Restarting bench..."
bench restart

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
