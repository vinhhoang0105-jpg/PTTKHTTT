<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager9" %>
<%
    Manager9 manager = (Manager9) session.getAttribute("manager");
    if (manager == null) { response.sendRedirect("ManagerHomeFrm9.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Mục Báo Cáo - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Plus Jakarta Sans',Arial,sans-serif}
        body{min-height:100vh;background:linear-gradient(135deg,#f1f5f9,#e2e8f0);display:flex;align-items:center;justify-content:center;padding:24px}
        .card{width:100%;max-width:560px;background:#fff;border-radius:18px;box-shadow:0 20px 40px rgba(0,0,0,.08);overflow:hidden;border:1px solid #e2e8f0}
        .header{background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;text-align:center;padding:14px 24px;font-size:15px;font-weight:700;letter-spacing:.8px;text-transform:uppercase}
        .body{padding:36px 44px}
        .section-title{font-size:13px;font-weight:600;color:#64748b;text-transform:uppercase;letter-spacing:.8px;margin-bottom:20px;text-align:center}
        .menu-list{display:flex;flex-direction:column;gap:14px}
        /* btnStatSupplier: submit - theo sơ đồ lớp ReportMenuFrm9 */
        .menu-btn{display:flex;align-items:center;gap:14px;padding:16px 20px;background:#fef9c3;border:2px solid #ca8a04;color:#78350f;font-size:14px;font-weight:700;border-radius:10px;text-decoration:none;cursor:pointer;transition:all .2s;width:100%}
        .menu-btn:hover{background:#fde047;transform:translateX(4px);box-shadow:4px 4px 12px rgba(202,138,4,.2)}
        .menu-btn .icon{width:40px;height:40px;background:rgba(202,138,4,.12);border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
        .menu-btn .icon svg{width:22px;height:22px;color:#ca8a04}
        .menu-btn .text small{display:block;font-weight:400;font-size:12px;color:#92400e;margin-top:2px}
        .menu-btn .arrow{margin-left:auto;font-size:18px;opacity:.6}
        .back-btn{display:inline-flex;align-items:center;gap:8px;margin-top:28px;padding:10px 20px;background:#f1f5f9;border:1px solid #cbd5e1;color:#475569;font-size:13px;font-weight:600;border-radius:8px;text-decoration:none;transition:all .2s}
        .back-btn:hover{background:#e2e8f0}
    </style>
</head>
<body>
<div class="card">
    <div class="header">GIAO DIỆN XEM THỐNG KÊ</div>
    <div class="body">
        <div class="section-title">Chọn loại báo cáo thống kê</div>

        <div class="menu-list">
            <!-- Thống kê tài liệu theo số lần mượn -->
            <a href="#" class="menu-btn">
                <div class="icon"><svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg></div>
                <div class="text">Thống kê tài liệu theo số lần mượn<small>Xếp hạng tài liệu được mượn nhiều nhất</small></div>
                <span class="arrow">›</span>
            </a>

            <!-- Thống kê bạn đọc theo số lần mượn -->
            <a href="#" class="menu-btn">
                <div class="icon"><svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg></div>
                <div class="text">Thống kê bạn đọc theo số lần mượn<small>Xếp hạng bạn đọc tích cực nhất</small></div>
                <span class="arrow">›</span>
            </a>

            <!-- btnStatSupplier: submit - theo sơ đồ lớp ReportMenuFrm9 -->
            <a href="StatSupplierFrm9.jsp" id="btnStatSupplier" class="menu-btn" style="background:#dcfce7;border-color:#16a34a;color:#14532d">
                <div class="icon" style="background:rgba(22,163,74,.12)"><svg fill="none" viewBox="0 0 24 24" stroke="currentColor" style="color:#16a34a"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/></svg></div>
                <div class="text" style="color:#14532d">Thống kê nhà cung cấp theo số lượng nhập<small style="color:#166534">Thống kê NCC theo tổng số lượng tài liệu nhập</small></div>
                <span class="arrow" style="color:#16a34a">›</span>
            </a>
        </div>

        <a href="ManagerHomeFrm9.jsp" class="back-btn">← Quay lại trang chủ</a>
    </div>
</div>
</body>
</html>

