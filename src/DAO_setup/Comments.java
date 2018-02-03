package DAO_setup;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by rher490 on 24/01/2018.
 * This will show both comments on articles and on comments
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
    /*add comment to the list*/
    public boolean addChild (Comments comment){
        comments.add(comment);
//        System.out.println("Comments class: "+comment.getCommentID()+" has been added as a child of "+this.getCommentID());
//        System.out.println(this.hasChildren());
        return false;
    }

    public boolean hasChildren(){
        if(comments.size()>=1){
            return true;
        }
        return false;
    }

    public List<Comments> getChildren(){
        return comments;
    }
}
