package dao;

import model.*;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * SupplierStatisticDAO9 - Thuần DAO (kế thừa DAO9)
 * JSP gọi trực tiếp qua scriptlet.
 *
 * Phương thức:
 *   + SupplierStatisticDAO9()
 *   + getSupplierStatistic(startDate: Date, endDate: Date) : SupplierStatistic9[]
 */
public class SupplierStatisticDAO9 extends DAO9 {

    public SupplierStatisticDAO9() {
        super();
    }

    /**
     * Thống kê nhà cung cấp theo tổng số lượng nhập trong khoảng thời gian.
     * @param startDate ngày bắt đầu (java.sql.Date)
     * @param endDate   ngày kết thúc (java.sql.Date)
     * @return List<SupplierStatistic9> sắp xếp giảm dần theo số lượng
     */
    public List<SupplierStatistic9> getSupplierStatistic(Date startDate, Date endDate) {
        List<SupplierStatistic9> result = new ArrayList<>();
        if (con == null) return result;

        String sql =
            "SELECT s.id, s.supplierName, s.address, s.phone, s.email, " +
            "       SUM(ii.totalQuantity) AS totalImportQty " +
            "FROM tblSupplier9 s " +
            "INNER JOIN tblImportInvoice9 ii ON s.id = ii.tblSupplier9id " +
            "WHERE ii.importDate >= ? AND ii.importDate <= ? " +
            "GROUP BY s.id, s.supplierName, s.address, s.phone, s.email " +
            "ORDER BY totalImportQty DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier9 sup = new Supplier9(
                    rs.getInt("id"),
                    rs.getString("supplierName"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getString("email")
                );
                result.add(new SupplierStatistic9(sup, rs.getInt("totalImportQty")));
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println("[SupplierStatisticDAO9] getSupplierStatistic: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return result;
    }
}
