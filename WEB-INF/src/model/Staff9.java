package model;

/**
 * Staff9 - Kế thừa User9, thêm position
 * Manager9 và Librarian9 đều kế thừa Staff9
 */
public class Staff9 extends User9 {
    private String position; // 'Manager' | 'Librarian'

    public Staff9() {}

    public Staff9(String position) {
        this.position = position;
    }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
}

