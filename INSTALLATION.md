# 🎉 Persian Date ERPNext v1.0.4 - آماده استفاده!

## خلاصه نهایی:
✅ **مشکل Assets Loading (404) حل شده**  
✅ **نصب خودکار با Manual Copy**  
✅ **Debug Tools و Troubleshooting کامل**  
✅ **Production Ready**

---

## ⚡ نصب سریع:

```bash
# نصب جدید:
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
bench --site [site-name] install-app persiandateerpnext
bench --site [site-name] migrate
bench build
bench restart

# یا آپدیت از نسخه قبل:
bench --site [site-name] uninstall-app persiandateerpnext
bench remove-app persiandateerpnext
bench get-app https://github.com/erenaydin-t/persiandateerpnext.git
bench --site [site-name] install-app persiandateerpnext
bench --site [site-name] migrate
```

## ⚙️ تنظیمات:
1. **Settings → System Settings**
2. **Enable Shamsi (Jalali) Calendar** ✅
3. **Date Storage Format** → **Gregorian**
4. **Save** و refresh browser

---

## 🔧 اگر مشکل Assets دارید:

### راه حل فوری:
```bash
mkdir -p sites/assets/persiandateerpnext/css sites/assets/persiandateerpnext/js
cp apps/persiandateerpnext/persiandateerpnext/public/css/* sites/assets/persiandateerpnext/css/
cp apps/persiandateerpnext/persiandateerpnext/public/js/* sites/assets/persiandateerpnext/js/
bench build && bench restart
```

### یا استفاده از Script:
```bash
wget https://raw.githubusercontent.com/erenaydin-t/persiandateerpnext/main/fix_assets.sh
chmod +x fix_assets.sh
./fix_assets.sh
```

---

## 📋 چک لیست موفقیت:
- [ ] فایل‌های CSS/JS در `sites/assets/persiandateerpnext/` وجود دارند
- [ ] در Browser Console خطای 404 نیست
- [ ] System Settings فعال شده
- [ ] Date fields تقویم فارسی نشان می‌دهند
- [ ] معادل میلادی زیر تاریخ فارسی نمایش داده می‌شود

---

## 📞 پشتیبانی:
- **🔧 مشکل Assets**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **🐛 Bug Report**: [GitHub Issues](https://github.com/erenaydin-t/persiandateerpnext/issues)
- **📧 Contact**: ideenemium@gmail.com

**با ❤️ برای جامعه ERPNext فارسی ساخته شده**
