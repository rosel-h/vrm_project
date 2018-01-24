package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 */
public class Article {
    private String username;
    private int articleID;
    private String content;
    private String date;
    private String title;

    public Article() {
    }

    public Article(String username, int articleID, String content, String date, String title) {
        this.username = username;
        this.articleID = articleID;
        this.content = content;
        this.date = date;
        this.title = title;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
