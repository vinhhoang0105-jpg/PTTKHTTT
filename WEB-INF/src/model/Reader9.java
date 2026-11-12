package model;

/**
 * Model class: Reader9
 * Kế thừa thông tin từ User9, bổ sung readerCode
 */
public class Reader9 extends User9 {
    private String readerCode;

    public Reader9() {}

    public Reader9(String readerCode) {
        this.readerCode = readerCode;
    }

    public String getReaderCode() { return readerCode; }
    public void setReaderCode(String readerCode) { this.readerCode = readerCode; }
}

