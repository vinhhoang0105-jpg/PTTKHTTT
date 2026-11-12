<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Reader9" %>
<%
    // Thuộc tính ẨN: reader (session)
    Reader9 r = (Reader9) session.getAttribute("reader");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Thư Viện PTIT</title>
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
            max-width: 440px;
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
            padding: 32px 28px 28px;
            text-align: center;
        }
        .icon-circle {
            width: 60px;
            height: 60px;
            background: #f0fdf4;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            color: #16a34a;
            box-shadow: 0 0 0 6px rgba(22,163,74,0.08);
        }
        .icon-circle svg { width: 30px; height: 30px; }
        .welcome-title {
            font-size: 18px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 22px;
        }
        /* viewRegisterCard : link - đúng sơ đồ lớp */
        .btn-register-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 13px 20px;
            background: #fef08a;
            color: #78350f;
            border: 2px solid #ca8a04;
            border-radius: 9px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-register-link:hover {
            background: #fde047;
            border-color: #a16207;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(202,138,4,0.2);
        }
        .btn-register-link svg { width: 18px; height: 18px; }
    </style>
</head>
<body>
    <div class="card">
        <!-- Header xanh lá đơn giản, gọn gàng theo chuẩn giao diện thống kê -->
        <div class="header">TRANG CHỦ THƯ VIỆN</div>

        <div class="body">
            <div class="icon-circle">
                <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
            </div>

            <div class="welcome-title">Cổng Đăng Ký Thẻ Bạn Đọc</div>

            <!-- viewRegisterCard: link (Sơ đồ lớp) -->
            <a href="${pageContext.request.contextPath}/bandoc/RegisterCardFrm9.jsp"
               id="viewRegisterCard" class="btn-register-link">
                <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2" />
                </svg>
                <span>Đăng ký làm thẻ bạn đọc</span>
            </a>
        </div>
    </div>
</body>
</html>
