#!/bin/bash

# Quick Assets Fix for ERPNext + Persian Date ERPNext
# Run this from your bench directory

echo "⚡ Quick Assets Fix"
echo "=================="

# Check if in bench directory
if [ ! -d "apps" ] || [ ! -d "sites" ]; then
    echo "❌ Run from bench directory!"
    exit 1
fi

echo "📂 Creating directories..."
mkdir -p sites/assets/{frappe,erpnext}/dist/{css,css-rtl,js}
mkdir -p sites/assets/persiandateerpnext/{css,js}

echo "📄 Copying assets..."
cp -r apps/frappe/frappe/public/dist/* sites/assets/frappe/dist/ 2>/dev/null || true
cp -r apps/erpnext/erpnext/public/dist/* sites/assets/erpnext/dist/ 2>/dev/null || true
cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/ 2>/dev/null || true
cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/ 2>/dev/null || true

echo "🔧 Setting permissions..."
chmod -R 755 sites/assets/

echo "🔄 Restarting..."
bench restart

echo "✅ Done! Check your site now."
