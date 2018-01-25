package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
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

    /*Gets all the articles from database*/
    public List<Article> getAllArticles() throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles")) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<Article> artic = new ArrayList<>();
                while (rs.next()) {
                    artic.add(dataFromResultSet(rs, new Article()));
                }
                return artic;
            }
        }
    }

    /*Gets all the users from database*/
    public List<User> getAllUsers() throws SQLException {
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

    /*Gets all the comments on articles from database*/
    public List<CommentOnArticles> getAllFirstComments() throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_comments_on_articles")) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<CommentOnArticles> comArt = new ArrayList<>();
                while (rs.next()) {
                    comArt.add(dataFromResultSet(rs, new CommentOnArticles()));
                }
                return comArt;
            }
        }
    }
    public List<CommentsOnComments> getAllNestedComments() throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_comments_on_comments")) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<CommentsOnComments> comArt = new ArrayList<>();
                while (rs.next()) {
                    comArt.add(dataFromResultSet(rs, new CommentsOnComments()));
                }
                return comArt;
            }
        }
    }

    /**
     * Translates the current row of the given ResultSet into a Article,User,Comment object depending on the Object type passed in.
     */
    private Article dataFromResultSet(ResultSet rs, Article a) throws SQLException {
        return new Article(rs.getString("username"), rs.getInt("article_id"), rs.getString("content"), rs.getString("date"), rs.getString("title"));
    }
    private User dataFromResultSet(ResultSet rs, User u) throws SQLException {
        return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("avatar_icon"), rs.getString("status"),rs.getString("email_address"));
    }
    private CommentOnArticles dataFromResultSet(ResultSet rs, CommentOnArticles c) throws SQLException {
        return new CommentOnArticles(rs.getInt("comment_id"), rs.getInt("article_id"), rs.getString("username") ,rs.getString("date"),rs.getString("content") );
    }
    private CommentsOnComments dataFromResultSet(ResultSet rs, CommentsOnComments n) throws SQLException {
        return new CommentsOnComments(rs.getInt("parent_comment_id"),rs.getInt("child_comment_id"),rs.getString("username"),rs.getString("date"),rs.getString("content"));
    }

    public String getIcon(String username){
        String icon ="";
        try(PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username=?")){
            stmt.setString(1,username);
            try (ResultSet r = stmt.executeQuery()) {
                icon=r.getString(0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return icon;
    }

    public void addArticle(String title, String content, String user, Date now){

        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_articles VALUE (?, ?, ?, ?);")) {
            stmt.setString(1, title);
            stmt.setString(2, user);
            stmt.setString(3, String.valueOf(now));
            stmt.setString(4, content);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }



    /**
     * Closes the connection to the database. Implements {@link AutoCloseable} to support try-with-resources.
     */

    @Override
    public void close() throws Exception {
        this.conn.close();
    }
}
