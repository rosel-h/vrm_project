package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

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
        User user = null;

        try (PreparedStatement ps = conn.prepareStatement("select * from vrm_users where binary username=?")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = dataFromResultSet(rs, new User());
                    //check the password is matching
                    String hashed_PW = user.getPassword();
                    System.out.println("The Hashed PW is " + hashed_PW);
                    System.out.println("The pw to be checked is " + pass);

                    if (!BCrypt.checkpw(pass, hashed_PW)) {
                        System.out.println("password check is returning fail    ");
                        user = null;
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return user;
    }

    public User getUserFacebook(String email) {
        User user = new User();
//        reactivateFBUser(email);
        try (PreparedStatement ps = conn.prepareStatement
                ("select * from vrm_users where binary email_address like ?")) {
            System.out.println("email to be used to selection is " + email);
            ps.setString(1, email);

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
        return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("description"), rs.getString("avatar_icon"), rs.getString("status"), rs.getString("email_address"));
    }

    public void addUserFB(String fName, String lName, String email) {
        String username = fName + "_" + lName;
        String password = BCrypt.hashpw(String.valueOf(100000000 + (int) (Math.random() * 1000000000)), BCrypt.gensalt(15));
        String fname = fName;
        String lname = lName;
        String dob = "1900-11-11";
        String country = "New Zealand";
        String description = "New facebook user";
        String avatar = "avatar_01.png";
        String status = "facebook";
        String security_q = "";
        String security_a = "";

        addUser(username, password, fname, lname, dob, country, description, avatar, status,  email, security_q, security_a);
    }

    public boolean addUser(String username, String password, String fname, String lname, String dob, String country, String description, String avatar, String status, String email, String security_q, String security_a) {
        Boolean success = false;
        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_users VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")) {
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
            stmt.setString(11, security_q);
            stmt.setString(12, security_a);

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

    public boolean deleteUser(String username) {
        boolean deleteSuccess = false;

        try (PreparedStatement ps = conn.prepareStatement("UPDATE vrm_users SET status = ? WHERE username = ?;")) {

            ps.setString(1, "inactive");
            ps.setString(2, username);
            ps.executeUpdate();
            deleteSuccess = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleteSuccess;
    }

    public boolean updateUser(User user) {
        boolean updateSuccess = false;

        try (PreparedStatement ps = conn.prepareStatement("UPDATE vrm_users " +
                "SET fname = ?, lname = ?, dob = ?, country = ?, description = ?, avatar_icon = ? WHERE username = ?;")) {

            ps.setString(1, user.getFname());
            ps.setString(2, user.getLname());
            ps.setString(3, user.getDateOfBirth());
            ps.setString(4, user.getCountry());
            ps.setString(5, user.getDescription());
            ps.setString(6, user.getAvatar_icon());
            ps.setString(7, user.getUsername());

            ps.executeUpdate();

            updateSuccess = true;


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updateSuccess;
    }

    public boolean updatePassword(User user) {
        boolean updateSuccess = false;

        try (PreparedStatement ps = conn.prepareStatement("UPDATE vrm_users " +
                "SET psw_hash = ? WHERE username = ?;")) {

            ps.setString(1, user.getPassword());
            ps.setString(2, user.getUsername());


            ps.executeUpdate();

            updateSuccess = true;


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updateSuccess;

    }

    @Override
    public void close() throws Exception {
        System.out.println("logging out of UserDao connection");
        this.conn.close();
    }
}
