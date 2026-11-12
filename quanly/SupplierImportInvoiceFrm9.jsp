<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.ImportInvoiceStatDAO9, java.util.*, java.text.*, java.sql.Date" %>
<%
/* ════════════════════════════════════════════════════════════════
   SupplierImportInvoiceFrm9.jsp — Danh sách hóa đơn nhập của NCC
   THUỘC TÍNH (theo sơ đồ lớp):
   ── Không ẩn (UI hiển thị) ──────────────────────────────────
     tbllistImportInvoice  : table  – bảng danh sách hóa đơn
     viewImportInvoiceDetail: link  – mã hóa đơn → InvoiceDetailFrm9
     btnBack               : submit – nút "Quay lại"
   ── Ẩn (input hidden / session / biến Java) ─────────────────
     lstImportInvoice : ImportInvoice9[]  (biến Java)
     manager          : Manager9          (session)
     supplier         : Supplier9         (URL param + hidden field)
     startDate        : Date              (session + hidden field)
     endDate          : Date              (session + hidden field)
   ════════════════════════════════════════════════════════════════ */

    // ── Thuộc tính ẨN: manager (session) ────────────────────────
    Manager9 manager = (Manager9) session.getAttribute("manager");
    if (manager == null) { response.sendRedirect("ManagerHomeFrm9.jsp"); return; }

    // ── Thuộc tính ẨN: startDate, endDate (session) ─────────────
    Date   startDate    = (Date) session.getAttribute("startDate");
    Date   endDate      = (Date) session.getAttribute("endDate");
    String startDateStr = (String) session.getAttribute("startDateStr");
    String endDateStr   = (String) session.getAttribute("endDateStr");
    if (startDate == null || endDate == null) { response.sendRedirect("StatSupplierFrm9.jsp"); return; }

    // ── Thuộc tính ẨN: supplier (URL param) ─────────────────────
    String supplierIdStr  = request.getParameter("supplierId");
    String supplierNameP  = request.getParameter("supplierName");
    // Nếu không có param (reload), lấy từ session
    if (supplierIdStr == null) supplierIdStr = (String) session.getAttribute("currentSupplierId");
    if (supplierNameP == null) supplierNameP = (String) session.getAttribute("currentSupplierName");
    if (supplierIdStr == null) { response.sendRedirect("StatSupplierFrm9.jsp"); return; }

    int supplierId = Integer.parseInt(supplierIdStr);
    // Lưu vào session để InvoiceDetailFrm9 dùng khi QUAY LẠI
    session.setAttribute("currentSupplierId",   supplierIdStr);
    session.setAttribute("currentSupplierName", supplierNameP != null ? supplierNameP : "");

    // ── Thuộc tính ẨN: supplier: Supplier9 ──────────────────────
    Supplier9 supplier = new Supplier9();
    supplier.setId(supplierId);
    supplier.setSupplierName(supplierNameP != null ? supplierNameP : "");

    // ── Gọi DAO9: ImportInvoiceStatDAO9.getImportInvoiceBySupplier() ──
    ImportInvoiceStatDAO9 dao = new ImportInvoiceStatDAO9();
    // ── Thuộc tính ẨN: lstImportInvoice: ImportInvoice9[] ───────
    List<ImportInvoice9> lstImportInvoice = dao.getImportInvoiceBySupplier(startDate, endDate, supplierId);

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");
    int totalQty = 0; double totalAmt = 0;
    for (ImportInvoice9 inv : lstImportInvoice) {
        totalQty += inv.getTotalQuantity();
        totalAmt += inv.getTotalAmount();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa Đơn Nhập - PTIT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Plus Jakarta Sans',Arial,sans-serif}
        body{min-height:100vh;background:linear-gradient(135deg,#f1f5f9,#e2e8f0);display:flex;align-items:flex-start;justify-content:center;padding:30px 16px}
        .card{width:100%;max-width:900px;background:#fff;border-radius:18px;box-shadow:0 20px 40px rgba(0,0,0,.08);overflow:hidden;border:1px solid #e2e8f0}
        .header{background:linear-gradient(135deg,#16a34a,#15803d);color:#fff;text-align:center;padding:14px 24px;font-size:14px;font-weight:700;letter-spacing:.8px;text-transform:uppercase}
        .body{padding:28px 36px}
        .info-panel{background:#f8fafc;border:1px solid #e2e8f0;border-radius:12px;padding:18px 22px;margin-bottom:24px;display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px}
        .info-field .lbl{font-size:11px;font-weight:600;color:#64748b;text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px}
        .info-field .val{font-size:14px;font-weight:700;color:#0f172a}
        /* tbllistImportInvoice: table (KHÔNG ẨN) */
        .table-wrap{border-radius:10px;overflow:hidden;border:1.5px solid #e2e8f0;margin-bottom:20px}
        #tbllistImportInvoice{width:100%;border-collapse:collapse}
        thead tr{background:#16a34a;color:#fff}
        thead th{padding:12px 14px;font-size:13px;font-weight:700;text-align:center}
        thead th.left{text-align:left}
        tbody tr{border-bottom:1px solid #f1f5f9;transition:background .15s}
        tbody tr:last-child{border-bottom:none}
        tbody tr:hover{background:#f0fdf4}
        td{padding:11px 14px;font-size:13px;color:#334155;text-align:center}
        td.left{text-align:left}
        /* viewImportInvoiceDetail: link (KHÔNG ẨN) */
        td a.invoice-link{color:#0f172a;font-weight:700;text-decoration:none;padding:4px 10px;background:#fef9c3;border-radius:6px;border:1px solid #fde047;transition:all .2s;display:inline-block}
        td a.invoice-link:hover{background:#ca8a04;color:#fff;border-color:#ca8a04}
        .footer-row td{background:#f8fafc;font-weight:700;border-top:2px solid #e2e8f0}
        .action-bar{display:flex;align-items:center;gap:16px;flex-wrap:wrap}
        /* btnBack: submit (KHÔNG ẨN) */
        #btnBack{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;background:#fef9c3;border:2px solid #ca8a04;color:#78350f;font-size:13px;font-weight:700;border-radius:8px;cursor:pointer;text-decoration:none;transition:all .2s}
        #btnBack:hover{background:#fde047}
        .hint{font-size:13px;color:#64748b}
        .empty-state{text-align:center;padding:40px;color:#94a3b8;font-size:14px}
    </style>
</head>
<body>
<div class="card">
    <div class="header">GIAO DIỆN DANH SÁCH HÓA ĐƠN NHẬP THEO NHÀ CUNG CẤP</div>
    <div class="body">

        <%-- Thông tin NCC và khoảng thời gian --%>
        <div class="info-panel">
            <div class="info-field">
                <div class="lbl">Mã Nhà Cung Cấp</div>
                <div class="val">NCC<%= String.format("%03d", supplier.getId()) %></div>
            </div>
            <div class="info-field">
                <div class="lbl">Tên Nhà Cung Cấp</div>
                <div class="val"><%= supplier.getSupplierName() %></div>
            </div>
            <div class="info-field">
                <div class="lbl">Khoảng Thời Gian</div>
                <div class="val"><%= startDateStr %> → <%= endDateStr %></div>
            </div>
        </div>

        <%-- tbllistImportInvoice: table (KHÔNG ẨN) --%>
        <div class="table-wrap">
            <table id="tbllistImportInvoice">
                <thead>
                    <tr>
                        <th style="width:50px">STT</th>
                        <th style="width:120px">Mã hóa đơn</th>
                        <th style="width:120px">Ngày nhập</th>
                        <th class="left">NV thực hiện</th>
                        <th style="width:100px">Tổng SL</th>
                        <th style="width:130px">Tổng tiền (₫)</th>
                    </tr>
                </thead>
                <tbody>
                <% if (lstImportInvoice.isEmpty()) { %>
                    <tr><td colspan="6" class="empty-state">Không có hóa đơn trong khoảng thời gian này.</td></tr>
                <% } else {
                       int stt = 1;
                       for (ImportInvoice9 inv : lstImportInvoice) {
                           String libName = inv.getLibrarian() != null ? inv.getLibrarian().getFullName() : "N/A";
                           String dateStr = inv.getImportDate() != null ? sdf.format(inv.getImportDate()) : "---";
                %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td>
                            <%-- viewImportInvoiceDetail: link (KHÔNG ẨN) — trỏ thẳng vào JSP --%>
                            <a href="InvoiceDetailFrm9.jsp?invoiceId=<%= inv.getId() %>"
                               id="viewImportInvoiceDetail" class="invoice-link"
                               title="Xem chi tiết hóa đơn">
                               HD<%= String.format("%04d", inv.getId()) %>
                            </a>
                        </td>
                        <td><%= dateStr %></td>
                        <td class="left"><%= libName %></td>
                        <td><%= df.format(inv.getTotalQuantity()) %></td>
                        <td><%= df.format((long) inv.getTotalAmount()) %></td>
                    </tr>
                <%     }
                   } %>
                <% if (!lstImportInvoice.isEmpty()) { %>
                    <tr class="footer-row">
                        <td colspan="4" style="text-align:right;padding-right:20px">Tổng cộng:</td>
                        <td><%= df.format(totalQty) %></td>
                        <td><%= df.format((long) totalAmt) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <%-- Các thuộc tính ẨN dạng hidden field — truyền ngữ cảnh cho btnBack --%>
        <%-- supplier: Supplier9 (ẨN) --%>
        <%-- startDate: Date (ẨN) --%>
        <%-- endDate: Date (ẨN) --%>
        <%-- lstImportInvoice: ImportInvoice9[] (ẨN - biến Java) --%>
        <%-- manager: Manager9 (ẨN - session) --%>

        <div class="action-bar">
            <%-- btnBack: submit (KHÔNG ẨN) --%>
            <a href="StatSupplierFrm9.jsp" id="btnBack">◀ QUAY LẠI</a>
            <% if (!lstImportInvoice.isEmpty()) { %>
                <span class="hint">Nhấn vào <strong>Mã hóa đơn</strong> để xem chi tiết tài liệu</span>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
