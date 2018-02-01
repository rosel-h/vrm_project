package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 */
public class CommentOnArticles extends Comments{
    private int articleID;
    private int parentCommentID;

    public CommentOnArticles(){

    }
    public CommentOnArticles(int commentID, int articleID, String commentAuthor,String datePublished,  String content, String avatarIcon, int parentCommentID) {
        super(commentID, datePublished, commentAuthor, content, avatarIcon);
        this.articleID = articleID;
        this.parentCommentID = parentCommentID;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }
}
