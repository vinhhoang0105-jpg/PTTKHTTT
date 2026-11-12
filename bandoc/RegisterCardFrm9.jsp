<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Reader9, model.ReaderCard9" %>
<%
    // Thuộc tính ẨN theo sơ đồ kiến trúc
    Reader9 r       = (Reader9)     session.getAttribute("reader");
    ReaderCard9 rc  = (ReaderCard9) request.getAttribute("readerCard");
    String errorMsg = (String)      request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Làm Thẻ Bạn Đọc - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', Arial, sans-serif; }
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
        }
        .card {
            width: 100%;
            max-width: 580px;
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 16px 32px rgba(0,0,0,0.06);
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        .header {
            background: linear-gradient(135deg, #16a34a, #15803d);
            color: #ffffff;
            text-align: center;
            padding: 12px 20px;
            font-size: 13.5px;
            font-weight: 700;
            letter-spacing: 0.6px;
            text-transform: uppercase;
        }
        .body { padding: 18px 24px 22px; }
        .alert-error {
            margin-bottom: 12px;
            padding: 8px 12px;
            background: #fef2f2;
            border-left: 3px solid #ef4444;
            border-radius: 6px;
            color: #b91c1c;
            font-size: 12px;
            font-weight: 600;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px 14px;
        }
        .form-col-full { grid-column: span 2; }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .form-group label {
            font-size: 12px;
            font-weight: 600;
            color: #475569;
        }
        .required-star { color: #ef4444; font-weight: bold; }
        .input-control {
            width: 100%;
            height: 35px;
            padding: 4px 10px;
            font-size: 13px;
            color: #0f172a;
            background: #ffffff;
            border: 1.5px solid #cbd5e1;
            border-radius: 7px;
            outline: none;
            transition: border-color 0.15s ease;
        }
        .input-control:focus {
            border-color: #16a34a;
            box-shadow: 0 0 0 2px rgba(22,163,74,0.12);
        }
        select.input-control {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 14px;
            cursor: pointer;
        }
        /* Khu vực upload ảnh gọn nhẹ */
        .photo-upload-row {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 6px 10px;
            border: 1px dashed #cbd5e1;
            border-radius: 7px;
            background: #f8fafc;
        }
        .avatar-thumb {
            width: 32px;
            height: 38px;
            border-radius: 4px;
            border: 1px solid #cbd5e1;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            font-size: 10px;
            color: #94a3b8;
        }
        .avatar-thumb img { width: 100%; height: 100%; object-fit: cover; display: none; }
        .custom-file-btn {
            padding: 5px 12px;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 600;
            color: #334155;
            cursor: pointer;
            white-space: nowrap;
        }
        .custom-file-btn:hover { background: #f1f5f9; }
        .file-hint { font-size: 11px; color: #64748b; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        input[type="file"].hidden-file-input { display: none; }
        /* Nút hành động */
        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 14px;
            padding-top: 12px;
            border-top: 1px solid #f1f5f9;
        }
        .btn {
            flex: 1;
            height: 36px;
            font-size: 13px;
            font-weight: 700;
            border-radius: 7px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.15s ease;
            text-decoration: none;
            border: none;
        }
        /* btnCancel : button */
        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
        }
        .btn-cancel:hover { background: #e2e8f0; color: #0f172a; }
        /* btnAdd : submit */
        .btn-add {
            background: #fef08a;
            color: #78350f;
            border: 2px solid #ca8a04;
        }
        .btn-add:hover {
            background: #fde047;
            border-color: #a16207;
            box-shadow: 0 4px 10px rgba(202,138,4,0.2);
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="header">GIAO DIỆN ĐĂNG KÝ LÀM THẺ BẠN ĐỌC</div>

        <div class="body">
            <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
                <div class="alert-error">⚠ <%= errorMsg %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/RegisterCardServlet9"
                  method="post" enctype="multipart/form-data">

                <div class="form-grid">
                    <!-- txtFullName : text -->
                    <div class="form-group">
                        <label for="txtFullName">Họ và tên bạn đọc <span class="required-star">*</span></label>
                        <input type="text" id="txtFullName" name="txtFullName" class="input-control"
                               placeholder="Ví dụ: Nguyễn Văn An"
                               value="<%= (rc != null && rc.getReader() != null && rc.getReader().getFullName() != null) ? rc.getReader().getFullName() : "" %>"
                               required />
                    </div>

                    <!-- txtDateOfBirth : text -->
                    <div class="form-group">
                        <label for="txtDateOfBirth">Ngày sinh</label>
                        <input type="text" id="txtDateOfBirth" name="txtDateOfBirth" class="input-control"
                               placeholder="dd/MM/yyyy" />
                    </div>

                    <!-- selectGender : select -->
                    <div class="form-group">
                        <label for="selectGender">Giới tính</label>
                        <select id="selectGender" name="selectGender" class="input-control">
                            <option value="Nam">Nam</option>
                            <option value="Nu">Nữ</option>
                            <option value="Khac">Khác</option>
                        </select>
                    </div>

                    <!-- txtPhone : text -->
                    <div class="form-group">
                        <label for="txtPhone">Số điện thoại</label>
                        <input type="text" id="txtPhone" name="txtPhone" class="input-control"
                               placeholder="0912345678"
                               value="<%= (rc != null && rc.getReader() != null && rc.getReader().getPhone() != null) ? rc.getReader().getPhone() : "" %>" />
                    </div>

                    <!-- txtEmail : text -->
                    <div class="form-group">
                        <label for="txtEmail">Email liên hệ <span class="required-star">*</span></label>
                        <input type="email" id="txtEmail" name="txtEmail" class="input-control"
                               placeholder="student@ptit.edu.vn"
                               value="<%= (rc != null && rc.getReader() != null && rc.getReader().getEmail() != null) ? rc.getReader().getEmail() : "" %>"
                               required />
                    </div>

                    <!-- selectCardType : select -->
                    <div class="form-group">
                        <label for="selectCardType">Loại thẻ bạn đọc</label>
                        <select id="selectCardType" name="selectCardType" class="input-control">
                            <option value="Sinh vien" <%= (rc != null && "Sinh vien".equals(rc.getCardType())) ? "selected" : "" %>>Sinh viên chính quy</option>
                            <option value="Giang vien" <%= (rc != null && "Giang vien".equals(rc.getCardType())) ? "selected" : "" %>>Cán bộ / Giảng viên</option>
                            <option value="Nhan vien" <%= (rc != null && "Nhan vien".equals(rc.getCardType())) ? "selected" : "" %>>Nhân viên</option>
                            <option value="Hoc vien" <%= (rc != null && "Hoc vien".equals(rc.getCardType())) ? "selected" : "" %>>Học viên cao học</option>
                        </select>
                    </div>

                    <!-- txtAddress : text -->
                    <div class="form-group form-col-full">
                        <label for="txtAddress">Địa chỉ thường trú</label>
                        <input type="text" id="txtAddress" name="txtAddress" class="input-control"
                               placeholder="Km10, Đường Nguyễn Trãi, Hà Đông, Hà Nội"
                               value="<%= (rc != null && rc.getReader() != null && rc.getReader().getAddress() != null) ? rc.getReader().getAddress() : "" %>" />
                    </div>

                    <!-- txtPortraitImage : file (upload ảnh thẻ gọn nhẹ) -->
                    <div class="form-group form-col-full">
                        <label for="txtPortraitImage">Ảnh thẻ 3×4 (tùy chọn)</label>
                        <div class="photo-upload-row">
                            <div class="avatar-thumb">
                                <img id="imgPreview" src="#" alt="Preview" />
                                <span id="placeholderText">Ảnh</span>
                            </div>
                            <label for="txtPortraitImage" class="custom-file-btn">Chọn ảnh</label>
                            <input type="file" id="txtPortraitImage" name="txtPortraitImage"
                                   class="hidden-file-input" accept="image/*" onchange="previewPortrait(this)" />
                            <span id="uploadLabel" class="file-hint">JPG, PNG (tối đa 5 MB)</span>
                        </div>
                    </div>
                </div>

                <!-- btnCancel & btnAdd theo sơ đồ lớp -->
                <div class="form-actions">
                    <button type="button" id="btnCancel" class="btn btn-cancel"
                            onclick="window.location.href='${pageContext.request.contextPath}/bandoc/HomeFrm9.jsp'">
                        HỦY
                    </button>
                    <button type="submit" id="btnAdd" class="btn btn-add">
                        THÊM
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewPortrait(input) {
            const preview     = document.getElementById('imgPreview');
            const placeholder = document.getElementById('placeholderText');
            const uploadLabel = document.getElementById('uploadLabel');
            if (input.files && input.files[0]) {
                const file = input.files[0];
                uploadLabel.textContent = file.name;
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    placeholder.style.display = 'none';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
                placeholder.style.display = 'block';
                uploadLabel.textContent = 'JPG, PNG (tối đa 5 MB)';
            }
        }
    </script>
</body>
</html>
