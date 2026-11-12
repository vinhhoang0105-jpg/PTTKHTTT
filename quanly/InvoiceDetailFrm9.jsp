<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.ImportInvoiceStatDAO9, java.util.*, java.text.*" %>
<%
/* ════════════════════════════════════════════════════════════════
   InvoiceDetailFrm9.jsp — Chi tiết hóa đơn nhập
   THUỘC TÍNH (theo sơ đồ lớp):
   ── Không ẩn (UI hiển thị) ──────────────────────────────────
     tbllistInvoiceDetail : table  – bảng chi tiết tài liệu
     btnBack              : submit – nút "Quay lại"
   ── Ẩn (input hidden / session / biến Java) ─────────────────
     importInvoice : ImportInvoice9  (biến Java, gọi DAO)
     manager       : Manager9        (session)
   ════════════════════════════════════════════════════════════════ */

    // ── Thuộc tính ẨN: manager (session) ────────────────────────
    Manager9 manager = (Manager9) session.getAttribute("manager");
    if (manager == null) { response.sendRedirect("ManagerHomeFrm9.jsp"); return; }

    // ── Lấy invoiceId từ URL param ───────────────────────────────
    String invoiceIdStr = request.getParameter("invoiceId");
    if (invoiceIdStr == null) { response.sendRedirect("StatSupplierFrm9.jsp"); return; }

    // ── Thuộc tính ẨN: importInvoice: ImportInvoice9 (gọi DAO) ──
    ImportInvoiceStatDAO9 dao = new ImportInvoiceStatDAO9();
    ImportInvoice9 importInvoice = dao.getImportInvoiceDetail(Integer.parseInt(invoiceIdStr));
    if (importInvoice == null) { response.sendRedirect("StatSupplierFrm9.jsp"); return; }

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");

    List<ImportInvoiceDetail9> details = importInvoice.getImportInvoiceDetail();
    if (details == null) details = new ArrayList<>();

    // Tính tổng từ detail rows (đây là giá trị chính xác)
    int    totalQty = 0;
    double totalAmt = 0;
    for (ImportInvoiceDetail9 d : details) {
        totalQty += d.getQuantity();
        totalAmt += d.getAmount();
    }

    String supplierCode = importInvoice.getSupplier() != null
        ? String.format("NCC%03d — %s", importInvoice.getSupplier().getId(), importInvoice.getSupplier().getSupplierName()) : "---";
    String libName    = importInvoice.getLibrarian() != null ? importInvoice.getLibrarian().getFullName() : "---";
    String dateStr    = importInvoice.getImportDate() != null ? sdf.format(importInvoice.getImportDate()) : "---";
    String invoiceCode = String.format("HD%04d", importInvoice.getId());

    // Lấy ngữ cảnh để btnBack quay lại đúng
    String currentSupplierId   = (String) session.getAttribute("currentSupplierId");
    String currentSupplierName = (String) session.getAttribute("currentSupplierName");
    String backUrl = "SupplierImportInvoiceFrm9.jsp";
    if (currentSupplierId != null) {
        backUrl += "?supplierId=" + currentSupplierId;
        if (currentSupplierName != null)
            backUrl += "&supplierName=" + java.net.URLEncoder.encode(currentSupplierName, "UTF-8");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Hóa Đơn - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Plus Jakarta Sans',Arial,sans-serif}
        body{min-height:100vh;background:linear-gradient(135deg,#f1f5f9,#e2e8f0);display:flex;align-items:flex-start;justify-content:center;padding:30px 16px}
        .card{width:100%;max-width:900px;background:#fff;border-radius:18px;box-shadow:0 20px 40px rgba(0,0,0,.08);overflow:hidden;border:1px solid #e2e8f0}
        .header{background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;text-align:center;padding:14px 24px;font-size:14px;font-weight:700;letter-spacing:.8px;text-transform:uppercase}
        .body{padding:28px 36px}
        .info-panel{background:#f8fafc;border:1px solid #e2e8f0;border-radius:12px;padding:18px 22px;margin-bottom:24px;display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .info-field .lbl{font-size:11px;font-weight:600;color:#64748b;text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px}
        .info-field .val{font-size:14px;font-weight:700;color:#0f172a}
        /* tbllistInvoiceDetail: table (KHÔNG ẨN) */
        .table-wrap{border-radius:10px;overflow:hidden;border:1.5px solid #e2e8f0;margin-bottom:20px}
        #tbllistInvoiceDetail{width:100%;border-collapse:collapse}
        thead tr{background:#16a34a;color:#fff}
        thead th{padding:12px 14px;font-size:13px;font-weight:700;text-align:center}
        thead th.left{text-align:left}
        tbody tr{border-bottom:1px solid #f1f5f9;transition:background .15s}
        tbody tr:last-child{border-bottom:none}
        tbody tr:hover{background:#f0fdf4}
        td{padding:11px 14px;font-size:13px;color:#334155;text-align:center}
        td.left{text-align:left;font-weight:600}
        td.doc-code{font-weight:700;background:#f0fdf4;color:#166534;padding:3px 8px;border-radius:5px;display:inline-block}
        .footer-row td{background:#f8fafc;border-top:2px solid #e2e8f0}
        .summary-bar{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:20px}
        .sum-box{background:#f0fdf4;border:1px solid #bbf7d0;border-radius:12px;padding:16px 20px;text-align:center}
        .sum-box .num{font-size:28px;font-weight:800;color:#16a34a}
        .sum-box .lbl{font-size:12px;color:#64748b;margin-top:4px}
        .action-bar{display:flex;align-items:center;gap:16px}
        /* btnBack: submit (KHÔNG ẨN) */
        #btnBack{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:#fef9c3;border:2px solid #ca8a04;color:#78350f;font-size:13px;font-weight:700;border-radius:8px;cursor:pointer;text-decoration:none;transition:all .2s}
        #btnBack:hover{background:#fde047}
        .empty-state{text-align:center;padding:40px;color:#94a3b8;font-size:14px}
    </style>
</head>
<body>
<div class="card">
    <div class="header">GIAO DIỆN CHI TIẾT HÓA ĐƠN NHẬP TÀI LIỆU</div>
    <div class="body">

        <%-- Thông tin hóa đơn — hiển thị từ importInvoice: ImportInvoice9 (ẨN) --%>
        <div class="info-panel">
            <div class="info-field">
                <div class="lbl">Mã Hóa Đơn</div>
                <div class="val"><%= invoiceCode %></div>
            </div>
            <div class="info-field">
                <div class="lbl">Mã NCC</div>
                <div class="val"><%= supplierCode %></div>
            </div>
            <div class="info-field">
                <div class="lbl">Ngày Nhập</div>
                <div class="val"><%= dateStr %></div>
            </div>
            <div class="info-field">
                <div class="lbl">NV Thực Hiện</div>
                <div class="val"><%= libName %></div>
            </div>
        </div>

        <%-- tbllistInvoiceDetail: table (KHÔNG ẨN) --%>
        <div class="table-wrap">
            <table id="tbllistInvoiceDetail">
                <thead>
                    <tr>
                        <th style="width:50px">STT</th>
                        <th style="width:90px">Mã tài liệu</th>
                        <th class="left">Tên tài liệu</th>
                        <th style="width:90px">Số lượng</th>
                        <th style="width:110px">Đơn giá (₫)</th>
                        <th style="width:120px">Thành tiền (₫)</th>
                    </tr>
                </thead>
                <tbody>
                <% if (details.isEmpty()) { %>
                    <tr><td colspan="6" class="empty-state">Không có tài liệu chi tiết.</td></tr>
                <% } else {
                       int stt = 1;
                       for (ImportInvoiceDetail9 det : details) {
                           Document9 doc = det.getDocument();
                           String docCode = doc != null ? String.format("TL%04d", doc.getId()) : "---";
                           String docTitle = doc != null ? doc.getTitle() : "---";
                %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td><span class="doc-code"><%= docCode %></span></td>
                        <td class="left"><%= docTitle %></td>
                        <td><%= df.format(det.getQuantity()) %></td>
                        <td><%= df.format((long) det.getUnitPrice()) %></td>
                        <td><strong><%= df.format((long) det.getAmount()) %></strong></td>
                    </tr>
                <%     }
                   } %>
                <% if (!details.isEmpty()) { %>
                    <tr class="footer-row">
                        <td colspan="3" style="text-align:right;padding-right:20px;font-weight:700">Tổng cộng:</td>
                        <td style="font-weight:700"><%= df.format(totalQty) %></td>
                        <td></td>
                        <td style="font-weight:700"><%= df.format((long) totalAmt) %> ₫</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>



        <%-- importInvoice: ImportInvoice9 (ẨN - biến Java) --%>
        <%-- manager: Manager9 (ẨN - session) --%>

        <div class="action-bar">
            <%-- btnBack: submit (KHÔNG ẨN) --%>
            <a href="<%= backUrl %>" id="btnBack">◀ QUAY LẠI</a>
        </div>
    </div>
</div>
</body>
</html>
