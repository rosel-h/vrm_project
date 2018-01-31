package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/31
 * Time : 11:09
 **/
public class UserDAO implements AutoCloseable {
    private final Connection conn;
    private final Database db;

    public UserDAO(Database db) throws IOException, SQLException {
        this.db = db;
        this.conn = db.getConnection();
    }

    public User getUserStandard(String username, String pass) {
        User user = new User();

        try (PreparedStatement ps = conn.prepareStatement("select * from vrm_users where binary username=? and binary psw_hash=? and status = ?")) {
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, "active");

            try (ResultSet rs = ps.executeQuery()) {
                // will be an empty set if login in correct
                if (rs.next()) {
                    user = dataFromResultSet(rs, new User());
                } else {
                    user = null;
                }
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return user;
    }

    public User getUserFacebook(String email) {
        User user = new User();
        try (PreparedStatement ps = conn.prepareStatement
                ("select * from vrm_users where binary email_address like ? and status like ?")) {
            System.out.println("email to be used to selection is " + email);
            ps.setString(1, email);
            ps.setString(2, "facebook");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = dataFromResultSet(rs, new User());
                } else {
                    user = null;
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }

    private User dataFromResultSet(ResultSet rs, User u) throws SQLException {
        return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("avatar_icon"), rs.getString("status"), rs.getString("email_address"));
    }

    public void addUserFB(String fName, String lName, String email) {
        String username = fName + "_" + lName;
        String password = String.valueOf(100000000 + (int) (Math.random() * 1000000000));
        String fname = fName;
        String lname = lName;
        String dob = "1900/11/11";
        String country = "New Zealand";
        String description = "New facebook user";
        String avatar = "avatar_01.png";
        String status = "facebook";

        addUser(username, password, fname, lname, dob, country, description, avatar, email, status);
    }

    public boolean addUser(String username, String password, String fname, String lname, String dob, String country, String description, String avatar, String status, String email) {
        Boolean success = false;
        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_users VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, fname);
            stmt.setString(4, lname);
            stmt.setString(5, dob);
            stmt.setString(6, country);
            stmt.setString(7, description);
            stmt.setString(8, avatar);
            stmt.setString(9, status);
            stmt.setString(10, email);

            stmt.executeUpdate();

            System.out.println("Creation Successful");
            success = true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return success;
    }

    public User getUserByUsername(String username) {
        User user = new User();

        try (PreparedStatement ps = conn.prepareStatement("select * from vrm_users where username=?")) {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                // will be an empty set if login in correct
                if (rs.next()) {
                    user = dataFromResultSet(rs, new User());
                } else {
                    user = null;
                }
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return user;
    }

    @Override
    public void close() throws Exception {
        System.out.println("logging out of UserDao connection");
        this.conn.close();
    }
}