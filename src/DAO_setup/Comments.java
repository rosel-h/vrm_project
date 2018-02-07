package DAO_setup;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by rher490 on 24/01/2018.
 * This will show comments on articles
 */
public class Comments {
    public int commentID;
    public String datePublished;
    public String commentAuthor;
    public String content;
    public String avatarIcon;
    List<Comments> comments;

    public String getAvatarIcon() {
        return avatarIcon;
    }

    public void setAvatarIcon(String avatarIcon) {
        this.avatarIcon = avatarIcon;
    }

    public Comments(int commentID, String datePublished, String commentAuthor, String content, String avatarIcon) {
        this.commentID = commentID;
        this.datePublished = datePublished;
        this.commentAuthor = commentAuthor;
        this.content = content;
        this.avatarIcon = avatarIcon;
        this.comments = new ArrayList<>();
    }

    //does nothing, used for dataFromResultSet as signature
    public Comments(){}
    /*get commentid*/
    public int getCommentID() {
        return commentID;
    }
    /*set commentid*/
    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }
    /*get date published*/
    public String getDatePublished() {
        return datePublished;
    }
    /*set date published*/
    public void setDatePublished(String datePublished) {
        this.datePublished = datePublished;
    }
    /*get username of the comment*/
    public String getCommentAuthor() {
        return commentAuthor;
    }
    /*set username of author*/
    public void setCommentAuthor(String commentAuthor) {
        this.commentAuthor = commentAuthor;
    }
    /*return content*/
    public String getContent() {
        return content;
    }
    /*set content*/
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
    /*add comment to the list*/
    public boolean addChild (Comments comment){
        comments.add(comment);
        return false;
    }

    /*check if comments has children, used in my articles and all articles*/
    public boolean hasChildren(){
        if(comments.size()>=1){
            return true;
        }
        return false;
    }
    /*returns the comments that whose parent comment is this*/
    public List<Comments> getChildren(){
        return comments;
    }
}
