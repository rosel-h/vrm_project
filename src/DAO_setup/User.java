package DAO_setup;

import org.jooq.tools.json.JSONObject;
import org.jooq.tools.json.JSONParser;
import org.jooq.tools.json.ParseException;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by rher490 on 24/01/2018.
 * Lists the user information as an object
 */

public class User {
    private String username;
    private String password;
    private String fname;
    private String lname;
    private String dateOfBirth;
    private String country;
    private String avatar_icon;
    private String status;
    private String email;
    private String description;
    private String security_q;
    private String security_a;

    /*Constructors*/
    public User(){

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

    public User(String username, String password, String fname, String lname, String dateOfBirth, String country, String description, String avatar_icon, String status, String email) {
        this.username = username;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.dateOfBirth = dateOfBirth;
        this.country = country;
        this.description = description;
        this.avatar_icon = avatar_icon;
        this.status = status;
        if(!String.valueOf(email).equals("null")) {
            this.email = email;
        }
    }

    public User(String username, String password, String fname, String lname, String dateOfBirth, String country, String description, String avatar_icon, String status, String email, String security_q, String security_a) {
        this.username = username;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.dateOfBirth = dateOfBirth;
        this.country = country;
        this.description = description;
        this.avatar_icon = avatar_icon;
        this.status = status;
        if(!String.valueOf(email).equals("null")) {
            this.email = email;
        }
        this.security_q = security_q;
        this.security_a = security_a;
    }

    /*get username*/
    public String getUsername() {
        return username;
    }
    /*set username*/
    public void setUsername(String username) {
        this.username = username;
    }
    /*get password*/
    public String getPassword() {
        return password;
    }
    /*set password*/
    public void setPassword(String password) {
        this.password = password;
    }
    /*get first name*/
    public String getFname() {
        return fname;
    }
    /*set first name*/
    public void setFname(String fname) {
        this.fname = fname;
    }
    /*get last name*/
    public String getLname() {
        return lname;
    }
    /*set first name */
    public void setLname(String lname) {
        this.lname = lname;
    }
    /*get date of birth*/
    public String getDateOfBirth() {
        return dateOfBirth;
    }
    /*set date of birth*/
    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    /*get country */
    public String getCountry() {
        return country;
    }
    /*set country*/
    public void setCountry(String country) {
        this.country = country;
    }
    /*get avatar icon*/
    public String getAvatar_icon() {
        return avatar_icon;
    }
    /*set avatar icon*/
    public void setAvatar_icon(String avatar_icon) {
        this.avatar_icon = avatar_icon;
    }
    /*get status whether the user is an active user, inactive user or the account was created by user*/
    public String getStatus() {
        return status;
    }
    /*set status*/
    public void setStatus(String status) {
        this.status = status;
    }
    /*get email*/
    public String getEmail() {
        return email;
    }
    /*set email*/
    public void setEmail(String email) {
        this.email = email;
    }
    /*get description*/
    public String getDescription() { return description;}
    /*set description*/
    public void setDescription(String description) {this.description = description;}
    /*get security question*/
    public String getSecurity_q() { return security_q;}
    /*set security question*/
    public void setSecurity_q(String security_q) { this.security_q = security_q;}
    /*get security answer*/
    public String getSecurity_a() { return security_a;}
    /*set security answer*/
    public void setSecurity_a(String security_a) { this.security_a = security_a;}

    /*read jsonfile*/
    public static JSONObject readJSONFile(String fileName){
        JSONObject o = new JSONObject();
        JSONParser parser = new JSONParser();
        try(BufferedReader br = new BufferedReader(new FileReader(fileName))){
            String line = br.readLine();
            o = (JSONObject) parser.parse(line);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return o;
    }

    public String toString() {
        return "username=" + username + ",fname=" + fname + ",lname=" + lname + ",dob=" + dateOfBirth + ",country=" + country + ",description=" + description + ",avatar=" + avatar_icon + ",s_q=" + security_q + ",s_a=" + security_a;
    }
}
