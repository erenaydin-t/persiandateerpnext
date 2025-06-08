app_name = "persiandateerpnext"
app_title = "Persian Date ERPNext"
app_publisher = "Ideenemium"
app_description = "A comprehensive solution to convert ERPNext date and datetime fields to Shamsi (Jalali) Calendar"
app_email = "ideenemium@gmail.com"
app_license = "MIT"
app_version = "1.0.3"

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

# Assets - Use legacy method for better compatibility
app_include_css = [
    "/assets/persiandateerpnext/css/persian-datepicker.min.css",
    "/assets/persiandateerpnext/css/custom.css"
]

app_include_js = [
    "/assets/persiandateerpnext/js/debug_check.js",
    "/assets/persiandateerpnext/js/persian-date.min.js",
    "/assets/persiandateerpnext/js/persian-datepicker.min.js",
    "/assets/persiandateerpnext/js/togregorian_date.js",
    "/assets/persiandateerpnext/js/topersian_date.js",
    "/assets/persiandateerpnext/js/in_words_cleanup.js"
]

# Include JS/CSS in web template (website)
web_include_css = [
    "/assets/persiandateerpnext/css/persian-datepicker.min.css",
    "/assets/persiandateerpnext/css/custom.css"
]

web_include_js = [
    "/assets/persiandateerpnext/js/persian-date.min.js",
    "/assets/persiandateerpnext/js/persian-datepicker.min.js",
    "/assets/persiandateerpnext/js/togregorian_date.js",
    "/assets/persiandateerpnext/js/topersian_date.js"
]

# Installation hooks
# ----------------

after_install = "persiandateerpnext.install.install.after_install"
