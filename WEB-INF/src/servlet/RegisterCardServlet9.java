package servlet;

import dao.ReaderCardDAO9;
import model.Reader9;
import model.ReaderCard9;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * RegisterCardServlet9 – Servlet xử lý đăng ký thẻ bạn đọc
 * JSP nằm trong /bandoc/ nên forward dùng đường dẫn tuyệt đối context.
 */
@WebServlet("/RegisterCardServlet9")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,       // 1 MB
    maxFileSize       = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize    = 1024 * 1024 * 10   // 10 MB
)
public class RegisterCardServlet9 extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // ── 1. Lấy dữ liệu từ form ──────────────────────────────────────────
        String fullName    = request.getParameter("txtFullName");
        String dateOfBirth = request.getParameter("txtDateOfBirth");
        String phone       = request.getParameter("txtPhone");
        String email       = request.getParameter("txtEmail");
        String gender      = request.getParameter("selectGender");
        String address     = request.getParameter("txtAddress");
        String cardType    = request.getParameter("selectCardType");

        // ── 2. Validate ──────────────────────────────────────────────────────
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Vui lòng nhập họ và tên bạn đọc!");
            request.getRequestDispatcher("/bandoc/RegisterCardFrm9.jsp").forward(request, response);
            return;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Vui lòng nhập địa chỉ email!");
            request.getRequestDispatcher("/bandoc/RegisterCardFrm9.jsp").forward(request, response);
            return;
        }

        // ── 3. Upload ảnh thẻ ───────────────────────────────────────────────
        String savedFileName = "";
        try {
            Part filePart = request.getPart("txtPortraitImage");
            if (filePart != null && filePart.getSize() > 0) {
                String originalName = getSubmittedFileName(filePart);
                if (originalName != null && !originalName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    String ext = "";
                    int lastDot = originalName.lastIndexOf(".");
                    if (lastDot >= 0) ext = originalName.substring(lastDot);
                    savedFileName = "avatar_" + System.currentTimeMillis() + ext;

                    try (InputStream is = filePart.getInputStream()) {
                        Files.copy(is, Paths.get(uploadPath, savedFileName),
                                StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[RegisterCardServlet9] Upload ảnh lỗi: " + e.getMessage());
        }

        // ── 4. Tạo Reader9 ──────────────────────────────────────────────────
        Reader9 reader = new Reader9();
        reader.setFullName(fullName.trim());
        reader.setPhone(phone  != null ? phone.trim()   : "");
        reader.setEmail(email.trim());
        reader.setAddress(address != null ? address.trim() : "");
        reader.setGender(gender   != null ? gender.trim()  : "Nam");

        if (dateOfBirth != null && !dateOfBirth.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                Date parsedDate = sdf.parse(dateOfBirth.trim());
                reader.setDateOfBirth(parsedDate);
            } catch (Exception ignored) {}
        }
        request.getSession().setAttribute("reader", reader);

        // ── 5. Tạo ReaderCard9 ──────────────────────────────────────────────
        ReaderCard9 card = new ReaderCard9();
        card.setPortraitImage(savedFileName);
        card.setCardType(cardType != null ? cardType : "Sinh vien");
        card.setReader(reader);

        // ── 6. Gọi DAO ──────────────────────────────────────────────────────
        ReaderCardDAO9 dao = new ReaderCardDAO9();
        boolean success = dao.addReaderCard(card);

        // ── 7. Chuyển hướng ─────────────────────────────────────────────────
        if (success) {
            request.setAttribute("reader",     reader);
            request.setAttribute("readerCard", card);
            request.getRequestDispatcher("/bandoc/SuccessFrm9.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg",   "Đăng ký thẻ thất bại! Vui lòng thử lại.");
            request.setAttribute("readerCard", card);
            request.getRequestDispatcher("/bandoc/RegisterCardFrm9.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/bandoc/RegisterCardFrm9.jsp").forward(request, response);
    }

    private String getSubmittedFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                return Paths.get(name).getFileName().toString();
            }
        }
        return null;
    }
}

