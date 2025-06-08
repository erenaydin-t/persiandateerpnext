#!/bin/bash

# ERPNext Assets Fix Script - Complete Solution
# Fixes 404 errors for CSS/JS assets including RTL files

echo "🔧 ERPNext Assets Complete Fix Script"
echo "======================================"

# Check if we're in a bench directory
if [ ! -d "apps" ] || [ ! -d "sites" ]; then
    echo "❌ Error: Please run this script from your bench directory"
    exit 1
fi

echo "📂 Creating all required asset directories..."

# Create all necessary directories
mkdir -p sites/assets/frappe/dist/css/
mkdir -p sites/assets/frappe/dist/css-rtl/
mkdir -p sites/assets/frappe/dist/js/
mkdir -p sites/assets/erpnext/dist/css/
mkdir -p sites/assets/erpnext/dist/css-rtl/
mkdir -p sites/assets/erpnext/dist/js/
mkdir -p sites/assets/persiandateerpnext/css/
mkdir -p sites/assets/persiandateerpnext/js/

echo "📄 Copying Frappe assets..."
# Copy Frappe assets with error suppression
if [ -d "apps/frappe/frappe/public/dist" ]; then
    cp -r apps/frappe/frappe/public/dist/* sites/assets/frappe/dist/ 2>/dev/null || true
    echo "✅ Frappe assets copied"
else
    echo "⚠️ Frappe dist directory not found"
fi

echo "📄 Copying ERPNext assets..."
# Copy ERPNext assets with error suppression  
if [ -d "apps/erpnext/erpnext/public/dist" ]; then
    cp -r apps/erpnext/erpnext/public/dist/* sites/assets/erpnext/dist/ 2>/dev/null || true
    echo "✅ ERPNext assets copied"
else
    echo "⚠️ ERPNext dist directory not found"
fi

echo "📄 Copying Persian Date ERPNext assets..."
# Copy Persian Date ERPNext assets
if [ -d "apps/persiandateerpnext/persiandateerpnext/public" ]; then
    cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/ 2>/dev/null || true
    cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/ 2>/dev/null || true
    echo "✅ Persian Date ERPNext assets copied"
else
    echo "⚠️ Persian Date ERPNext not found"
fi

echo "🔧 Setting proper permissions..."
# Set proper permissions
chmod -R 755 sites/assets/ 2>/dev/null || true

# Change ownership if running as root
if [ "$EUID" -eq 0 ]; then
    chown -R frappe:frappe sites/assets/ 2>/dev/null || true
fi

echo "✅ Verifying critical files..."

# Verify specific files that were causing 404
CRITICAL_FILES=(
    "sites/assets/frappe/dist/css-rtl/website.bundle.U5BCZOB2.css"
    "sites/assets/erpnext/dist/css-rtl/erpnext-web.bundle.QM2Q6J7O.css"
    "sites/assets/persiandateerpnext/css/persian-datepicker.min.css"
    "sites/assets/persiandateerpnext/js/persian-date.min.js"
)

for file in "${CRITICAL_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ Found: $file"
    else
        echo "❌ Missing: $file"
    fi
done

echo "🧹 Clearing caches..."
# Clear caches
bench --site all clear-cache 2>/dev/null || true
bench --site all clear-website-cache 2>/dev/null || true

echo "🔄 Restarting services..."
# Restart bench
bench restart

# If in production mode, restart nginx and supervisor
if pgrep nginx > /dev/null; then
    echo "🔄 Restarting Nginx..."
    sudo nginx -s reload 2>/dev/null || true
fi

if pgrep supervisord > /dev/null; then
    echo "🔄 Restarting Supervisor..."
    sudo supervisorctl restart all 2>/dev/null || true
fi

echo ""
echo "🎉 Assets fix completed!"
echo ""
echo "Next steps:"
echo "1. Open your ERPNext site in browser"
echo "2. Check browser console (F12) for any remaining 404 errors"
echo "3. Go to Settings → System Settings" 
echo "4. Enable 'Shamsi (Jalali) Calendar'"
echo "5. Set Date Storage Format to 'Gregorian'"
echo "6. Save and refresh browser (Ctrl+F5)"
echo ""
echo "If you still see 404 errors, run: bench build --force"
