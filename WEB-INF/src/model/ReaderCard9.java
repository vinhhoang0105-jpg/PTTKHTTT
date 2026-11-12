package model;

import java.util.Date;

/**
 * Model class: ReaderCard9
 * Ánh xạ bảng reader_cards trong CSDL
 */
public class ReaderCard9 {
    private int id;
    private String cardCode;
    private String portraitImage;
    private Date issueDate;
    private Date expiryDate;
    private String cardType;
    private Reader9 reader;

    public ReaderCard9() {}

    public ReaderCard9(int id, String cardCode, String portraitImage,
                       Date issueDate, Date expiryDate,
                       String cardType, Reader9 reader) {
        this.id = id;
        this.cardCode = cardCode;
        this.portraitImage = portraitImage;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.cardType = cardType;
        this.reader = reader;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCardCode() { return cardCode; }
    public void setCardCode(String cardCode) { this.cardCode = cardCode; }

    public String getPortraitImage() { return portraitImage; }
    public void setPortraitImage(String portraitImage) { this.portraitImage = portraitImage; }

    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

    public String getCardType() { return cardType; }
    public void setCardType(String cardType) { this.cardType = cardType; }

    public Reader9 getReader() { return reader; }
    public void setReader(Reader9 reader) { this.reader = reader; }
}

