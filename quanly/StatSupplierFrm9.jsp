<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.SupplierStatisticDAO9, java.util.*, java.text.*, java.sql.Date" %>
<%
/* ════════════════════════════════════════════════════════════════
   StatSupplierFrm9.jsp — Thống kê nhà cung cấp theo SL nhập
   THUỘC TÍNH (theo sơ đồ lớp):
   ── Không ẩn (UI hiển thị) ──────────────────────────────────
     txtStartDate   : text   – ô nhập ngày bắt đầu
     txtEndDate     : text   – ô nhập ngày kết thúc
     btnStat        : submit – nút "Thống kê"
     fblSupplierStat: table  – bảng kết quả
     viewImportInvoice: link – mã NCC clickable → SupplierImportInvoiceFrm9
     btnBack        : submit – nút "Quay lại"
   ── Ẩn (Java / session) ─────────────────────────────────────
     manager        : Manager9         (session)
     lstSupplierStat: SupplierStatistic9[] (biến Java, không render thẳng)
   ════════════════════════════════════════════════════════════════ */

    // ── Thuộc tính ẨN: manager (session) ────────────────────────
    Manager9 manager = (Manager9) session.getAttribute("manager");
    if (manager == null) {
        manager = new Manager9();
        manager.setId(1);
        manager.setFullName("Trần Văn Quản Lý");
        session.setAttribute("manager", manager);
    }

    // ── Lấy giá trị từ form (txtStartDate, txtEndDate) ──────────
    String txtStartDate = request.getParameter("txtStartDate");
    String txtEndDate   = request.getParameter("txtEndDate");
    if (txtStartDate == null) txtStartDate = (String) session.getAttribute("startDateStr");
    if (txtEndDate   == null) txtEndDate   = (String) session.getAttribute("endDateStr");
    if (txtStartDate == null) txtStartDate = "";
    if (txtEndDate   == null) txtEndDate   = "";

    // ── Thuộc tính ẨN: lstSupplierStat (gọi DAO trực tiếp khi POST) ──
    List<SupplierStatistic9> lstSupplierStat = null;
    String errorMsg = null;

    if ("POST".equalsIgnoreCase(request.getMethod()) &&
        !txtStartDate.isEmpty() && !txtEndDate.isEmpty()) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.setLenient(true);
            Date startDate = new Date(sdf.parse(txtStartDate.trim()).getTime());
            Date endDate   = new Date(sdf.parse(txtEndDate.trim()).getTime());
            if (startDate.after(endDate)) {
                errorMsg = "Ngày bắt đầu phải trước ngày kết thúc!";
            } else {
                // ── Gọi DAO9: SupplierStatisticDAO9.getSupplierStatistic() ──
                SupplierStatisticDAO9 dao = new SupplierStatisticDAO9();
                lstSupplierStat = dao.getSupplierStatistic(startDate, endDate);
                // Lưu vào session để SupplierImportInvoiceFrm9 dùng
                session.setAttribute("startDate",    startDate);
                session.setAttribute("endDate",      endDate);
                session.setAttribute("startDateStr", txtStartDate);
                session.setAttribute("endDateStr",   txtEndDate);
                session.setAttribute("lstSupplierStat", lstSupplierStat);
            }
        } catch (Exception e) {
            errorMsg = "Định dạng ngày không hợp lệ! Vui lòng nhập dd/MM/yyyy.";
        }
    } else {
        // GET: lấy từ session nếu có
        lstSupplierStat = (List<SupplierStatistic9>) session.getAttribute("lstSupplierStat");
    }

    int grandTotal = 0;
    if (lstSupplierStat != null)
        for (SupplierStatistic9 s : lstSupplierStat) grandTotal += s.getImportQuantity();
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống Kê Nhà Cung Cấp - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Plus Jakarta Sans',Arial,sans-serif}
        body{min-height:100vh;background:linear-gradient(135deg,#f1f5f9,#e2e8f0);display:flex;align-items:flex-start;justify-content:center;padding:30px 16px}
        .card{width:100%;max-width:800px;background:#fff;border-radius:18px;box-shadow:0 20px 40px rgba(0,0,0,.08);overflow:hidden;border:1px solid #e2e8f0}
        .header{background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;text-align:center;padding:14px 24px;font-size:14px;font-weight:700;letter-spacing:.8px;text-transform:uppercase}
        .body{padding:28px 36px}
        .filter-bar{display:flex;align-items:flex-end;gap:20px;padding:20px 24px;background:#f8fafc;border-radius:12px;border:1px solid #e2e8f0;margin-bottom:24px;flex-wrap:wrap}
        .field{display:flex;flex-direction:column;gap:6px;flex:1;min-width:160px}
        .field label{font-size:12px;font-weight:600;color:#475569;text-transform:uppercase;letter-spacing:.5px}
        .field input{height:40px;padding:0 12px;border:1.5px solid #cbd5e1;border-radius:8px;font-size:14px;outline:none;background:#fff;transition:border-color .2s}
        .field input:focus{border-color:#16a34a;box-shadow:0 0 0 3px rgba(22,163,74,.12)}
        /* btnStat: submit */
        #btnStat{height:40px;padding:0 24px;background:#fef08a;border:2px solid #ca8a04;color:#78350f;font-size:14px;font-weight:700;border-radius:8px;cursor:pointer;white-space:nowrap;transition:all .2s}
        #btnStat:hover{background:#fde047;transform:translateY(-1px)}
        .alert{padding:12px 16px;background:#fef2f2;border-left:4px solid #ef4444;border-radius:8px;color:#b91c1c;font-size:13px;margin-bottom:20px}
        /* fblSupplierStat: table */
        #fblSupplierStat{width:100%;border-collapse:collapse}
        .table-wrap{border-radius:10px;overflow:hidden;border:1.5px solid #e2e8f0;margin-bottom:20px}
        thead tr{background:#16a34a;color:#fff}
        thead th{padding:12px 14px;font-size:13px;font-weight:700;text-align:center;letter-spacing:.3px}
        thead th:nth-child(3){text-align:left}
        tbody tr{border-bottom:1px solid #f1f5f9;transition:background .15s}
        tbody tr:last-child{border-bottom:none}
        tbody tr:hover{background:#f0fdf4}
        td{padding:11px 14px;font-size:13px;color:#334155;text-align:center}
        td.name-col{text-align:left;font-weight:600;color:#0f172a}
        /* viewImportInvoice: link */
        td a.supplier-link{color:#0f172a;font-weight:700;text-decoration:none;padding:4px 10px;background:#dcfce7;border-radius:6px;border:1px solid #bbf7d0;transition:all .2s;display:inline-block}
        td a.supplier-link:hover{background:#16a34a;color:#fff;border-color:#16a34a}
        .qty-badge{display:inline-block;background:#eff6ff;color:#1d4ed8;font-weight:700;padding:3px 10px;border-radius:20px;font-size:13px}
        .footer-row td{background:#f8fafc;font-weight:700;color:#0f172a;border-top:2px solid #e2e8f0}
        .action-bar{display:flex;align-items:center;justify-content:space-between;margin-top:4px;flex-wrap:wrap;gap:12px}
        /* btnBack: submit */
        #btnBack{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:#fef9c3;border:2px solid #ca8a04;color:#78350f;font-size:13px;font-weight:700;border-radius:8px;cursor:pointer;text-decoration:none;transition:all .2s}
        #btnBack:hover{background:#fde047}
        .result-info{font-size:13px;color:#64748b}
        .empty-state{text-align:center;padding:40px;color:#94a3b8;font-size:14px}
    </style>
</head>
<body>
<div class="card">
    <div class="header">GIAO DIỆN THỐNG KÊ NHÀ CUNG CẤP THEO SỐ LƯỢNG NHẬP</div>
    <div class="body">

        <%-- Form txtStartDate, txtEndDate, btnStat — POST về chính JSP này --%>
        <form action="StatSupplierFrm9.jsp" method="post">
            <div class="filter-bar">
                <div class="field">
                    <label>NGÀY BẮT ĐẦU</label>
                    <%-- txtStartDate: text (KHÔNG ẨN) --%>
                    <input type="text" name="txtStartDate" id="txtStartDate"
                           placeholder="dd/MM/yyyy" value="<%= txtStartDate %>" />
                </div>
                <div class="field">
                    <label>NGÀY KẾT THÚC</label>
                    <%-- txtEndDate: text (KHÔNG ẨN) --%>
                    <input type="text" name="txtEndDate" id="txtEndDate"
                           placeholder="dd/MM/yyyy" value="<%= txtEndDate %>" />
                </div>
                <%-- btnStat: submit (KHÔNG ẨN) --%>
                <button type="submit" id="btnStat">Thống kê</button>
            </div>
        </form>

        <% if (errorMsg != null) { %>
            <div class="alert">⚠ <%= errorMsg %></div>
        <% } %>

        <%-- fblSupplierStat: table (KHÔNG ẨN) --%>
        <div class="table-wrap">
            <table id="fblSupplierStat">
                <thead>
                    <tr>
                        <th style="width:50px">STT</th>
                        <th style="width:90px">Mã NCC</th>
                        <th>Tên NCC</th>
                        <th style="width:130px">Tổng SL nhập</th>
                    </tr>
                </thead>
                <tbody>
                <% if (lstSupplierStat == null || lstSupplierStat.isEmpty()) { %>
                    <tr><td colspan="4" class="empty-state">
                        <% if (lstSupplierStat != null) { %>
                            Không có dữ liệu trong khoảng thời gian đã chọn.
                        <% } else { %>
                            Nhập khoảng thời gian và nhấn <strong>Thống kê</strong>.
                        <% } %>
                    </td></tr>
                <% } else {
                       int stt = 1;
                       for (SupplierStatistic9 stat : lstSupplierStat) {
                           Supplier9 sup = stat.getSupplier();
                %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td>
                            <%-- viewImportInvoice: link (KHÔNG ẨN) — trỏ thẳng vào JSP --%>
                            <a href="SupplierImportInvoiceFrm9.jsp?supplierId=<%= sup.getId() %>&supplierName=<%= java.net.URLEncoder.encode(sup.getSupplierName(),"UTF-8") %>"
                               id="viewImportInvoice" class="supplier-link"
                               title="Xem hóa đơn nhập của nhà cung cấp này">
                               NCC<%= String.format("%03d", sup.getId()) %>
                            </a>
                        </td>
                        <td class="name-col"><%= sup.getSupplierName() %></td>
                        <td><span class="qty-badge"><%= df.format(stat.getImportQuantity()) %></span></td>
                    </tr>
                <%     }
                   } %>
                <% if (lstSupplierStat != null && !lstSupplierStat.isEmpty()) { %>
                    <tr class="footer-row">
                        <td colspan="3" style="text-align:right;padding-right:20px">Tổng số lượng:</td>
                        <td><span class="qty-badge" style="background:#dcfce7;color:#15803d"><%= df.format(grandTotal) %></span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="action-bar">
            <%-- btnBack: submit (KHÔNG ẨN) --%>
            <a href="ReportMenuFrm9.jsp" id="btnBack">◀ QUAY LẠI</a>
            <% if (lstSupplierStat != null && !lstSupplierStat.isEmpty()) { %>
                <span class="result-info">Tìm thấy <strong><%= lstSupplierStat.size() %></strong>
                    NCC từ <strong><%= txtStartDate %></strong> đến <strong><%= txtEndDate %></strong></span>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
