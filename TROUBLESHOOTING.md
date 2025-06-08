# 🔧 Persian Date ERPNext v1.0.4 - حل مشکل Assets Loading

## مشکل شما:
تنظیمات رو انجام دادید ولی Persian datepicker اعمال نشده و در Console این خطا رو می‌بینید:
```
GET http://10.50.150.10:8080/assets/persiandateerpnext/css/persian-datepicker.min.css net::ERR_ABORTED 404 (Not Found)
```

## ⚡ راه‌حل فوری (Manual Copy):

```bash
# پوشه assets بسازید:
mkdir -p sites/assets/persiandateerpnext/css/
mkdir -p sites/assets/persiandateerpnext/js/

# Manual کپی کردن:
cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/
cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/

# Build و restart:
bench build
bench restart
```

### 📜 یا استفاده از Script خودکار:
```bash
# دانلود و اجرای script:
wget https://raw.githubusercontent.com/erenaydin-t/persiandateerpnext/main/fix_assets.sh
chmod +x fix_assets.sh
./fix_assets.sh
```

## ✅ راه‌حل کامل (نصب مجدد v1.0.4):

### 1. **Uninstall کردن اپلیکیشن**
```bash
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
```

### 2. **نصب مجدد نسخه v1.0.4**
```bash
# دانلود نسخه v1.0.4 که مشکل assets با Manual Copy حل شده
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git

# نصب (assets خودکار کپی می‌شن)
bench --site [site-name] install-app persiandateerpnext

# اجرای migrations
bench --site [site-name] migrate
```

### 3. **تایید Assets کپی شده**
```bash
# چک کنید فایل‌ها کپی شدن:
ls -la sites/assets/persiandateerpnext/css/
ls -la sites/assets/persiandateerpnext/js/

# باید این فایل‌ها وجود داشته باشن:
# CSS: persian-datepicker.min.css, custom.css
# JS: persian-date.min.js, persian-datepicker.min.js, togregorian_date.js, topersian_date.js, in_words_cleanup.js, debug_check.js
```

### 4. **Build و Restart**
```bash
bench build --app persiandateerpnext --force
bench --site [site-name] clear-cache
bench restart
```

## 🔍 تشخیص مشکل:

### چک کردن Assets در سرور:
```bash
# 1. چک source files:
ls -la apps/persiandateerpnext/persiandateerpnext/public/css/
ls -la apps/persiandateerpnext/persiandateerpnext/public/js/

# 2. چک copied files:
ls -la sites/assets/persiandateerpnext/css/
ls -la sites/assets/persiandateerpnext/js/

# 3. چک permissions:
ls -la sites/assets/persiandateerpnext/
```

### چک کردن در Browser:
1. باز کنید: `http://your-site.com/assets/persiandateerpnext/css/persian-datepicker.min.css`
2. اگر 404 دادش → فایل کپی نشده
3. اگر فایل نمایش داده شد → مشکل از جای دیگه‌ست

## 🛠️ راه‌حل‌های اضافی:

### اگر Production Mode هستید:
```bash
# Nginx reload:
sudo nginx -s reload

# Supervisor restart:
sudo supervisorctl restart all

# یا:
sudo systemctl restart nginx
sudo systemctl restart supervisor
```

### اگر Docker استفاده می‌کنید:
```bash
# Container restart:
docker-compose restart

# یا rebuild:
docker-compose down
docker-compose up -d
```

### Complete Clean Install:
```bash
# پاک کردن کامل:
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
rm -rf apps/persiandateerpnext
rm -rf sites/assets/persiandateerpnext

# نصب تازه:
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
bench --site [site-name] install-app persiandateerpnext
bench --site [site-name] migrate

# Manual assets copy (برای اطمینان):
mkdir -p sites/assets/persiandateerpnext/css sites/assets/persiandateerpnext/js
cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/
cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/

bench build
bench restart
```

## ✨ بعد از حل مشکل:

### 1. تنظیمات System Settings:
1. برید به **Settings → System Settings**
2. پیدا کنید **"Enable Shamsi (Jalali) Calendar"**
3. تیک بزنید ✅
4. **Date Storage Format** رو روی **"Gregorian (میلادی)"** بذارید
5. **Save** کنید

### 2. تست در Browser:
- Browser رو refresh کنید (Ctrl+F5)
- Console رو باز کنید (F12)
- باید این پیغام‌ها رو ببینید:
```
🔍 Persian Date ERPNext Debug Check
✅ Persian Date library loaded
✅ Persian Datepicker library loaded
✅ Shamsi Calendar is ENABLED
📅 Storage Format: Gregorian
✅ Persian Datepicker CSS loaded
```

### 3. تست عملکرد:
- یک date field رو کلیک کنید
- باید datepicker فارسی باز بشه
- تاریخ فارسی انتخاب کنید
- معادل میلادی زیرش نمایش داده بشه

## 📞 پشتیبانی
اگر باز مشکل داشتید:
- GitHub Issue: https://github.com/erenaydin-t/persiandateerpnext/issues  
- Email: ideenemium@gmail.com

**نسخه v1.0.4**: Manual Assets Copy برای حل قطعی مشکل!
