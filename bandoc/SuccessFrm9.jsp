<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Reader9, model.ReaderCard9" %>
<%
    // Thuộc tính ẨN: reader, readerCard
    Reader9 r       = (Reader9)     request.getAttribute("reader");
    ReaderCard9 rdc = (ReaderCard9) request.getAttribute("readerCard");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Thành Công - PTIT</title>
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
            max-width: 420px;
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
            padding: 13px 20px;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.6px;
            text-transform: uppercase;
        }
        .body {
            padding: 30px 24px 26px;
            text-align: center;
        }
        .icon-circle {
            width: 56px;
            height: 56px;
            background: #ecfdf5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px;
            color: #10b981;
            box-shadow: 0 0 0 6px rgba(16,185,129,0.08);
        }
        .icon-circle svg { width: 30px; height: 30px; stroke-width: 2.5; }
        .title {
            font-size: 17px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 22px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        /* btnOK : submit - đúng sơ đồ lớp */
        .btn-ok {
            width: 100%;
            height: 38px;
            background: #fef08a;
            color: #78350f;
            border: 2px solid #ca8a04;
            font-size: 14px;
            font-weight: 700;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .btn-ok:hover {
            background: #fde047;
            border-color: #a16207;
            box-shadow: 0 4px 10px rgba(202,138,4,0.2);
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="header">THÔNG BÁO</div>
        <div class="body">
            <div class="icon-circle">
                <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                </svg>
            </div>
            <div class="title">ĐĂNG KÝ THÀNH CÔNG</div>

            <!-- btnOK: submit (Theo sơ đồ lớp) -->
            <form action="${pageContext.request.contextPath}/bandoc/HomeFrm9.jsp" method="get">
                <button type="submit" id="btnOK" class="btn-ok">
                    OK
                </button>
            </form>
        </div>
    </div>
</body>
</html>
