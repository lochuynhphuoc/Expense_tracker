# MoneyFlow (Expense Tracker)

Ứng dụng quản lý chi tiêu cá nhân viết bằng Django, giao diện hiện đại, có biểu đồ và thống kê.

## Yêu cầu

- Python 3.10+ (khuyến nghị 3.11)
- pip
- XAMPP (MySQL + phpMyAdmin) nếu dùng cơ sở dữ liệu MySQL

## Cấu trúc thư mục & ý nghĩa

```
expense_tracker/
├─ database.sql                  # database của App (và các dữ liệu mẫu)
├─ manage.py                     # Lệnh quản lý Django (runserver, migrate, ...)
├─ requirements.txt              # Danh sách thư viện cần cài
├─ README.md                     # Tài liệu hướng dẫn
├─ settings.py                   # Thiết lập bổ sung (ví dụ: LOGOUT_REDIRECT_URL)
├─ expense_tracker/              # Package cấu hình dự án
│  ├─ __init__.py
│  ├─ settings.py                # Cấu hình chính (DATABASES, INSTALLED_APPS, ...)
│  ├─ urls.py                    # URL root
│  ├─ wsgi.py                    # WSGI cho deploy
│  └─ asgi.py                    # ASGI cho deploy
└─ expenses/                     # App quản lý chi tiêu
   ├─ __init__.py
   ├─ apps.py                    # Cấu hình app
   ├─ models.py                  # Model dữ liệu (Expense, Category, ...)
   ├─ forms.py                   # Form nhập liệu
   ├─ views.py                   # Xử lý logic + render template
   ├─ urls.py                    # URL của app
   ├─ admin.py                   # Hiển thị model trong Django Admin
   ├─ tests.py                   # Test (nếu có)
   ├─ migrations/                # File migration tạo bảng
   ├─ static/expenses/           # CSS, ảnh tĩnh
   │  └─ styles.css
   └─ templates/                 # Giao diện HTML
	  ├─ base.html               # Layout chung
	  ├─ expenses/               # Template cho dashboard + CRUD
	  └─ registration/           # Template đăng nhập/đăng ký
```

## Cài đặt môi trường ảo

### Windows (PowerShell)

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
```

## Cài thư viện

```bash
pip install -r requirements.txt
```

> Nếu dùng MySQL, cần thêm driver:
>
> ```bash
> pip install mysqlclient
> ```

## Thiết lập MySQL (XAMPP)

### Bước 1: Bật MySQL trong XAMPP

Mở XAMPP Control Panel → Start **Apache** và **MySQL**.

### Bước 2: Tạo database trong phpMyAdmin

1. Truy cập: http://localhost/phpmyadmin
2. Tạo database tên: `expense_tracker`
3. Chọn collation: `utf8mb4_general_ci`

### Bước 3: Import dữ liệu bằng database.sql (tuỳ chọn)

Nếu muốn có dữ liệu mẫu hoặc cấu trúc sẵn có, hãy import file database.sql:

1. Trong phpMyAdmin, chọn database `expense_tracker`
2. Chọn tab **Import**
3. Chọn file database.sql để tạo các dữ liệu mẫu
4. Nhấn **Import** ở cuối trang để chạy import

> Nếu đã import database.sql thì có thể bỏ qua bước migrate ở dưới.

### Bước 4: Cấu hình Django kết nối MySQL

Kiểm tra file [expense_tracker/settings.py](expense_tracker/settings.py) đã có cấu hình:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'expense_tracker',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        }
    }
}
```

> Nếu có mật khẩu cho MySQL, hãy cập nhật trường `PASSWORD`.

### Bước 5: Migrate database

```bash
python manage.py migrate
```

### (Tuỳ chọn) Tạo tài khoản admin

```bash
bỏ qua bước này, vì trong database.sql đã insert tài khoản admin (mật khẩu admin) với các dữ liệu mẫu
python manage.py createsuperuser
```

## Chạy ứng dụng

```bash
cd expense_tracker
python manage.py runserver
```

Mở trình duyệt tại: http://127.0.0.1:8000/ và đăng nhập với tài khoản admin mặc định (user: admin, password: admin)

## Ghi chú

- Giao diện sử dụng Boxicons và Chart.js qua CDN (không cần cài thêm gói).
- Nếu thay đổi CSS, hãy refresh trình duyệt bằng Ctrl + F5 để xoá cache.
