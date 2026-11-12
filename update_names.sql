SET NAMES utf8mb4;

-- 1. Cập nhật tên người thật cho tblUser9
UPDATE tblUser9 SET fullName = 'Nguyễn Tuấn Anh', email = 'tuananh.nguyen@ptit.edu.vn', address = 'Hà Đông, Hà Nội' WHERE id = 1;
UPDATE tblUser9 SET fullName = 'Nguyễn Thị Mai Phương', email = 'phuong.ntm@ptit.edu.vn', address = 'Thanh Xuân, Hà Nội' WHERE id = 2;
UPDATE tblUser9 SET fullName = 'Lê Minh Tuấn', email = 'tuan.lm@ptit.edu.vn', address = 'Cầu Giấy, Hà Nội' WHERE id = 3;
UPDATE tblUser9 SET fullName = 'Phạm Thị Lan Anh', email = 'lananh.pt@ptit.edu.vn', address = 'Hai Bà Trưng, Hà Nội' WHERE id = 4;

-- 2. Cập nhật tên người thật cho readers
UPDATE readers SET full_name = 'Đặng Hoàng Hải', email = 'haidh@ptit.edu.vn', address = 'Hà Đông, Hà Nội' WHERE id = 1;
UPDATE readers SET full_name = 'Bùi Thị Hải Yến', email = 'yenbth@ptit.edu.vn', address = 'Cầu Giấy, Hà Nội' WHERE id = 4;
UPDATE readers SET full_name = 'Hoàng Xuân Vinh', email = 'vinhhx@gmail.com', address = 'Tp. Vinh, Nghệ An' WHERE id = 5;

-- 3. Cập nhật bảng users
DELETE FROM users;
INSERT INTO users (id, username, password, full_name, date_of_birth, gender, address, email, phone, status) VALUES
(1, 'admin', 'admin123', 'Nguyễn Tuấn Anh', '1985-06-15', 'Nam', 'Hà Đông, Hà Nội', 'tuananh.nguyen@ptit.edu.vn', '0901111111', 'active'),
(2, 'lib01', 'lib123', 'Nguyễn Thị Mai Phương', '1990-03-22', 'Nữ', 'Thanh Xuân, Hà Nội', 'phuong.ntm@ptit.edu.vn', '0902222222', 'active'),
(3, 'lib02', 'lib123', 'Lê Minh Tuấn', '1992-11-08', 'Nam', 'Cầu Giấy, Hà Nội', 'tuan.lm@ptit.edu.vn', '0903333333', 'active'),
(4, 'lib03', 'lib123', 'Phạm Thị Lan Anh', '1995-09-14', 'Nữ', 'Hai Bà Trưng, Hà Nội', 'lananh.pt@ptit.edu.vn', '0904444444', 'active');