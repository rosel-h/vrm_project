package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by rher490 on 24/01/2018.
 */
public class BlogDAO implements AutoCloseable {
    private final Connection conn;

    private final Database db;
    /**
     * Creates a new UniDAO and establishes a connection to the given database.
     */
    public BlogDAO(Database db) throws IOException, SQLException {
        this.db = db;
        this.conn = db.getConnection();
    }

    /*Execute a query to get all article from the db, then converts each row of the result table to an Article object*/
    public List<Article> getAllArticles() throws SQLException{
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles")) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<Article> artic = new ArrayList<>();
                while (rs.next()) {
                    artic.add(dataFromResultSet(rs,new Article()));
                }
                return artic;
            }
        }
    }

    public List<User> getAllUsers()throws SQLException{
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users")) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<User> user = new ArrayList<>();
                while (rs.next()) {
                    user.add(dataFromResultSet(rs, new User()));
                }
                return user;
            }
        }
    }
    /**
     * Translates the current row of the given ResultSet into a Article,User,Comment object depending on the Object type passed in.
     */
    private Article dataFromResultSet(ResultSet rs,Article a) throws SQLException {
                return new Article(rs.getString("username"),rs.getInt("article_id"),rs.getString("content"),rs.getString("date"),rs.getString("title"));
    }
    private User dataFromResultSet(ResultSet rs,User u) throws SQLException {
        return new User(rs.getString("username"),rs.getString("psw_hash"),rs.getString("fname"), rs.getString ("lname"), rs.getString ("dob"), rs.getString ("country"), rs.getString("avatar_icon") , rs.getString("status") );
    }

    /**
     * Closes the connection to the database. Implements {@link AutoCloseable} to support try-with-resources.
     */

    @Override
    public void close() throws Exception {
        this.conn.close();
    }
}
