// persiandateerpnext/public/js/in_words_cleanup.js
// Clean up "Only" and "فقط" suffixes from in_words field in all forms

frappe.provide("frappe.ui.form");

// تابع پاکسازی پسوند "Only" و "فقط" از فیلد in_words
function cleanInWordsSuffix(inWordsValue) {
    if (!inWordsValue || typeof inWordsValue !== 'string') {
        return inWordsValue;
    }
    
    let cleanedValue = inWordsValue.trim();
    
    // حذف پسوند "Only" انگلیسی
    if (cleanedValue.endsWith(" Only")) {
        cleanedValue = cleanedValue.slice(0, -5).trim();
    } else if (cleanedValue.endsWith("Only")) {
        cleanedValue = cleanedValue.slice(0, -4).trim();
    }
    
    // حذف پسوند "فقط" فارسی
    if (cleanedValue.endsWith(" فقط")) {
        cleanedValue = cleanedValue.slice(0, -4).trim();
    } else if (cleanedValue.endsWith("فقط")) {
        cleanedValue = cleanedValue.slice(0, -3).trim();
    }
    
    return cleanedValue;
}

// اعمال به تمام فرم‌ها با استفاده از wildcard
frappe.ui.form.on('*', {
    // رویداد refresh فرم
    refresh: function(frm) {
        if (frm.doc && frm.doc.in_words) {
            const originalValue = frm.doc.in_words;
            const cleanedValue = cleanInWordsSuffix(originalValue);
            
            if (originalValue !== cleanedValue) {
                // تنظیم مقدار پاک شده بدون trigger کردن validation
                frm.set_value("in_words", cleanedValue, null, true);
            }
        }
    },
    
    // رویداد تغییر فیلد in_words
    in_words: function(frm) {
        if (frm.doc && frm.doc.in_words) {
            const originalValue = frm.doc.in_words;
            const cleanedValue = cleanInWordsSuffix(originalValue);
            
            if (originalValue !== cleanedValue) {
                // به‌روزرسانی مقدار با debounce برای جلوگیری از loop
                setTimeout(() => {
                    if (frm.doc.in_words === originalValue) {
                        frm.set_value("in_words", cleanedValue, null, true);
                    }
                }, 100);
            }
        }
    }
});

// رویداد سراسری برای فیلدهای in_words در تمام فرم‌ها
$(document).on('blur', 'input[data-fieldname="in_words"]', function() {
    const $input = $(this);
    const originalValue = $input.val();
    const cleanedValue = cleanInWordsSuffix(originalValue);
    
    if (originalValue !== cleanedValue) {
        $input.val(cleanedValue);
        $input.trigger('change');
    }
});

// Hook برای فیلدهای calculated مثل total_in_words
frappe.ui.form.on('*', {
    // رویداد محاسبه مجدد فیلدها
    onload_post_render: function(frm) {
        // بررسی و پاکسازی فیلدهای مختلف in_words
        const inWordsFields = ['in_words', 'total_in_words', 'base_in_words'];
        
        inWordsFields.forEach(fieldname => {
            if (frm.doc && frm.doc[fieldname]) {
                const originalValue = frm.doc[fieldname];
                const cleanedValue = cleanInWordsSuffix(originalValue);
                
                if (originalValue !== cleanedValue) {
                    frm.set_value(fieldname, cleanedValue, null, true);
                }
            }
        });
    }
});

// Observer برای فیلدهایی که به صورت dynamic اضافه می‌شوند
const inWordsObserver = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
        if (mutation.type === 'childList') {
            const addedNodes = Array.from(mutation.addedNodes);
            addedNodes.forEach(node => {
                if (node.nodeType === 1) { // Element node
                    const inWordsInputs = node.querySelectorAll ? 
                        node.querySelectorAll('input[data-fieldname*="in_words"]') : [];
                    
                    inWordsInputs.forEach(input => {
                        const originalValue = input.value;
                        const cleanedValue = cleanInWordsSuffix(originalValue);
                        
                        if (originalValue !== cleanedValue) {
                            input.value = cleanedValue;
                            $(input).trigger('change');
                        }
                    });
                }
            });
        }
    });
});

// شروع Observer
if (document.body) {
    inWordsObserver.observe(document.body, {
        childList: true,
        subtree: true
    });
}

// تابع پاکسازی دستی که می‌تواند از خارج صدا زده شود
window.cleanAllInWordsFields = function() {
    $('input[data-fieldname*="in_words"]').each(function() {
        const $input = $(this);
        const originalValue = $input.val();
        const cleanedValue = cleanInWordsSuffix(originalValue);
        
        if (originalValue !== cleanedValue) {
            $input.val(cleanedValue);
            $input.trigger('change');
        }
    });
};

// اجرای پاکسازی در صورت بارگذاری مجدد صفحه
$(document).ready(function() {
    setTimeout(() => {
        if (window.cleanAllInWordsFields) {
            window.cleanAllInWordsFields();
        }
    }, 1000);
});

console.log("Persian Date ERPNext: in_words cleanup script loaded");
