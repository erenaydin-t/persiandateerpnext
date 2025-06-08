// Debug script to check if Persian Date ERPNext is loading
console.log("🔍 Persian Date ERPNext Debug Check");

// Check if libraries are loaded
if (typeof persianDate !== 'undefined') {
    console.log("✅ Persian Date library loaded");
} else {
    console.log("❌ Persian Date library NOT loaded");
}

if (typeof $ !== 'undefined' && $.fn.persianDatepicker) {
    console.log("✅ Persian Datepicker library loaded");
} else {
    console.log("❌ Persian Datepicker library NOT loaded");
}

// Check System Settings
frappe.ready(function() {
    frappe.call({
        method: "frappe.client.get_value",
        args: {
            doctype: "System Settings",
            fieldname: ["enable_shamsi_jalali_calendar", "date_storage_format"]
        },
        callback: function(r) {
            if (r.message) {
                console.log("📋 System Settings:", r.message);
                if (r.message.enable_shamsi_jalali_calendar) {
                    console.log("✅ Shamsi Calendar is ENABLED");
                    console.log("📅 Storage Format:", r.message.date_storage_format || "Not set");
                } else {
                    console.log("❌ Shamsi Calendar is DISABLED");
                }
            }
        }
    });
});

// Check if CSS is loaded
setTimeout(function() {
    const testElement = document.createElement('div');
    testElement.className = 'pwt-datepicker-input-element';
    document.body.appendChild(testElement);
    
    const computedStyle = window.getComputedStyle(testElement);
    if (computedStyle.position === 'relative' || computedStyle.display === 'block') {
        console.log("✅ Persian Datepicker CSS loaded");
    } else {
        console.log("❌ Persian Datepicker CSS NOT loaded");
    }
    
    document.body.removeChild(testElement);
}, 1000);
