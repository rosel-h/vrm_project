package DAO_setup;

/**
 * Created by rher490 on 24/01/2018.
 */
public class CommentsOnComments extends Comments {
    private int parentID;

    //ignore
    public CommentsOnComments(){
    }
    public CommentsOnComments( int parentID, int commentID, String commentAuthor, String datePublished, String content) {
        super(commentID, datePublished, commentAuthor, content);
        this.parentID=parentID;
    }

    public int getParentID() {
        return parentID;
    }


}
