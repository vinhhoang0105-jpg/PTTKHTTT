package dao;

import model.ReaderCard9;
import model.Reader9;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Random;

/**
 * ReaderCardDAO9 - DAO xử lý thẻ bạn đọc (kế thừa DAO9)
 * Đúng chuẩn sơ đồ lớp UML: chỉ có duy nhất phương thức addReaderCard.
 */
public class ReaderCardDAO9 extends DAO9 {

    public ReaderCardDAO9() {
        super();
    }

    /**
     * Thêm thẻ bạn đọc vào CSDL
     * Toàn bộ xử lý sinh mã và lưu thông tin bạn đọc được tích hợp trực tiếp,
     * không sử dụng thêm hàm phụ trợ ngoài thiết kế.
     *
     * @param card đối tượng ReaderCard9 cần thêm
     * @return true nếu thêm thành công, false nếu thất bại
     */
    public boolean addReaderCard(ReaderCard9 card) {
        if (con == null || card == null) return false;

        try {
            // 1. Sinh mã thẻ tự động dạng MT + 3 chữ số (ví dụ: MT339)
            String cardCode = "MT" + (100 + new Random().nextInt(900));
            card.setCardCode(cardCode);

            // 2. Thiết lập ngày hiệu lực (hôm nay) và ngày hết hạn (+1 năm)
            Date issueDate  = Date.valueOf(LocalDate.now());
            Date expiryDate = Date.valueOf(LocalDate.now().plusYears(1));
            card.setIssueDate(issueDate);
            card.setExpiryDate(expiryDate);

            // 3. Xử lý lưu hoặc lấy thông tin bạn đọc (Reader9)
            Reader9 reader = card.getReader();
            int readerId = -1;

            if (reader != null) {
                // Kiểm tra bạn đọc đã tồn tại theo email chưa
                String checkSql = "SELECT id FROM readers WHERE email = ?";
                try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                    checkPs.setString(1, reader.getEmail());
                    try (ResultSet rs = checkPs.executeQuery()) {
                        if (rs.next()) {
                            readerId = rs.getInt("id");
                        }
                    }
                }

                // Nếu chưa có, thêm mới bạn đọc vào bảng readers
                if (readerId < 0) {
                    String readerCode = "BD" + (10000 + new Random().nextInt(90000));
                    reader.setReaderCode(readerCode);

                    String dobStr = "";
                    if (reader.getDateOfBirth() != null) {
                        dobStr = new SimpleDateFormat("dd/MM/yyyy").format(reader.getDateOfBirth());
                    }

                    String insertReaderSql = "INSERT INTO readers (reader_code, full_name, date_of_birth, " +
                                             "phone, email, address) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement insertPs = con.prepareStatement(insertReaderSql,
                            PreparedStatement.RETURN_GENERATED_KEYS)) {
                        insertPs.setString(1, reader.getReaderCode());
                        insertPs.setString(2, reader.getFullName());
                        insertPs.setString(3, dobStr);
                        insertPs.setString(4, reader.getPhone());
                        insertPs.setString(5, reader.getEmail());
                        insertPs.setString(6, reader.getAddress());
                        insertPs.executeUpdate();

                        try (ResultSet gk = insertPs.getGeneratedKeys()) {
                            if (gk.next()) {
                                readerId = gk.getInt(1);
                            }
                        }
                    }
                }
            }

            if (readerId < 0) return false;

            // 4. Lưu thẻ bạn đọc vào bảng reader_cards
            String insertCardSql = "INSERT INTO reader_cards (card_code, portrait_image, issue_date, " +
                                   "expiry_date, card_type, reader_id) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(insertCardSql)) {
                ps.setString(1, card.getCardCode());
                ps.setString(2, card.getPortraitImage());
                ps.setDate(3, issueDate);
                ps.setDate(4, expiryDate);
                ps.setString(5, card.getCardType());
                ps.setInt(6, readerId);

                int rows = ps.executeUpdate();
                return rows > 0;
            }

        } catch (SQLException e) {
            System.err.println("[ReaderCardDAO9] Lỗi addReaderCard: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }
}
