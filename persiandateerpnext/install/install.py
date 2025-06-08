import frappe

def after_install():
    """Called after app installation"""
    try:
        # Force rebuild assets
        frappe.clear_cache()
        
        # Create notification for user
        frappe.msgprint(
            msg="""
            <div style='text-align: center; padding: 20px;'>
                <h3>🎉 Persian Date ERPNext Installed Successfully!</h3>
                <p><strong>Next Steps:</strong></p>
                <ol style='text-align: left; max-width: 500px; margin: 0 auto;'>
                    <li>Go to <strong>Settings → System Settings</strong></li>
                    <li>Enable "<strong>Enable Shamsi (Jalali) Calendar</strong>" checkbox</li>
                    <li>Select "<strong>Date Storage Format</strong>" (Gregorian recommended)</li>
                    <li>Save settings and refresh your browser</li>
                </ol>
                <p style='margin-top: 20px;'>
                    <strong>Need help?</strong> 
                    <a href='https://github.com/erenaydin-t/persiandateerpnext' target='_blank'>
                        Visit Documentation
                    </a>
                </p>
                <hr style='margin: 20px 0;'>
                <p style='color: #666; font-size: 12px;'>
                    Persian Date ERPNext v1.0.3<br>
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
            "subject": "Persian Date ERPNext installed successfully",
            "content": "App installed and ready for configuration in System Settings",
            "status": "Open",
            "communication_type": "System Generated"
        }).insert(ignore_permissions=True)
        
        print("✅ Persian Date ERPNext installation completed successfully")
        
    except Exception as e:
        frappe.log_error(f"Error in Persian Date ERPNext installation: {str(e)}")
        print(f"❌ Installation error: {str(e)}")
