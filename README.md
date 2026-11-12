# PTTKHTTT - Phân Hệ Quản Lý Thư Viện PTIT (Module 9)

Dự án môn học: **Phân tích và Thiết kế Hệ thống Thông tin (PTTKHTTT)** - Học viện Công nghệ Bưu chính Viễn thông (PTIT).

## 📌 Kiến trúc hệ thống
Mô hình chuẩn 3 lớp (3-tier architecture):
- **Tầng giao diện (Presentation Layer)**: JSP (kết hợp Scriptlet điều hướng nghiệp vụ thống kê).
- **Tầng truy cập dữ liệu (Data Access Layer)**: Các lớp DAO thuần Java (`DAO9`, `SupplierStatisticDAO9`, `ImportInvoiceStatDAO9`, `ReaderCardDAO9`).
- **Tầng cơ sở dữ liệu (Database Layer)**: MariaDB / MySQL (`library_ptit9`).

## 📁 Cấu trúc thư mục
```
LibraryCard9/
├── bandoc/                           # Phân hệ bạn đọc
│   ├── HomeFrm9.jsp                  # Giao diện chính bạn đọc
│   ├── RegisterCardFrm9.jsp          # Giao diện đăng ký làm thẻ bạn đọc
│   └── SuccessFrm9.jsp               # Giao diện đăng ký thành công
├── quanly/                           # Phân hệ quản lý thống kê
│   ├── ManagerHomeFrm9.jsp           # Giao diện chính nhân viên quản lý
│   ├── ReportMenuFrm9.jsp            # Giao diện chọn loại báo cáo
│   ├── StatSupplierFrm9.jsp          # Giao diện thống kê NCC theo SL nhập
│   ├── SupplierImportInvoiceFrm9.jsp # Giao diện danh sách hóa đơn nhập của NCC
│   └── InvoiceDetailFrm9.jsp         # Giao diện chi tiết hóa đơn nhập tài liệu
├── WEB-INF/
│   ├── src/dao/                      # Các lớp DAO thuần Java
│   ├── src/model/                    # Các lớp thực thể (Entities)
│   ├── src/servlet/                  # Servlet xử lý thẻ bạn đọc
│   ├── lib/                          # Driver mariadb-java-client-2.7.12.jar
│   └── web.xml                       # File cấu hình ứng dụng
├── database_library_ptit9.sql        # File CSDL mẫu đầy đủ (Import phpMyAdmin)
└── index.jsp                         # Điều hướng tự động
```

## 🚀 Hướng dẫn cài đặt & chạy
1. Import file `database_library_ptit9.sql` vào MariaDB / MySQL qua phpMyAdmin (database: `library_ptit9`, port 3306, user `root`, no password).
2. Deploy thư mục `LibraryCard9` vào thư mục `webapps` của Apache Tomcat (Tomcat 8.5+).
3. Khởi động Tomcat và truy cập:
   - Phân hệ bạn đọc: `http://localhost:8080/LibraryCard9/`
   - Phân hệ quản lý: `http://localhost:8080/LibraryCard9/quanly/ManagerHomeFrm9.jsp`
