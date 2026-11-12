package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DAO9 - Base DAO (plain Java class, không kế thừa HttpServlet)
 * Mô hình 3 lớp: JSP (View+Controller qua scriptlet) → DAO9 → MariaDB
 */
public class DAO9 {

    private static final String DB_URL      = "jdbc:mariadb://localhost:3306/library_ptit9";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "";
    private static final String DB_DRIVER   = "org.mariadb.jdbc.Driver";

    protected Connection con;

    public DAO9() {
        try {
            Class.forName(DB_DRIVER);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("[DAO9] Không tìm thấy JDBC Driver: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("[DAO9] Lỗi kết nối CSDL: " + e.getMessage());
        }
    }

    public void closeConnection() {
        if (con != null) {
            try { con.close(); }
            catch (SQLException e) { System.err.println("[DAO9] Lỗi đóng kết nối: " + e.getMessage()); }
            finally { con = null; }
        }
    }
}
