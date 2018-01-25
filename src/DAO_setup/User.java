package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 */
public class User {
    String username;
    String password; //edit later
    String fname;
    String lname;
    String dateOfBirth;
    String country;
    String avatar_icon;
    String status;
    String email;

    public User() {
    }

    public User(String username, String password, String fname, String lname, String dateOfBirth, String country, String avatar_icon, String status, String email) {
        this.username = username;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.dateOfBirth = dateOfBirth;
        this.country = country;
        this.avatar_icon = avatar_icon;
        this.status = status;
        if(!String.valueOf(email).equals("null")) {
            this.email = email;
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getAvatar_icon() {
        return avatar_icon;
    }

    public void setAvatar_icon(String avatar_icon) {
        this.avatar_icon = avatar_icon;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
