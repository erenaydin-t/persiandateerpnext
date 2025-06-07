app_name = "persiandateerpnext"
app_title = "Persian Date ERPNext"
app_publisher = "ErenAydin"
app_description = "A comprehensive solution to convert ERPNext date and datetime fields to Shamsi (Jalali) Calendar"
app_email = "cccc@gmail.com"
app_license = "MIT"
app_version = "1.0.0"

# Required app for ERPNext
required_apps = ["erpnext"]

# Apps to include for ERPNext compatibility  
depends_on = ["frappe", "erpnext"]

# Fixtures
fixtures = [
    {
        "doctype": "Custom Field", 
        "filters": {"module": "Persian Date ERPNext"}
    }
]

# Include JS/CSS files in the desk
app_include_css = [
    "/assets/persiandateerpnext/css/persian-datepicker.min.css",
    "/assets/persiandateerpnext/css/custom.css"
]

app_include_js = [
    "/assets/persiandateerpnext/js/persian-date.min.js",
    "/assets/persiandateerpnext/js/persian-datepicker.min.js",
    "/assets/persiandateerpnext/js/togregorian_date.js",
    "/assets/persiandateerpnext/js/topersian_date.js",
    "/assets/persiandateerpnext/js/in_words_cleanup.js"
]

# Include JS/CSS in web template
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

# Website Route Rules
# website_route_rules = []

# Generators
# website_generators = []

# Installation
# ----------------

# before_install = "persiandateerpnext.install.before_install"
# after_install = "persiandateerpnext.install.after_install"

# Uninstallation
# ----------------

# before_uninstall = "persiandateerpnext.uninstall.before_uninstall"
# after_uninstall = "persiandateerpnext.uninstall.after_uninstall"

# Integration Setup
# ------------------

# To set up dependencies/integrations with other apps
# Name of the app being installed is passed as an argument

# before_app_install = "persiandateerpnext.utils.before_app_install"
# after_app_install = "persiandateerpnext.utils.after_app_install"

# before_app_uninstall = "persiandateerpnext.utils.before_app_uninstall"
# after_app_uninstall = "persiandateerpnext.utils.after_app_uninstall"

# Desk Notifications
# ------------------

# See frappe.core.notifications.get_notification_config

# notification_config = "persiandateerpnext.notifications.get_notification_config"

# Permissions
# -----------

# Permissions evaluated in scripted ways

# permission_query_conditions = {
#   "Event": "frappe.desk.doctype.event.event.get_permission_query_conditions",
# }
#
# has_permission = {
#   "Event": "frappe.desk.doctype.event.event.has_permission",
# }

# DocType Class
# ---------------

# Override standard doctype classes

# override_doctype_class = {
#   "ToDo": "custom_app.overrides.CustomToDo"
# }

# Document Events
# ---------------

# Hook on document methods and events

# doc_events = {
#   "*": {
#       "on_update": "method",
#       "on_cancel": "method",
#       "on_trash": "method"
#   }
# }

# Scheduled Tasks
# ---------------

# scheduler_events = {
#   "all": [
#       "persiandateerpnext.tasks.all"
#   ],
#   "daily": [
#       "persiandateerpnext.tasks.daily"
#   ],
#   "hourly": [
#       "persiandateerpnext.tasks.hourly"
#   ],
#   "weekly": [
#       "persiandateerpnext.tasks.weekly"
#   ],
#   "monthly": [
#       "persiandateerpnext.tasks.monthly"
#   ],
# }

# Testing
# -------

# before_tests = "persiandateerpnext.install.before_tests"

# Overriding Methods
# ------------------------------

# override_whitelisted_methods = {
#   "frappe.desk.doctype.event.event.get_events": "persiandateerpnext.event.get_events"
# }
#
# each overriding function accepts a `data` argument;
# generated from the base implementation of the doctype dashboard,
# along with any modifications made in other Frappe apps
# override_doctype_dashboards = {
#   "Task": "persiandateerpnext.task.get_dashboard_data"
# }

# exempt linked doctypes from being automatically cancelled
#
# auto_cancel_exempted_doctypes = ["Auto Repeat"]

# Ignore links to specified DocTypes when deleting documents
# -----------------------------------------------------------

# ignore_links_on_delete = ["Communication", "ToDo"]

# Request Events
# ----------------

# before_request = ["persiandateerpnext.utils.before_request"]
# after_request = ["persiandateerpnext.utils.after_request"]

# Job Events
# ----------

# before_job = ["persiandateerpnext.utils.before_job"]
# after_job = ["persiandateerpnext.utils.after_job"]

# User Data Protection
# --------------------

# user_data_fields = [
#   {
#       "doctype": "{doctype_1}",
#       "filter_by": "{filter_by}",
#       "redact_fields": ["{field_1}", "{field_2}"],
#       "partial": 1,
#   },
#   {
#       "doctype": "{doctype_2}",
#       "filter_by": "{filter_by}",
#       "partial": 1,
#   },
#   {
#       "doctype": "{doctype_3}",
#       "strict": False,
#   },
#   {
#       "doctype": "{doctype_4}"
#   }
# ]

# Authentication and authorization
# --------------------------------

# auth_hooks = [
#   "persiandateerpnext.auth.validate"
# ]

# Automatically update python controller files with type annotations for Frappe
# --------------------------------------------------------------------------------
# export_python_type_annotations = True

# default_log_clearing_doctypes = {
#   "Logging DocType Name": 30  # days to retain logs
# }
