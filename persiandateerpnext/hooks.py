app_name = "persiandateerpnext"
app_title = "Persian Date ERPNext"
app_publisher = "Ideenemium"
app_description = "A comprehensive solution to convert ERPNext date and datetime fields to Shamsi (Jalali) Calendar"
app_email = "ideenemium@gmail.com"
app_license = "MIT"
app_version = "1.0.8"

# Required app for ERPNext
required_apps = ["erpnext"]

# Apps to include for ERPNext compatibility  
depends_on = ["frappe", "erpnext"]

# Fixtures - automatically loaded during migrate
fixtures = [
    {
        "doctype": "Custom Field", 
        "filters": {"module": "Persian Date ERPNext"}
    }
]

# Assets - Bundle-based inclusion to prevent conflicts
app_include_css = [
    "/assets/persiandateerpnext/css/persiandateerpnext.bundle.css"
]

app_include_js = [
    "/assets/persiandateerpnext/js/persiandateerpnext.bundle.js"
]

# Include JS/CSS in web template (website) - using bundle
web_include_css = [
    "/assets/persiandateerpnext/css/persiandateerpnext.bundle.css"
]

web_include_js = [
    "/assets/persiandateerpnext/js/persiandateerpnext.bundle.js"
]

# Installation hooks
# ----------------

after_install = "persiandateerpnext.install.install.after_install"
after_migrate = "persiandateerpnext.install.install.after_migrate"

# Build hooks
# ----------------

# before_app_uninstall = "persiandateerpnext.install.install.before_uninstall"
