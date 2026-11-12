package model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

/**
 * ImportInvoice9 - Hóa đơn nhập tài liệu
 */
public class ImportInvoice9 {
    private int    id;
    private Date   importDate;
    private int    totalQuantity;
    private double totalAmount;
    private Librarian9 librarian;
    private Supplier9  supplier;
    private List<ImportInvoiceDetail9> importInvoiceDetail;

    public ImportInvoice9() {
        this.importInvoiceDetail = new ArrayList<>();
    }

    public int    getId()                                        { return id; }
    public void   setId(int id)                                  { this.id = id; }

    public Date   getImportDate()                                { return importDate; }
    public void   setImportDate(Date importDate)                 { this.importDate = importDate; }

    public int    getTotalQuantity()                             { return totalQuantity; }
    public void   setTotalQuantity(int totalQuantity)            { this.totalQuantity = totalQuantity; }

    public double getTotalAmount()                               { return totalAmount; }
    public void   setTotalAmount(double totalAmount)             { this.totalAmount = totalAmount; }

    public Librarian9 getLibrarian()                             { return librarian; }
    public void       setLibrarian(Librarian9 librarian)         { this.librarian = librarian; }

    public Supplier9  getSupplier()                              { return supplier; }
    public void       setSupplier(Supplier9 supplier)            { this.supplier = supplier; }

    public List<ImportInvoiceDetail9> getImportInvoiceDetail()   { return importInvoiceDetail; }
    public void setImportInvoiceDetail(List<ImportInvoiceDetail9> d) { this.importInvoiceDetail = d; }
}

