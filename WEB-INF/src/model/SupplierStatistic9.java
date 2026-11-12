package model;

/**
 * SupplierStatistic9 - Kết quả thống kê nhà cung cấp theo số lượng nhập
 * Chứa thông tin Supplier9 + tổng số lượng nhập trong kỳ
 */
public class SupplierStatistic9 {
    private Supplier9 supplier;
    private int       importQuantity;

    public SupplierStatistic9() {}

    public SupplierStatistic9(Supplier9 supplier, int importQuantity) {
        this.supplier       = supplier;
        this.importQuantity = importQuantity;
    }

    public Supplier9 getSupplier()                       { return supplier; }
    public void      setSupplier(Supplier9 supplier)     { this.supplier = supplier; }

    public int  getImportQuantity()                      { return importQuantity; }
    public void setImportQuantity(int importQuantity)    { this.importQuantity = importQuantity; }
}

