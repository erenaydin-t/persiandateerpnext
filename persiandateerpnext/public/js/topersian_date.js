// persiandateerpnext/public/js/topersian_date.js
// Persian Storage Mode - Stores Persian dates in database, shows Jalali in UI

frappe.provide("frappe.ui.form");

// تابع تبدیل اعداد فارسی به لاتین
function toLatinDigits(str) {
    if (!str) return str;
    const persianNumbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g];
    const latinNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    let result = str.toString();
    for (let i = 0; i < 10; i++) {
        result = result.replace(persianNumbers[i], latinNumbers[i]);
    }
    return result;
}

// تابع تبدیل تاریخ شمسی به میلادی (برای نمایش)
function persianToGregorian(persianDateStr) {
    try {
        const cleanDate = toLatinDigits(persianDateStr);
        const [year, month, day] = cleanDate.split("/").map(Number);
        if (!year || !month || !day) return null;
        
        const pDate = new persianDate([year, month, day]);
        return pDate.toCalendar("gregorian").format("YYYY-MM-DD");
    } catch (error) {
        console.error("Error converting Persian to Gregorian:", error);
        return null;
    }
}

// تابع تبدیل تاریخ و زمان شمسی به میلادی (برای نمایش)
function persianToGregorianDatetime(persianDateTimeStr) {
    try {
        const cleanDateTime = toLatinDigits(persianDateTimeStr);
        const [datePart, timePart = "00:00:00"] = cleanDateTime.split(" ");
        const [year, month, day] = datePart.split("/").map(Number);
        const [hour = 0, minute = 0, second = 0] = timePart.split(":").map(Number);
        
        if (!year || !month || !day) return null;
        
        const pDate = new persianDate([year, month, day, hour, minute, second]);
        return pDate.toCalendar("gregorian").format("YYYY-MM-DD HH:mm:ss");
    } catch (error) {
        console.error("Error converting Persian datetime to Gregorian:", error);
        return null;
    }
}

// تابع اصلی برای فعال‌سازی تقویم شمسی
function initializePersianStorageDatepicker() {
    // دریافت تنظیمات سیستم
    frappe.call({
        method: "frappe.client.get",
        args: {
            doctype: "System Settings",
            name: "System Settings"
        },
        callback: function(r) {
            if (!r.message) return;
            
            const settings = r.message;
            
            // بررسی فعال بودن تقویم شمسی و حالت ذخیره‌سازی فارسی
            if (!settings.custom_enable_shamsi_jalali_calendar || 
                settings.custom_date_storage_format !== "Persian (شمسی)") {
                return;
            }

            console.log("Jalali datepicker activated - Persian storage mode");

            // پیدا کردن تمام فیلدهای Date
            setupPersianDateFields();
            
            // پیدا کردن تمام فیلدهای Datetime  
            setupPersianDatetimeFields();
        }
    });
}

// تنظیم فیلدهای Date (حالت ذخیره‌سازی فارسی)
function setupPersianDateFields() {
    $('input[data-fieldtype="Date"]').each(function() {
        const $input = $(this);
        const fieldname = $input.attr("data-fieldname");
        
        if ($input.hasClass("jalali-persian-initialized")) return;
        
        $input.addClass("jalali-persian-initialized");
        
        // اگر مقدار موجود وجود دارد، نمایش معادل میلادی
        const currentValue = $input.val();
        if (currentValue && currentValue !== "") {
            const gregorianDate = persianToGregorian(currentValue);
            if (gregorianDate) {
                showGregorianDate($input, gregorianDate);
            }
        }
        
        // اضافه کردن تقویم فارسی
        $input.persianDatepicker({
            format: "YYYY/MM/DD",
            position: "auto",
            persianDigit: false,
            autoClose: true,
            calendar: {
                persian: {
                    locale: "fa"
                }
            },
            formatter: function(unix) {
                const pDate = new persianDate(unix);
                return toLatinDigits(pDate.format("YYYY/MM/DD"));
            },
            onSelect: function(unix) {
                const pDate = new persianDate(unix);
                const persianDateLatin = toLatinDigits(pDate.format("YYYY/MM/DD"));
                const gregorianDate = pDate.toCalendar("gregorian").format("YYYY-MM-DD");
                
                // تنظیم مقدار شمسی در UI و مدل (ذخیره همان مقدار شمسی)
                $input.val(persianDateLatin);
                
                // نمایش معادل میلادی
                showGregorianDate($input, gregorianDate);
                
                // ذخیره مقدار شمسی در مدل
                const frm = cur_frm;
                if (frm && fieldname) {
                    frm.set_value(fieldname, persianDateLatin);
                }
                
                $input.trigger("change");
            }
        });
    });
}

