#!/usr/bin/env python3
"""
ERPNext Assets Fix Script - Python Version
Fixes 404 errors for CSS/JS assets including RTL files
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path

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

def copy_directory_contents(src, dst, ignore_errors=True):
    """Copy directory contents safely"""
    try:
        if not os.path.exists(src):
            log(f"Source directory not found: {src}", "WARNING")
            return False
            
        os.makedirs(dst, exist_ok=True)
        
        for item in os.listdir(src):
            src_path = os.path.join(src, item)
            dst_path = os.path.join(dst, item)
            
            try:
                if os.path.isdir(src_path):
                    shutil.copytree(src_path, dst_path, dirs_exist_ok=True)
                else:
                    shutil.copy2(src_path, dst_path)
            except Exception as e:
                if not ignore_errors:
                    log(f"Error copying {src_path}: {e}", "ERROR")
                continue
                
        return True
    except Exception as e:
        if not ignore_errors:
            log(f"Error copying directory {src} to {dst}: {e}", "ERROR")
        return False

def main():
    """Main function"""
    log("🔧 ERPNext Assets Complete Fix Script (Python)", "INFO")
    log("=" * 50, "INFO")
    
    # Check if we're in bench directory
    if not (os.path.exists("apps") and os.path.exists("sites")):
        log("Please run this script from your bench directory", "ERROR")
        sys.exit(1)
    
    # Create all necessary directories
    log("📂 Creating asset directories...", "INFO")
    directories = [
        "sites/assets/frappe/dist/css",
        "sites/assets/frappe/dist/css-rtl", 
        "sites/assets/frappe/dist/js",
        "sites/assets/erpnext/dist/css",
        "sites/assets/erpnext/dist/css-rtl",
        "sites/assets/erpnext/dist/js",
        "sites/assets/persiandateerpnext/css",
        "sites/assets/persiandateerpnext/js"
    ]
    
    for directory in directories:
        os.makedirs(directory, exist_ok=True)
    
    # Copy Frappe assets
    log("📄 Copying Frappe assets...", "INFO")
    if copy_directory_contents("apps/frappe/frappe/public/dist", "sites/assets/frappe/dist"):
        log("Frappe assets copied successfully", "SUCCESS")
    else:
        log("Some Frappe assets may not have copied", "WARNING")
    
    # Copy ERPNext assets  
    log("📄 Copying ERPNext assets...", "INFO")
    if copy_directory_contents("apps/erpnext/erpnext/public/dist", "sites/assets/erpnext/dist"):
        log("ERPNext assets copied successfully", "SUCCESS")
    else:
        log("Some ERPNext assets may not have copied", "WARNING")
    
    # Copy Persian Date ERPNext assets
    log("📄 Copying Persian Date ERPNext assets...", "INFO")
    persiandateerpnext_copied = False
    
    if os.path.exists("apps/persiandateerpnext/persiandateerpnext/public/css"):
        if copy_directory_contents("apps/persiandateerpnext/persiandateerpnext/public/css", "sites/assets/persiandateerpnext/css"):
            persiandateerpnext_copied = True
    
    if os.path.exists("apps/persiandateerpnext/persiandateerpnext/public/js"):
        if copy_directory_contents("apps/persiandateerpnext/persiandateerpnext/public/js", "sites/assets/persiandateerpnext/js"):
            persiandateerpnext_copied = True
    
    if persiandateerpnext_copied:
        log("Persian Date ERPNext assets copied successfully", "SUCCESS")
    else:
        log("Persian Date ERPNext not found or not copied", "WARNING")
    
    # Set permissions
    log("🔧 Setting permissions...", "INFO")
    run_command("chmod -R 755 sites/assets/")
    
    # Check ownership and fix if running as root
    if os.geteuid() == 0:
        run_command("chown -R frappe:frappe sites/assets/")
    
    # Verify critical files
    log("✅ Verifying critical files...", "INFO")
    critical_files = [
        "sites/assets/frappe/dist/css-rtl/website.bundle.U5BCZOB2.css",
        "sites/assets/erpnext/dist/css-rtl/erpnext-web.bundle.QM2Q6J7O.css", 
        "sites/assets/persiandateerpnext/css/persian-datepicker.min.css",
        "sites/assets/persiandateerpnext/js/persian-date.min.js"
    ]
    
    found_files = 0
    for file_path in critical_files:
        if os.path.exists(file_path):
            log(f"Found: {file_path}", "SUCCESS")
            found_files += 1
        else:
            # Try to find similar files with different hashes
            file_dir = os.path.dirname(file_path)
            file_name = os.path.basename(file_path)
            
            if "bundle." in file_name:
                base_name = file_name.split(".bundle.")[0]
                extension = file_name.split(".")[-1]
                
                if os.path.exists(file_dir):
                    similar_files = [f for f in os.listdir(file_dir) 
                                   if f.startswith(base_name) and f.endswith(f".{extension}")]
                    if similar_files:
                        log(f"Found similar: {os.path.join(file_dir, similar_files[0])}", "SUCCESS")
                        found_files += 1
                        continue
            
            log(f"Missing: {file_path}", "WARNING")
    
    log(f"Found {found_files}/{len(critical_files)} critical files", "INFO")
    
    # Clear caches
    log("🧹 Clearing caches...", "INFO")
    run_command("bench --site all clear-cache")
    run_command("bench --site all clear-website-cache")
    
    # Restart services
    log("🔄 Restarting services...", "INFO")
    run_command("bench restart")
    
    # Check for production services
    if run_command("pgrep nginx", ignore_errors=True):
        log("🔄 Restarting Nginx...", "INFO")
        run_command("sudo nginx -s reload")
    
    if run_command("pgrep supervisord", ignore_errors=True):
        log("🔄 Restarting Supervisor...", "INFO")
        run_command("sudo supervisorctl restart all")
    
    # Final instructions
    log("", "INFO")
    log("🎉 Assets fix completed!", "SUCCESS")
    log("", "INFO")
    log("Next steps:", "INFO")
    log("1. Open your ERPNext site in browser", "INFO")
    log("2. Check browser console (F12) for any remaining 404 errors", "INFO")
    log("3. Go to Settings → System Settings", "INFO")
    log("4. Enable 'Shamsi (Jalali) Calendar'", "INFO")
    log("5. Set Date Storage Format to 'Gregorian'", "INFO")
    log("6. Save and refresh browser (Ctrl+F5)", "INFO")
    log("", "INFO")
    log("If you still see 404 errors, run: bench build --force", "INFO")

if __name__ == "__main__":
    main()
