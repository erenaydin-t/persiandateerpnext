# 🔧 Persian Date ERPNext - مشکل Assets Loading

## مشکل شما:
تنظیمات رو انجام دادید ولی Persian datepicker اعمال نشده.

## ✅ راه‌حل قطعی (گام به گام):

### 1. **Uninstall کردن اپلیکیشن**
```bash
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
```

### 2. **نصب مجدد نسخه جدید**
```bash
# دانلود نسخه v1.0.2 که مشکل assets حل شده
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git

# نصب
bench --site [site-name] install-app persiandateerpnext

# اجرای migrations
bench --site [site-name] migrate
```

### 3. **Build کردن Assets**
```bash
# Build با force flag
bench build --app persiandateerpnext --force

# Build عمومی
bench build

# پاک کردن cache
bench --site [site-name] clear-cache
bench --site [site-name] clear-website-cache

# Restart
bench restart
```

### 4. **بررسی Assets Loading**
```bash
# چک کردن آیا فایل‌ها کپی شدن
ls -la sites/assets/persiandateerpnext/css/
ls -la sites/assets/persiandateerpnext/js/

# باید این فایل‌ها وجود داشته باشن:
# - persian-datepicker.min.css
# - custom.css
# - persian-date.min.js
# - persian-datepicker.min.js
# - togregorian_date.js
# - topersian_date.js
# - in_words_cleanup.js
```

### 5. **تنظیمات System Settings**
1. برید به **Settings → System Settings**
2. پیدا کنید **"Enable Shamsi (Jalali) Calendar"**
3. تیک بزنید ✅
4. **Date Storage Format** رو روی **"Gregorian (میلادی)"** بذارید
5. **Save** کنید

### 6. **Browser Cache پاک کردن**
```bash
# در browser بزنید F12 → Console → و این کد رو اجرا کنید:
localStorage.clear();
sessionStorage.clear();
location.reload(true);
```

### 7. **Debug Check**
بعد از نصب مجدد، وقتی صفحه رو refresh کردید، در **Browser Console** (F12) باید این پیغام‌ها رو ببینید:
```
🔍 Persian Date ERPNext Debug Check
✅ Persian Date library loaded
✅ Persian Datepicker library loaded
✅ Shamsi Calendar is ENABLED
📅 Storage Format: Gregorian
✅ Persian Datepicker CSS loaded
```

## 🐛 اگر باز کار نکرد:

### مرحله 1: بررسی Production Mode
```bash
# اگر در production mode هستید:
sudo supervisorctl restart all
sudo nginx -s reload

# یا
sudo systemctl restart nginx
sudo systemctl restart supervisor
```

### مرحله 2: Complete Reinstall
```bash
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
rm -rf apps/persiandateerpnext

bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
bench --site [site-name] install-app persiandateerpnext
bench --site [site-name] migrate
bench build
bench restart
```

### مرحله 3: Manual Asset Copy (آخرین راه‌حل)
```bash
# اگر هنوز کار نکرد، manual کپی کنید:
cp -r apps/persiandateerpnext/persiandateerpnext/public/* sites/assets/persiandateerpnext/

# سپس مجدد build کنید:
bench build
bench restart
```

## ✨ بعد از حل مشکل:

وقتی کار کرد، باید:
1. همه date fields در ERPNext تقویم فارسی نشون بدن
2. وقتی تاریخ فارسی انتخاب می‌کنید، معادل میلادی زیرش نمایش داده بشه
3. در database تاریخ‌ها به فرمت میلادی ذخیره بشن (چون Gregorian انتخاب کردید)

## 📞 پشتیبانی
اگر باز مشکل داشتید:
- GitHub Issue: https://github.com/erenaydin-t/persiandateerpnext/issues  
- Email: ideenemium@gmail.com

**توجه**: نسخه v1.0.2 مخصوص حل همین مشکل assets ساخته شده!
