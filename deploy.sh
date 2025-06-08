#!/bin/bash
# Quick deployment script for Persian Date ERPNext fixes

echo "🚀 Deploying Persian Date ERPNext v1.0.8 fixes..."

# Stage all changes
git add .

# Commit with descriptive message
git commit -m "v1.0.8: Complete Docker support & conflict resolution

✅ Features:
- Docker installation support with automatic detection
- Smart CSS/JS conflict resolution 
- Bundle-based asset loading system
- Z-index management for modals/sidebars
- Enhanced debugging and verification

🔧 Fixes:
- 404 asset errors in Docker environments
- CSS/JS conflicts with ERPNext core
- Asset bundling and loading issues
- Selective override of conflicting datepickers

📦 New Files:
- scripts/docker_install.sh - Complete Docker installation
- fix_docker_assets.sh - Quick asset fix for Docker
- complete_reinstall.sh - Full reinstall script
- conflict_resolver.js - Smart conflict handling

📝 Updated:
- README.md - Complete Docker documentation
- hooks.py - Bundle-based asset loading
- bundle.json - Correct asset paths
- custom.css - Conflict-free styling
- install.py - Enhanced asset management"

# Push to remote
git push origin main

echo "✅ Deployed successfully!"
echo ""
echo "📋 Users can now install with:"
echo "Standard: bench get-app https://github.com/erenaydin-t/persiandateerpnext.git"
echo "Docker: wget -O docker_install.sh https://raw.githubusercontent.com/erenaydin-t/persiandateerpnext/main/scripts/docker_install.sh && ./docker_install.sh"
