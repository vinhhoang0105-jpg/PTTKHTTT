<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager9" %>
<%
    // Khởi tạo manager mặc định nếu chưa có session
    Manager9 manager = (Manager9) session.getAttribute("manager");
    if (manager == null) {
        manager = new Manager9();
        manager.setId(1);
        manager.setFullName("Trần Văn Quản Lý");
        manager.setUsername("admin");
        session.setAttribute("manager", manager);
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ Quản Lý - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Plus Jakarta Sans',Arial,sans-serif}
        body{min-height:100vh;background:linear-gradient(135deg,#f1f5f9,#e2e8f0);display:flex;align-items:center;justify-content:center;padding:24px}
        .card{width:100%;max-width:520px;background:#fff;border-radius:18px;box-shadow:0 20px 40px rgba(0,0,0,.08);overflow:hidden;border:1px solid #e2e8f0}
        .header{background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;text-align:center;padding:14px 24px;font-size:15px;font-weight:700;letter-spacing:.8px;text-transform:uppercase}
        .body{padding:48px 44px;text-align:center}
        .avatar{width:72px;height:72px;background:#f0fdf4;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;box-shadow:0 0 0 8px rgba(22,163,74,.07)}
        .avatar svg{width:36px;height:36px;color:#16a34a}
        .welcome{font-size:13px;color:#64748b;margin-bottom:4px}
        .manager-name{font-size:20px;font-weight:800;color:#0f172a;margin-bottom:28px}
        /* viewReportMenu : link (theo sơ đồ lớp) */
        .btn-report{display:inline-flex;align-items:center;justify-content:center;gap:12px;width:100%;padding:16px;background:#fef08a;border:2px solid #ca8a04;color:#78350f;font-size:15px;font-weight:700;border-radius:10px;text-decoration:none;cursor:pointer;transition:all .2s}
        .btn-report:hover{background:#fde047;transform:translateY(-2px);box-shadow:0 6px 16px rgba(202,138,4,.25)}
        .btn-report svg{width:20px;height:20px}
        .divider{height:1px;background:#f1f5f9;margin:28px 0}
        .info-row{display:flex;justify-content:center;gap:32px}
        .info-item .num{font-size:18px;font-weight:800;color:#16a34a}
        .info-item .lbl{font-size:11px;color:#94a3b8;margin-top:2px}
    </style>
</head>
<body>
<div class="card">
    <div class="header">TRANG CHỦ</div>
    <div class="body">
        <div class="avatar">
            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        </div>
        <div class="welcome">Chào mừng, Nhân viên Quản lý</div>
        <div class="manager-name"><%= manager.getFullName() %></div>

        <!-- viewReportMenu: link - Theo sơ đồ lớp ManagerHomeFrm9 -->
        <a href="ReportMenuFrm9.jsp" id="viewReportMenu" class="btn-report">
            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/></svg>
            Xem thống kê
        </a>

        <div class="divider"></div>
        <div class="info-row">
            <div class="info-item"><div class="num">NCC</div><div class="lbl">Nhà cung cấp</div></div>
            <div class="info-item"><div class="num">HĐN</div><div class="lbl">Hóa đơn nhập</div></div>
            <div class="info-item"><div class="num">TL</div><div class="lbl">Tài liệu</div></div>
        </div>
    </div>
</div>
</body>
</html>

