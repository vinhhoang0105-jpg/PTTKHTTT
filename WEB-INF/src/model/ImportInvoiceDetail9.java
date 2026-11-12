package model;

/**
 * ImportInvoiceDetail9 - Chi tiết từng dòng hóa đơn nhập
 */
public class ImportInvoiceDetail9 {
    private int      id;
    private int      quantity;
    private double   unitPrice;
    private double   amount;
    private Document9 document;

    public ImportInvoiceDetail9() {}

    public ImportInvoiceDetail9(int id, int quantity, double unitPrice, double amount, Document9 document) {
        this.id        = id;
        this.quantity  = quantity;
        this.unitPrice = unitPrice;
        this.amount    = amount;
        this.document  = document;
    }

    public int       getId()                           { return id; }
    public void      setId(int id)                     { this.id = id; }

    public int       getQuantity()                     { return quantity; }
    public void      setQuantity(int quantity)         { this.quantity = quantity; }

    public double    getUnitPrice()                    { return unitPrice; }
    public void      setUnitPrice(double unitPrice)    { this.unitPrice = unitPrice; }

    public double    getAmount()                       { return amount; }
    public void      setAmount(double amount)          { this.amount = amount; }

    public Document9 getDocument()                     { return document; }
    public void      setDocument(Document9 document)   { this.document = document; }
}

