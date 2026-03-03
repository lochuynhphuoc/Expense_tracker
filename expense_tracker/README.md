# MoneyFlow (Expense Tracker)

Ứng dụng quản lý chi tiêu cá nhân viết bằng Django, giao diện hiện đại, hỗ trợ biểu đồ, lọc chi tiêu, và modal CRUD để thao tác nhanh.

## Tính năng chính

- Dashboard tổng quan (KPI + biểu đồ)
- Thêm/Sửa/Xoá chi tiêu bằng modal
- Tìm kiếm, lọc theo thời gian, nhóm danh mục, số tiền, loại tiền
- Profile: tổng quan thói quen chi tiêu
- Settings: cấu hình ứng dụng (UI/UX, budget, smart features)
- Dark/Light mode

## Yêu cầu

- Python 3.10+ (khuyến nghị 3.11)
- pip
- MySQL (XAMPP + phpMyAdmin) nếu dùng cấu hình mặc định
- Trình duyệt Chrome/Edge để chạy giao diện

## Cấu trúc thư mục

```
expense_tracker/
├─ database.sql                  # Database mẫu
├─ manage.py                     # Lệnh quản lý Django
├─ requirements.txt              # Danh sách thư viện
├─ README.md                     # Tài liệu hướng dẫn
├─ settings.py                   # Thiết lập bổ sung
├─ .gitignore                    # Cấu hình Git bỏ qua các file/thư mục
├─ project_config/               # Package cấu hình dự án
│  ├─ __init__.py
│  ├─ settings.py                # Cấu hình chính
│  ├─ urls.py                    # URL root
│  ├─ wsgi.py                    # WSGI
│  └─ asgi.py                    # ASGI
└─ tracker/                      # App quản lý chi tiêu
   ├─ __init__.py
   ├─ apps.py                    # Cấu hình app
   ├─ models.py                  # Model dữ liệu
   ├─ forms.py                   # Form + validate
   ├─ views.py                   # Logic + render
   ├─ urls.py                    # URL app
   ├─ admin.py                   # Django Admin
   ├─ tests.py                   # Test (nếu có)
   ├─ migrations/                # Migration DB
  ├─ static/tracker/            # CSS, ảnh tĩnh
   │  └─ styles.css
   └─ templates/
      ├─ base.html               # Layout chung + navbar + modal
      ├─ tracker/                # Dashboard, Add/Edit, Profile, Settings
      └─ registration/           # Login/Register/Logout
```

## Cài đặt & chạy nhanh

### 1) Tạo môi trường ảo

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

### 2) Cài thư viện

```bash
pip install -r requirements.txt
```

> Nếu dùng MySQL, cần thêm driver:
>
> ```bash
> pip install mysqlclient
> ```

### 3) Thiết lập MySQL (XAMPP)

1. Bật Apache + MySQL trong XAMPP.
2. Mở phpMyAdmin: http://localhost/phpmyadmin
3. Tạo database `expense_tracker` với collation `utf8mb4_general_ci`.
4. Kiểm tra cấu hình DB trong [expense_tracker/project_config/settings.py](expense_tracker/project_config/settings.py).

### 4) Chạy app (chọn 1)

#### Cách 1: Tạo tài khoản admin mới, dữ liệu trống

- Bước 1: Tạo DB như trên, rồi chạy:

```bash
cd expense_tracker
python manage.py makemigrations
python manage.py migrate
```

- Bước 2: Tạo tài khoản admin:

```bash
python manage.py createsuperuser
```

- Bước 3: Chạy ứng dụng:

```bash
python manage.py runserver
```

#### Cách 2: Dùng database mẫu có sẵn dữ liệu

- Bước 1: Import [database.sql](database.sql) vào DB `expense_tracker` trong phpMyAdmin.
- Bước 2: Chạy ứng dụng:

```bash
cd expense_tracker
python manage.py runserver
```

Mở trình duyệt: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)

Tài khoản mẫu (nếu dùng cách 2 import database.sql):

- user: admin
- password: admin

## Lỗi thường gặp & cách xử lý nhanh

- `ModuleNotFoundError: No module named 'MySQLdb'`

  - Cài driver: `pip install mysqlclient`
  - Nếu lỗi build, cài Visual C++ Build Tools hoặc thử `pip install pymysql` và cấu hình lại.
- `Access denied for user 'root'@'localhost'`

  - Kiểm tra mật khẩu trong [expense_tracker/project_config/settings.py](expense_tracker/project_config/settings.py).
  - Đảm bảo MySQL đang chạy.
- Không thấy thay đổi CSS

  - Hard refresh: Ctrl + F5.
- Modal Add/Edit không hiển thị

  - Đảm bảo server đang chạy ở http://127.0.0.1:8000.

## Ghi chú

- Giao diện sử dụng Boxicons và Chart.js qua CDN.
- Nếu chỉnh CSS, refresh bằng Ctrl + F5 để tránh cache.

## Django được sử dụng như thế nào

- **Mô hình MVT**: `tracker/models.py` định nghĩa dữ liệu, `tracker/views.py` xử lý logic và trả về template trong `tracker/templates/`.
- **Routing**: `project_config/urls.py` gom URL toàn dự án, còn `tracker/urls.py` chứa các route chi tiêu.
- **ORM & migrations**: Model thao tác DB qua Django ORM, migrations nằm trong `tracker/migrations/`.
- **Auth & session**: Dùng sẵn `django.contrib.auth` cho login/logout, `CustomLoginView` để tuỳ biến.
- **Templates & static**: Giao diện dùng Django Template Language, CSS/ảnh đặt ở `tracker/static/tracker/`.
- **Form & validation**: Form trong `tracker/forms.py` giúp validate dữ liệu nhập.
