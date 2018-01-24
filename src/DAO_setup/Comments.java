package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 * This will show both comments on articles and on comments
 */
public abstract class Comments {
    public int commentID;
    private boolean isACommentOnArticle;
    public String datePublished;
    public String commentAuthor;
    public String content;
    public int parentID;

    public boolean isACommentOnArticle() {
        return isACommentOnArticle;
    }

    public void setACommentOnArticle(boolean ACommentOnArticle) {
        isACommentOnArticle = ACommentOnArticle;
    }

    public int getParentID() {
        return parentID;
    }

    public void setParentID(int parentID) {
        this.parentID = parentID;
    }

    public Comments(int commentID, boolean isACommentOnArticle, String datePublished, String commentAuthor, String content, int parentID) {

        this.commentID = commentID;
        this.isACommentOnArticle = isACommentOnArticle;
        this.datePublished = datePublished;
        this.commentAuthor = commentAuthor;
        this.content = content;
        this.parentID = parentID;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public String getDatePublished() {
        return datePublished;
    }

    public void setDatePublished(String datePublished) {
        this.datePublished = datePublished;
    }

    public String getCommentAuthor() {
        return commentAuthor;
    }

    public void setCommentAuthor(String commentAuthor) {
        this.commentAuthor = commentAuthor;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
