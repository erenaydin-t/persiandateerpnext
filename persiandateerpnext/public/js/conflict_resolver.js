// Persian Date ERPNext - Conflict Resolution Script
// این فایل مشکلات کانفلیکت با ERPNext را حل می‌کند

(function() {
    'use strict';
    
    console.log("🔧 Persian Date ERPNext - Conflict Resolver Loading...");
    
    // تابع تشخیص و حل کانفلیکت
    function resolveConflicts() {
        
        // 1. غیرفعال کردن flatpickr برای فیلدهای فعال شده
        if (window.flatpickr) {
            const originalFlatpickr = window.flatpickr;
            window.flatpickr = function(element, options) {
                // اگر element دارای کلاس jalali است، آن را نادیده بگیر
                if (element && (element.classList.contains('jalali-initialized') || 
                              element.classList.contains('jalali-persian-initialized'))) {
                    console.log("🚫 Blocking flatpickr for Jalali field");
                    return null;
                }
                return originalFlatpickr.call(this, element, options);
            };
        }
        
        // 2. غیرفعال کردن frappe datepicker برای فیلدهای فعال شده  
        if (frappe && frappe.ui && frappe.ui.form && frappe.ui.form.make_control) {
            const originalMakeControl = frappe.ui.form.make_control;
            frappe.ui.form.make_control = function(opts) {
                const control = originalMakeControl.call(this, opts);
                
                // اگر کنترل از نوع Date یا Datetime است و فیلد فعال شده
                if ((opts.fieldtype === 'Date' || opts.fieldtype === 'Datetime') && 
                    control && control.$input) {
                    
                    // تاخیر برای اطمینان از لود شدن Jalali
                    setTimeout(() => {
                        if (control.$input.hasClass('jalali-initialized') || 
                            control.$input.hasClass('jalali-persian-initialized')) {
                            
                            // غیرفعال کردن event های frappe datepicker
                            control.$input.off('focus.datepicker click.datepicker');
                            console.log("🚫 Disabled frappe datepicker events for Jalali field");
                        }
                    }, 100);
                }
                
                return control;
            };
        }
        
        // 3. مدیریت z-index برای جلوگیری از پنهان شدن
        function fixZIndex() {
            const datepickers = document.querySelectorAll('.datepicker-container');
            datepickers.forEach(picker => {
                // بررسی محیط والد
                const modal = picker.closest('.modal');
                const sidebar = picker.closest('.layout-side-section');
                
                if (modal) {
                    picker.style.zIndex = '1099999';
                } else if (sidebar) {
                    picker.style.zIndex = '999999';
                } else {
                    picker.style.zIndex = '999999';
                }
            });
        }
        
        // اجرای fixZIndex هر بار که datepicker باز می‌شود
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === 1 && 
                        (node.classList.contains('datepicker-container') || 
                         node.querySelector('.datepicker-container'))) {
                        setTimeout(fixZIndex, 10);
                    }
                });
            });
        });
        
        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
        
        // 4. حل کانفلیکت CSS
        function addConflictFreeStyles() {
            const style = document.createElement('style');
            style.id = 'persian-date-conflict-resolver';
            style.textContent = `
                /* غیرفعال کردن datepicker های دیگر فقط برای فیلدهای فعال */
                .jalali-initialized ~ .flatpickr-calendar,
                .jalali-persian-initialized ~ .flatpickr-calendar {
                    display: none !important;
                }
                
                .jalali-initialized ~ .bootstrap-datetimepicker-widget,
                .jalali-persian-initialized ~ .bootstrap-datetimepicker-widget {
                    display: none !important;
                }
                
                /* اطمینان از نمایش Persian datepicker */
                .datepicker-container {
                    display: block !important;
                    visibility: visible !important;
                }
                
                /* جلوگیری از scroll issue */
                body.datepicker-open {
                    overflow: visible !important;
                }
                
                /* حل مشکل z-index با سایر datepicker ها */
                .flatpickr-calendar {
                    z-index: 50 !important;
                }
                
                .bootstrap-datetimepicker-widget {
                    z-index: 50 !important;
                }
                
                .frappe-datepicker {
                    z-index: 50 !important;
                }
            `;
            
            // حذف style قبلی اگر وجود دارد
            const existingStyle = document.getElementById('persian-date-conflict-resolver');
            if (existingStyle) {
                existingStyle.remove();
            }
            
            document.head.appendChild(style);
        }
        
        addConflictFreeStyles();
        
        console.log("✅ Persian Date ERPNext conflicts resolved");
    }
    
    // تابع بررسی وضعیت و فعال‌سازی
    function checkAndActivate() {
        // بررسی که آیا Shamsi فعال است یا نه
        if (typeof frappe !== 'undefined' && frappe.call) {
            frappe.call({
                method: "frappe.client.get_value",
                args: {
                    doctype: "System Settings",
                    fieldname: "enable_shamsi_jalali_calendar"
                },
                callback: function(r) {
                    if (r.message && r.message.enable_shamsi_jalali_calendar) {
                        resolveConflicts();
                        console.log("🎯 Conflicts resolved for active Shamsi calendar");
                    } else {
                        console.log("⏸️ Shamsi calendar disabled, skipping conflict resolution");
                    }
                }
            });
        } else {
            // اگر frappe هنوز لود نشده، به هر حال conflict ها را حل کن
            setTimeout(() => {
                resolveConflicts();
                console.log("🎯 Conflicts resolved (fallback mode)");
            }, 500);
        }
    }
    
    // اجرای مقدماتی
    if (typeof frappe !== 'undefined' && frappe.ready) {
        frappe.ready(checkAndActivate);
    } else {
        // fallback برای زمانی که frappe هنوز لود نشده
        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(checkAndActivate, 1000);
        });
    }
    
    // اجرای مجدد زمان تغییر صفحه در SPA
    if (typeof frappe !== 'undefined') {
        $(document).on('page-change', checkAndActivate);
    }
    
    // Export برای استفاده در قسمت‌های دیگر
    window.PersianDateConflictResolver = {
        resolve: resolveConflicts,
        check: checkAndActivate
    };
    
})();
