package dao;

import model.*;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * ImportInvoiceStatDAO9 - Thuần DAO (kế thừa DAO9)
 * JSP gọi trực tiếp qua scriptlet.
 *
 * Phương thức:
 *   + ImportInvoiceStatDAO9()
 *   + getImportInvoiceBySupplier(startDate: Date, endDate: Date, idSupplier: int) : ImportInvoice9[]
 *   + getImportInvoiceDetail(idImportInvoice: int) : ImportInvoice9
 */
public class ImportInvoiceStatDAO9 extends DAO9 {

    public ImportInvoiceStatDAO9() {
        super();
    }

    /**
     * Lấy danh sách hóa đơn nhập theo nhà cung cấp trong khoảng thời gian.
     */
    public List<ImportInvoice9> getImportInvoiceBySupplier(
            Date startDate, Date endDate, int idSupplier) {

        List<ImportInvoice9> result = new ArrayList<>();
        if (con == null) return result;

        String sql =
            "SELECT ii.id, ii.importDate, ii.totalQuantity, ii.totalAmount, " +
            "       s.id AS sup_id, s.supplierName, s.address AS sup_addr, " +
            "       s.phone AS sup_phone, s.email AS sup_email, " +
            "       u.id AS lib_id, u.fullName AS lib_name " +
            "FROM tblImportInvoice9 ii " +
            "INNER JOIN tblSupplier9 s ON ii.tblSupplier9id = s.id " +
            "LEFT  JOIN tblUser9    u ON ii.tblUser9id      = u.id " +
            "WHERE ii.importDate >= ? AND ii.importDate <= ? " +
            "  AND ii.tblSupplier9id = ? " +
            "ORDER BY ii.importDate DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ps.setInt(3, idSupplier);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) result.add(buildInvoiceFromRS(rs));
            rs.close();
        } catch (SQLException e) {
            System.err.println("[ImportInvoiceStatDAO9] getImportInvoiceBySupplier: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return result;
    }

    /**
     * Lấy chi tiết một hóa đơn nhập (kèm danh sách tài liệu).
     */
    public ImportInvoice9 getImportInvoiceDetail(int idImportInvoice) {
        if (con == null) return null;

        ImportInvoice9 invoice = null;

        String sqlInvoice =
            "SELECT ii.id, ii.importDate, ii.totalQuantity, ii.totalAmount, " +
            "       s.id AS sup_id, s.supplierName, s.address AS sup_addr, " +
            "       s.phone AS sup_phone, s.email AS sup_email, " +
            "       u.id AS lib_id, u.fullName AS lib_name " +
            "FROM tblImportInvoice9 ii " +
            "INNER JOIN tblSupplier9 s ON ii.tblSupplier9id = s.id " +
            "LEFT  JOIN tblUser9    u ON ii.tblUser9id      = u.id " +
            "WHERE ii.id = ?";

        try (PreparedStatement ps = con.prepareStatement(sqlInvoice)) {
            ps.setInt(1, idImportInvoice);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) invoice = buildInvoiceFromRS(rs);
            rs.close();
        } catch (SQLException e) {
            System.err.println("[ImportInvoiceStatDAO9] getImportInvoiceDetail (invoice): " + e.getMessage());
            closeConnection(); return null;
        }

        if (invoice == null) { closeConnection(); return null; }

        String sqlDetail =
            "SELECT iid.id, iid.quantity, iid.unitPrice, iid.amount, " +
            "       d.id AS doc_id, d.title, d.author, d.category, d.publisher, " +
            "       d.publicationYear, d.totalQuantity " +
            "FROM tblImportInvoiceDetail9 iid " +
            "INNER JOIN tblDocument9 d ON iid.tblDocument9id = d.id " +
            "WHERE iid.tblImportInvoice9id = ? ORDER BY iid.id";

        try (PreparedStatement ps2 = con.prepareStatement(sqlDetail)) {
            ps2.setInt(1, idImportInvoice);
            ResultSet rs2 = ps2.executeQuery();
            List<ImportInvoiceDetail9> details = new ArrayList<>();
            while (rs2.next()) {
                Document9 doc = new Document9(
                    rs2.getInt("doc_id"), rs2.getString("title"),
                    rs2.getString("author"), rs2.getString("category"),
                    rs2.getString("publisher"), rs2.getInt("publicationYear"),
                    rs2.getInt("totalQuantity")
                );
                details.add(new ImportInvoiceDetail9(
                    rs2.getInt("id"), rs2.getInt("quantity"),
                    rs2.getDouble("unitPrice"), rs2.getDouble("amount"), doc
                ));
            }
            rs2.close();
            invoice.setImportInvoiceDetail(details);
        } catch (SQLException e) {
            System.err.println("[ImportInvoiceStatDAO9] getImportInvoiceDetail (details): " + e.getMessage());
        } finally {
            closeConnection();
        }
        return invoice;
    }

    private ImportInvoice9 buildInvoiceFromRS(ResultSet rs) throws SQLException {
        ImportInvoice9 inv = new ImportInvoice9();
        inv.setId(rs.getInt("id"));
        inv.setImportDate(rs.getDate("importDate"));
        inv.setTotalQuantity(rs.getInt("totalQuantity"));
        inv.setTotalAmount(rs.getDouble("totalAmount"));
        Supplier9 sup = new Supplier9(
            rs.getInt("sup_id"), rs.getString("supplierName"),
            rs.getString("sup_addr"), rs.getString("sup_phone"), rs.getString("sup_email")
        );
        inv.setSupplier(sup);
        int libId = rs.getInt("lib_id");
        if (libId > 0) {
            Librarian9 lib = new Librarian9();
            lib.setId(libId);
            lib.setFullName(rs.getString("lib_name"));
            inv.setLibrarian(lib);
        }
        return inv;
    }
}
