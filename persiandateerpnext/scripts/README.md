# Persian Date ERPNext - Asset Fix Scripts

مجموعه scripts برای حل مشکل assets loading در ERPNext.

## 🚀 Scripts موجود:

### 1. `quick_fix.sh` - سریع‌ترین راه‌حل
```bash
cd /path/to/your/bench
bash apps/persiandateerpnext/persiandateerpnext/scripts/quick_fix.sh
```

### 2. `fix_assets.py` - Python Version (پیشرفته)
```bash
cd /path/to/your/bench  
python3 apps/persiandateerpnext/persiandateerpnext/scripts/fix_assets.py
```

### 3. `fix_all_assets.sh` - راه‌حل کامل
```bash
cd /path/to/your/bench
bash apps/persiandateerpnext/persiandateerpnext/scripts/fix_all_assets.sh
```

## 🎯 مشکلات که حل می‌کنن:

- ❌ `GET /assets/frappe/dist/css-rtl/website.bundle.*.css 404`
- ❌ `GET /assets/erpnext/dist/css-rtl/erpnext-web.bundle.*.css 404`
- ❌ `GET /assets/persiandateerpnext/css/persian-datepicker.min.css 404`
- ❌ سایت لود نمی‌شه بعد از build

## ✅ نتیجه:

- ✅ همه assets کپی می‌شن
- ✅ RTL files در دسترس قرار می‌گیرن
- ✅ Persian Date ERPNext کار می‌کنه
- ✅ سایت عادی لود می‌شه

## 🔧 استفاده:

1. **اجرا کنید** یکی از scripts بالا
2. **System Settings** برید و Shamsi Calendar فعال کنید
3. **Browser refresh** کنید (Ctrl+F5)
4. **تست کنید** date fields

---
**نسخه v1.0.6 - حل کامل مشکل assets**
