package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 * This will show both comments on articles and on comments
 */
public class Comments {
    public int commentID;
    public String datePublished;
    public String commentAuthor;
    public String content;

    public Comments(int commentID, String datePublished, String commentAuthor, String content) {
        this.commentID = commentID;
        this.datePublished = datePublished;
        this.commentAuthor = commentAuthor;
        this.content = content;
    }

    //does nothing
    public Comments(){}

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

    @Override
    public String toString() {
        return "Comments{" +
                "commentID=" + commentID +
                ", datePublished='" + datePublished + '\'' +
                ", commentAuthor='" + commentAuthor + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
