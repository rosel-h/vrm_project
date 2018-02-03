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

    public List<Article> getArticleByTitle(String[] keywords) throws SQLException {
        List<Article> artic = new ArrayList<>();

        for (int i = 0; i < keywords.length; i++) {
            String keyword = keywords[i];
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles WHERE title LIKE ?")) {
                stmt.setString(1, "%" + keyword + "%");

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        if (!artic.contains(dataFromResultSet(rs, new Article()))) {
                            artic.add(dataFromResultSet(rs, new Article()));
                        }
                    }
                }
            }
        }
        return artic;
    }

    public List<Article> getArticleByUsername(String[] keywords) throws SQLException {
        List<Article> artic = new ArrayList<>();

        for (int i = 0; i < keywords.length; i++) {
            String keyword = keywords[i];
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles WHERE username LIKE ?")) {
                stmt.setString(1, "%" + keyword + "%");

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        if (!artic.contains(dataFromResultSet(rs, new Article()))) {
                            artic.add(dataFromResultSet(rs, new Article()));
                        }
                    }
                }
            }
        }
        return artic;
    }

    public List<Article> getArticleByDate(String[] keywords) throws SQLException {
        List<Article> artic = new ArrayList<>();

        for (int i = 0; i < keywords.length; i++) {
            String keyword = keywords[i];
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles WHERE date = ?")) {
                stmt.setString(1, keyword);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        if (!artic.contains(dataFromResultSet(rs, new Article()))) {
                            artic.add(dataFromResultSet(rs, new Article()));
                        }
                    }
                }
            }
        }
        return artic;
    }

    public List<Article> getMyArticles(String username) throws SQLException {
        System.out.println("BlogDAO: getMyArticles username - " + username);
        List<Article> a = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles WHERE username =?")) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("BlogDAO: rs executed in getMyArticles ");
                while (rs.next()) {
//                    System.out.println("rs has next");
                    a.add(dataFromResultSet(rs, new Article()));
                }
                return a;
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
        try (PreparedStatement stmt = conn.prepareStatement("SELECT vrm_comments_on_articles.*, vrm_users.avatar_icon FROM vrm_users, vrm_comments_on_articles WHERE  vwen239.vrm_comments_on_articles.username  = vwen239.vrm_users.username;")) {
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
        try (PreparedStatement stmt = conn.prepareStatement("SELECT vrm_comments_on_comments.*, vrm_users.avatar_icon FROM vrm_users, vrm_comments_on_comments WHERE  vwen239.vrm_comments_on_comments.username  = vwen239.vrm_users.username;")) {
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
        String user = rs.getString("username");
        int aID = rs.getInt("article_id");
        String story = rs.getString("content");
        String date = rs.getString("date");
        String title =  rs.getString("title");
        return new Article(user, aID, story,date , title);
    }

    private User dataFromResultSet(ResultSet rs, User u) throws SQLException {
        return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("description"), rs.getString("avatar_icon"), rs.getString("status"), rs.getString("email_address"));
    }

    private User dataFromResultSet(ResultSet rs) throws SQLException {
        if (rs.next()) {
            return new User(rs.getString("username"), rs.getString("psw_hash"), rs.getString("fname"), rs.getString("lname"), rs.getString("dob"), rs.getString("country"), rs.getString("description"), rs.getString("avatar_icon"), rs.getString("status"), rs.getString("email_address"));
        } else {
            System.out.println("BlogDAO enter line 91: no rs exists");
            return null;
        }
    }

    private CommentOnArticles dataFromResultSet(ResultSet rs, CommentOnArticles c) throws SQLException {
        return new CommentOnArticles(rs.getInt("comment_id"), rs.getInt("article_id"), rs.getString("username"), rs.getString("date"), rs.getString("content"), rs.getString("avatar_icon"),rs.getInt("parent_comment_id"));
    }

    private CommentsOnComments dataFromResultSet(ResultSet rs, CommentsOnComments n) throws SQLException {
        return new CommentsOnComments(rs.getInt("parent_comment_id"), rs.getInt("child_comment_id"), rs.getString("username"), rs.getString("date"), rs.getString("content"), rs.getString("avatar_icon"));
    }

    public String getIcon(String username) {
        String icon = "";
        try (PreparedStatement stmt = conn.prepareStatement("SELECT avatar_icon FROM vrm_users WHERE username=?")) {
            stmt.setString(1, username);
            try (ResultSet r = stmt.executeQuery()) {
                System.out.println(r.toString());
                while (r.next()) {

                    icon = r.getString(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(icon);
        return icon;
    }

    public void addArticle(String title, String content, String user, Date now) {
        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_articles (title,username, date, content) VALUE (?, ?, ?, ?);")) {
            stmt.setString(1, title);
            stmt.setString(2, user);
            stmt.setString(3, String.valueOf(now));
            stmt.setString(4, content);
            stmt.executeUpdate();



        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public User getUserDetails(String username) {
        System.out.println("BlogDAO: getUserDetails for " + username);
        User u = null;
        if (username != null) {
            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username=?")) {
                stmt.setString(1, username);
                System.out.println("BlogDAO: statement prepared = SELECT * FROM vrm_users WHERE username=" + username);

                try (ResultSet r = stmt.executeQuery()) {
                    System.out.println("RS executed");
//                    System.out.println("BlogDAO: user in RS = "+r.getString("username"));
                    u = dataFromResultSet(r, new User());
                    System.out.println(u.getUsername() + " " + u.getAvatar_icon());
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return u;
    }

    public User getOneUser(String username) {
        System.out.println("BlogDAO: getUserDetails for " + username);
        User u = null;
        if (username != null) {

            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username=?")) {
                stmt.setString(1, username);
                System.out.println("BlogDAO: statement prepared = SELECT * FROM vrm_users WHERE username=" + username);

                try (ResultSet r = stmt.executeQuery()) {
                    System.out.println("RS executed");
                    u = dataFromResultSet(r);
                    System.out.println("BlogDAO enter line 168: " + u.getUsername() + " " + u.getAvatar_icon());
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        System.out.println("BlogDAO enter line 174: u.username = " + u.getUsername());
        return u;
    }

    /*delete an article*/
    public void deleteArticle(int id) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM vrm_comments_on_articles WHERE article_id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("All comments with article id: " + id + " deleted.");
        }
        try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM vrm_articles WHERE article_id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Article with ID: " + id + " deleted.");
        }
    }

    /*add a comment*/
    public void addCommentToArticle(int articleID, String userWhoCommented, Date date, String comment) {
        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_comments_on_articles (article_id, username, date, content) VALUE (?,?,?,?)")) {
            stmt.setInt(1, articleID);
            stmt.setString(2, userWhoCommented);
            stmt.setDate(3, date);
            stmt.setString(4, comment);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Blog Dao: Comment was not added");
            e.printStackTrace();
        }
    }

    /*delete comment*/
    public void deleteCommentOnArticle(int id) {
        try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM vrm_comments_on_articles WHERE comment_id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Blog Dao: Comment with id: "+id+" deleted");
        } catch (SQLException e) {
            System.out.println("Blog Dao: Comment was not deleted");
            e.printStackTrace();
        }
    }



    public void addCommentToAnotherComment(int articleID, String userWhoCommented, Date date, String comment, int parentCommentID){
        try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_comments_on_articles (article_id, username, date, content,parent_comment_id) VALUE (?,?,?,?,?)")) {
            stmt.setInt(1, articleID);
            stmt.setString(2, userWhoCommented);
            stmt.setDate(3, date);
            stmt.setString(4, comment);
            stmt.setInt(5, parentCommentID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Blog Dao: CommentOnAnotherComment was not added");
            e.printStackTrace();
        }

    }


    /*get one article base on id*/
    public Article getOneArticle(int id) {
        Article a = null;

        try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_articles WHERE article_id = ?")) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("RS executed");
                System.out.println(rs.next());
                a = dataFromResultSet(rs, new Article());
                System.out.println("BlogDAO getOneArticle executed for id: "+id);
//                System.out.println(a.getArticleID());
//                System.out.println(a.getContent());
//                System.out.println(a.getDate());
//                System.out.println(a.getTitle());
//                System.out.println(a.getUsername());
            }
        } catch (SQLException e) {
            System.out.println("Blog Dao: article was not taken");
            e.printStackTrace();
        }
        return a;
    }

    public List<CommentOnArticles> getAllCommentOfArticle(int id) throws SQLException{
        ArrayList<CommentOnArticles> comments = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement("SELECT vrm_comments_on_articles.*, vrm_users.avatar_icon FROM vrm_users, vrm_comments_on_articles WHERE vrm_comments_on_articles.article_id =  ? AND  vwen239.vrm_comments_on_articles.username  = vwen239.vrm_users.username;")) {
            stmt.setInt(1, id);
            CommentOnArticles c;
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()){
                    comments.add(dataFromResultSet(rs,new CommentOnArticles()));
                }
            }
        }
        return comments;
    }

    /*Edit article
     * @param id of the article in database
     * @newTitle title of the edited article
     * @newContent content edited
     * @date when the want the date published
     *
     *@ return true if article was added */
    public boolean editArticle(int id, String newTitle, String newContent, Date toPublish) {
        try (PreparedStatement stmt = conn.prepareStatement("UPDATE vrm_articles SET title = ?, content = ?, date = ? WHERE article_id=?;")) {
            stmt.setString(1, newTitle);
            stmt.setString(2, newContent);
            stmt.setString(3, String.valueOf(toPublish));
            stmt.setInt(4, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /*Edit article
     * @param id of the article in database
     * @newTitle title of the edited article*/
    public boolean editArticle(int id, String newTitle, String newContent) {
        try (PreparedStatement stmt = conn.prepareStatement("UPDATE vrm_articles SET title = ?, content = ? WHERE article_id=?;")) {
            stmt.setString(1, newTitle);
            stmt.setString(2, newContent);
            stmt.setInt(3, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Closes the connection to the database. Implements {@link AutoCloseable} to support try-with-resources.
     */

    @Override
    public void close() throws Exception {
        System.out.println("BlogDAO connection closing!");
        this.conn.close();
    }
}
