#!/usr/bin/env python3
"""
Smart Assets Fix - Detects actual file names and copies them correctly
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path
import re

def log(message, level="INFO"):
    """Simple logging function"""
    icons = {"INFO": "ℹ️", "SUCCESS": "✅", "ERROR": "❌", "WARNING": "⚠️"}
    print(f"{icons.get(level, 'ℹ️')} {message}")

def run_command(command, ignore_errors=True):
    """Run shell command safely"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        if result.returncode != 0 and not ignore_errors:
            log(f"Command failed: {command}", "ERROR")
            log(f"Error: {result.stderr}", "ERROR")
            return False
        return True
    except Exception as e:
        if not ignore_errors:
            log(f"Exception running command: {e}", "ERROR")
        return False

def get_bundle_files(directory):
    """Get all bundle files with their actual names"""
    bundle_files = {}
    
    if not os.path.exists(directory):
        return bundle_files
    
    for file in os.listdir(directory):
        if file.endswith('.css') or file.endswith('.js'):
            # Extract base name (before .bundle.)
            match = re.match(r'(.+?)\.bundle\.([A-Z0-9]{8,})\.(.+)', file)
            if match:
                base_name = match.group(1)
                hash_part = match.group(2)
                extension = match.group(3)
                
                bundle_files[f"{base_name}.bundle.{extension}"] = {
                    'actual_name': file,
                    'base_name': base_name,
                    'hash': hash_part,
                    'extension': extension
                }
            else:
                # Non-bundle files
                bundle_files[file] = {
                    'actual_name': file,
                    'base_name': file.split('.')[0],
                    'hash': '',
                    'extension': file.split('.')[-1]
                }
    
    return bundle_files

def force_copy_with_structure(src_dir, dst_dir):
    """Force copy maintaining directory structure"""
    if not os.path.exists(src_dir):
        log(f"Source directory not found: {src_dir}", "WARNING")
        return False
    
    try:
        if os.path.exists(dst_dir):
            shutil.rmtree(dst_dir)
        
        shutil.copytree(src_dir, dst_dir)
        return True
    except Exception as e:
        log(f"Error copying {src_dir} to {dst_dir}: {e}", "ERROR")
        return False

def main():
    """Main function"""
    log("🔧 Smart Assets Fix - Hash Detection & Copy", "INFO")
    log("=" * 50, "INFO")
    
    # Check if we're in bench directory
    if not (os.path.exists("apps") and os.path.exists("sites")):
        log("Please run this script from your bench directory", "ERROR")
        sys.exit(1)
    
    # Stop services
    log("🛑 Stopping services...", "INFO")
    run_command("bench stop")
    
    # Clean old assets
    log("🧹 Cleaning old assets...", "INFO")
    for app in ['frappe', 'erpnext']:
        old_dist = f"sites/assets/{app}/dist"
        if os.path.exists(old_dist):
            shutil.rmtree(old_dist)
    
    if os.path.exists("sites/assets/persiandateerpnext"):
        shutil.rmtree("sites/assets/persiandateerpnext")
    
    # Force rebuild
    log("🔨 Force rebuilding assets...", "INFO")
    run_command("bench build --force")
    
    # Copy assets with structure
    log("📄 Copying assets with full structure...", "INFO")
    
    success_count = 0
    
    # Copy Frappe
    frappe_src = "apps/frappe/frappe/public/dist"
    frappe_dst = "sites/assets/frappe/dist"
    if force_copy_with_structure(frappe_src, frappe_dst):
        success_count += 1
        log("Frappe assets copied successfully", "SUCCESS")
        
        # Show actual files
        css_files = get_bundle_files(f"{frappe_dst}/css")
        log(f"Frappe CSS files found: {len(css_files)}", "INFO")
        for i, (key, info) in enumerate(list(css_files.items())[:3]):
            log(f"  📄 {info['actual_name']}", "INFO")
    else:
        log("Failed to copy Frappe assets", "ERROR")
    
    # Copy ERPNext
    erpnext_src = "apps/erpnext/erpnext/public/dist"
    erpnext_dst = "sites/assets/erpnext/dist"
    if force_copy_with_structure(erpnext_src, erpnext_dst):
        success_count += 1
        log("ERPNext assets copied successfully", "SUCCESS")
        
        # Show actual files
        css_files = get_bundle_files(f"{erpnext_dst}/css")
        log(f"ERPNext CSS files found: {len(css_files)}", "INFO")
        for i, (key, info) in enumerate(list(css_files.items())[:3]):
            log(f"  📄 {info['actual_name']}", "INFO")
    else:
        log("Failed to copy ERPNext assets", "ERROR")
    
    # Copy Persian Date ERPNext
    persian_src = "apps/persiandateerpnext/persiandateerpnext/public"
    persian_dst = "sites/assets/persiandateerpnext"
    if os.path.exists(persian_src):
        if force_copy_with_structure(persian_src, persian_dst):
            success_count += 1
            log("Persian Date ERPNext assets copied successfully", "SUCCESS")
        else:
            log("Failed to copy Persian Date ERPNext assets", "ERROR")
    else:
        log("Persian Date ERPNext source not found", "WARNING")
    
    # Set permissions
    log("🔧 Setting permissions...", "INFO")
    run_command("chmod -R 755 sites/assets/")
    
    # Clear caches
    log("🧹 Clearing caches...", "INFO")
    run_command("bench --site all clear-cache")
    run_command("bench --site all clear-website-cache")
    
    # Analyze copied files
    log("📊 Assets Analysis:", "INFO")
    
    # Check for specific bundle files that were causing 404
    problematic_bundles = [
        ("frappe", "css", "desk.bundle"),
        ("frappe", "css", "report.bundle"), 
        ("erpnext", "css", "erpnext.bundle")
    ]
    
    for app, asset_type, bundle_name in problematic_bundles:
        bundle_dir = f"sites/assets/{app}/dist/{asset_type}"
        if os.path.exists(bundle_dir):
            bundle_files = get_bundle_files(bundle_dir)
            matching = [info for key, info in bundle_files.items() if bundle_name in key]
            if matching:
                log(f"✅ Found {app} {bundle_name}: {matching[0]['actual_name']}", "SUCCESS")
            else:
                log(f"❌ Missing {app} {bundle_name}", "ERROR")
        else:
            log(f"❌ Directory missing: {bundle_dir}", "ERROR")
    
    # Start services
    log("🔄 Starting services...", "INFO")
    run_command("bench start &")
    
    # Final summary
    log("", "INFO")
    log("🎉 Smart Assets Fix completed!", "SUCCESS")
    log(f"Successfully copied {success_count}/3 apps", "INFO")
    log("", "INFO")
    log("Next steps:", "INFO")
    log("1. Wait 30 seconds for services to start", "INFO")
    log("2. Open ERPNext in browser", "INFO")
    log("3. Check Console (F12) for 404 errors", "INFO")
    log("4. Enable Shamsi Calendar in System Settings", "INFO")
    log("5. Refresh browser (Ctrl+F5)", "INFO")

if __name__ == "__main__":
    main()
