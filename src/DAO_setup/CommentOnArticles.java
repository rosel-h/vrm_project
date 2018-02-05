package DAO_setup;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by rher490 on 24/01/2018.
 */
public class CommentOnArticles extends Comments{
    private int articleID;
    private int parentCommentID;
    private String userStatus;

    public CommentOnArticles(){

    }
    public CommentOnArticles(int commentID, int articleID, String commentAuthor,String datePublished,  String content, String avatarIcon, int parentCommentID, String userStatus) {
        super(commentID, datePublished, commentAuthor, content, avatarIcon);
        this.articleID = articleID;
        this.parentCommentID = parentCommentID;
        this.userStatus = userStatus;
    }

    public boolean userIsInactive(){
        if(userStatus.toLowerCase().equals("inactive")){
            return true;
        }
return false;
    }
    public int getParentCommentID() {
        return parentCommentID;
    }

    public void setParentCommentID(int parentCommentID) {
        this.parentCommentID = parentCommentID;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public boolean isAChild(){
        if(parentCommentID<=0){
            return false;
        }
        return true;
    }

    /*Goes through all array list and adds the comments into their respective parents*/
    public static List<CommentOnArticles> pairCommentsRelationship(List<CommentOnArticles> list){
        List<CommentOnArticles> parentList = new ArrayList<CommentOnArticles>();
        for (CommentOnArticles com : list) {
            if(com.getParentCommentID()==0){
                parentList.add(com);
            }else{
                for (CommentOnArticles parent:parentList) {
                    if(parent.getCommentID()==com.getParentCommentID()){
                        parent.addChild(com);
                    }/*else{
                        System.out.println("CommentOnArticles class: left out: "+ com.toString());
                    }*/
                }
            }
        }
        return parentList;
    }
}