// تنظیم فیلدهای Datetime (حالت ذخیره‌سازی فارسی)
function setupPersianDatetimeFields() {
    $('input[data-fieldtype="Datetime"]').each(function() {
        const $input = $(this);
        const fieldname = $input.attr("data-fieldname");
        
        if ($input.hasClass("jalali-persian-initialized")) return;
        
        $input.addClass("jalali-persian-initialized");
        
        // اگر مقدار موجود وجود دارد، نمایش معادل میلادی
        const currentValue = $input.val();
        if (currentValue && currentValue !== "") {
            const gregorianDateTime = persianToGregorianDatetime(currentValue);
            if (gregorianDateTime) {
                showGregorianDatetime($input, gregorianDateTime);
            }
        }
        
        // اضافه کردن تقویم فارسی با زمان
        $input.persianDatepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            position: "auto",
            timePicker: { 
                enabled: true,
                meridiem: {
                    enabled: false
                }
            },
            persianDigit: false,
            autoClose: true,
            calendar: {
                persian: {
                    locale: "fa"
                }
            },
            formatter: function(unix) {
                const pDate = new persianDate(unix);
                return toLatinDigits(pDate.format("YYYY/MM/DD HH:mm:ss"));
            },
            onSelect: function(unix) {
                const pDate = new persianDate(unix);
                const persianDateTimeLatin = toLatinDigits(pDate.format("YYYY/MM/DD HH:mm:ss"));
                const gregorianDateTime = pDate.toCalendar("gregorian").format("YYYY-MM-DD HH:mm:ss");
                
                // تنظیم مقدار شمسی در UI و مدل (ذخیره همان مقدار شمسی)
                $input.val(persianDateTimeLatin);
                
                // نمایش معادل میلادی
                showGregorianDatetime($input, gregorianDateTime);
                
                // ذخیره مقدار شمسی در مدل
                const frm = cur_frm;
                if (frm && fieldname) {
                    frm.set_value(fieldname, persianDateTimeLatin);
                }
                
                $input.trigger("change");
            }
        });
    });
}

// نمایش معادل میلادی برای فیلد Date
function showGregorianDate($input, gregorianDate) {
    let $gregorian = $input.siblings(".gregorian-date");
    if (!$gregorian.length) {
        $gregorian = $('<div class="gregorian-date"></div>').insertAfter($input);
    }
    $gregorian.text("میلادی: " + gregorianDate);
}

// نمایش معادل میلادی برای فیلد Datetime
function showGregorianDatetime($input, gregorianDateTime) {
    let $gregorian = $input.siblings(".gregorian-datetime");
    if (!$gregorian.length) {
        $gregorian = $('<div class="gregorian-datetime"></div>').insertAfter($input);
    }
    $gregorian.text("میلادی: " + gregorianDateTime);
}

// اجرای اسکریپت در رویدادهای مختلف
$(document).ready(function() {
    initializePersianStorageDatepicker();
});

// رویداد بارگذاری فرم
$(document).on("form-load form-refresh", function() {
    setTimeout(initializePersianStorageDatepicker, 100);
});

// رویداد تغییر route
$(document).on("page-change", function() {
    setTimeout(initializePersianStorageDatepicker, 200);
});

// رویداد برای فیلدهای جدید که بعداً اضافه می‌شوند
$(document).on("DOMNodeInserted", function(e) {
    if ($(e.target).find('input[data-fieldtype="Date"], input[data-fieldtype="Datetime"]').length > 0) {
        setTimeout(initializePersianStorageDatepicker, 100);
    }
});
