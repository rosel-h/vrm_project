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

        try (PreparedStatement ps = conn.prepareStatement
                ("select * from vrm_users where binary username=? and binary psw_hash=? and status = ?")) {
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, "active");

            try (ResultSet rs = ps.executeQuery()) {
                // will be an empty set if login in correct
                if(rs.next()) {
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

    public User getUserFacebookk() {
        User user = new User();


        return user;
    }

    private User dataFromResultSet(ResultSet rs, User u) throws SQLException {
        return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("avatar_icon"), rs.getString("status"), rs.getString("email_address"));
    }

    @Override
    public void close() throws Exception {
        System.out.println("logging out of UserDao connection");
        this.conn.close();
    }
}
