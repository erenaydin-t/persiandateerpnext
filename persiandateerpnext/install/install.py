import frappe
import os
import shutil

def after_install():
    """Called after app installation"""
    try:
        # Force copy assets manually
        copy_assets_manually()
        
        # Force rebuild assets
        frappe.clear_cache()
        
        # Create notification for user
        frappe.msgprint(
            msg="""
            <div style='text-align: center; padding: 20px;'>
                <h3>🎉 Persian Date ERPNext Installed Successfully!</h3>
                <p><strong>Assets have been manually copied and verified!</strong></p>
                <p><strong>Next Steps:</strong></p>
                <ol style='text-align: left; max-width: 500px; margin: 0 auto;'>
                    <li>Go to <strong>Settings → System Settings</strong></li>
                    <li>Enable "<strong>Enable Shamsi (Jalali) Calendar</strong>" checkbox</li>
                    <li>Select "<strong>Date Storage Format</strong>" (Gregorian recommended)</li>
                    <li>Save settings and refresh your browser (Ctrl+F5)</li>
                </ol>
                <p style='margin-top: 20px;'>
                    <strong>Need help?</strong> 
                    <a href='https://github.com/erenaydin-t/persiandateerpnext' target='_blank'>
                        Visit Documentation
                    </a>
                </p>
                <hr style='margin: 20px 0;'>
                <p style='color: #666; font-size: 12px;'>
                    Persian Date ERPNext v1.0.5<br>
                    با ❤️ برای جامعه فارسی ERPNext ساخته شده
                </p>
            </div>
            """,
            title="Installation Complete",
            indicator="green"
        )
        
        # Add to activity log
        frappe.get_doc({
            "doctype": "Activity Log",
            "subject": "Persian Date ERPNext installed successfully with manual assets copy",
            "content": "App installed, assets copied manually, and ready for configuration in System Settings",
            "status": "Open",
            "communication_type": "System Generated"
        }).insert(ignore_permissions=True)
        
        print("✅ Persian Date ERPNext installation completed successfully")
        
    except Exception as e:
        frappe.log_error(f"Error in Persian Date ERPNext installation: {str(e)}")
        print(f"❌ Installation error: {str(e)}")

def after_migrate():
    """Called after migration - ensure assets are always available"""
    try:
        copy_assets_manually()
        print("✅ Persian Date ERPNext assets re-copied after migration")
    except Exception as e:
        # Don't fail migration for asset copy issues
        print(f"⚠️ Asset copy info: {str(e)}")
        # Only log critical errors, not file already exists errors
        if "are the same file" not in str(e):
            frappe.log_error(f"Persian Date ERPNext asset copy issue: {str(e)[:100]}...")

def copy_assets_manually():
    """Manually copy assets to ensure they're available"""
    try:
        import frappe.utils
        
        # Get bench path
        bench_path = frappe.utils.get_bench_path()
        
        # Source paths
        app_public_path = os.path.join(bench_path, "apps", "persiandateerpnext", "persiandateerpnext", "public")
        
        # Target paths
        assets_path = os.path.join(bench_path, "sites", "assets", "persiandateerpnext")
        
        # Create target directories
        os.makedirs(os.path.join(assets_path, "css"), exist_ok=True)
        os.makedirs(os.path.join(assets_path, "js"), exist_ok=True)
        
        # Copy CSS files
        css_source = os.path.join(app_public_path, "css")
        css_target = os.path.join(assets_path, "css")
        
        if os.path.exists(css_source):
            for file in os.listdir(css_source):
                if file.endswith(('.css', '.min.css')):
                    src_file = os.path.join(css_source, file)
                    dst_file = os.path.join(css_target, file)
                    
                    # Skip if files are the same (symlink or already copied)
                    try:
                        if os.path.samefile(src_file, dst_file):
                            print(f"📄 CSS already linked: {file}")
                            continue
                    except OSError:
                        # Files don't exist or can't be compared, proceed with copy
                        pass
                        
                    # Skip if destination exists and is newer
                    if os.path.exists(dst_file):
                        src_mtime = os.path.getmtime(src_file)
                        dst_mtime = os.path.getmtime(dst_file)
                        if dst_mtime >= src_mtime:
                            print(f"📄 CSS up to date: {file}")
                            continue
                    
                    shutil.copy2(src_file, dst_file)
                    print(f"📄 Copied CSS: {file}")
        
        # Copy JS files
        js_source = os.path.join(app_public_path, "js")
        js_target = os.path.join(assets_path, "js")
        
        if os.path.exists(js_source):
            for file in os.listdir(js_source):
                if file.endswith(('.js', '.min.js')) and not file.endswith('.deleted'):
                    src_file = os.path.join(js_source, file)
                    dst_file = os.path.join(js_target, file)
                    
                    # Skip if files are the same (symlink or already copied)
                    try:
                        if os.path.samefile(src_file, dst_file):
                            print(f"📄 JS already linked: {file}")
                            continue
                    except OSError:
                        # Files don't exist or can't be compared, proceed with copy
                        pass
                        
                    # Skip if destination exists and is newer
                    if os.path.exists(dst_file):
                        src_mtime = os.path.getmtime(src_file)
                        dst_mtime = os.path.getmtime(dst_file)
                        if dst_mtime >= src_mtime:
                            print(f"📄 JS up to date: {file}")
                            continue
                    
                    shutil.copy2(src_file, dst_file)
                    print(f"📄 Copied JS: {file}")
        
        print("✅ All assets copied manually to sites/assets/persiandateerpnext/")
        
        # Verify copy was successful
        verify_assets_copied(assets_path)
        
    except Exception as e:
        print(f"❌ Manual asset copy failed: {str(e)}")
        raise

def verify_assets_copied(assets_path):
    """Verify that all required assets are present"""
    required_css = ["persian-datepicker.min.css", "custom.css"]
    required_js = ["persian-date.min.js", "persian-datepicker.min.js", "togregorian_date.js", "topersian_date.js", "in_words_cleanup.js", "debug_check.js"]
    
    css_path = os.path.join(assets_path, "css")
    js_path = os.path.join(assets_path, "js")
    
    # Check CSS files
    for css_file in required_css:
        file_path = os.path.join(css_path, css_file)
        if os.path.exists(file_path):
            print(f"✅ CSS verified: {css_file}")
        else:
            print(f"❌ CSS missing: {css_file}")
    
    # Check JS files
    for js_file in required_js:
        file_path = os.path.join(js_path, js_file)
        if os.path.exists(file_path):
            print(f"✅ JS verified: {js_file}")
        else:
            print(f"❌ JS missing: {js_file}")

def before_uninstall():
    """Called before app uninstallation"""
    try:
        # Clean up assets
        import frappe.utils
        bench_path = frappe.utils.get_bench_path()
        assets_path = os.path.join(bench_path, "sites", "assets", "persiandateerpnext")
        
        if os.path.exists(assets_path):
            shutil.rmtree(assets_path)
            print("🧹 Cleaned up Persian Date ERPNext assets")
            
    except Exception as e:
        print(f"⚠️ Asset cleanup warning: {str(e)}")
