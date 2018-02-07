package DAO_setup;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


/**
 * Created by rher490 on 24/01/2018.
 */
public class Article {
    private String username;
    private int articleID;
    private String content;
    private String date;
    private String title;
    private String userStatus;

    public Article() {
    }

    public Article(String username, int articleID, String content, String date, String title,String userStatus) {
        this.username = username;
        this.articleID = articleID;
        this.content = content;
        this.date = date;
        this.title = title;
        this.userStatus =userStatus;
        }
public boolean userIsInactive(){
if(userStatus.toLowerCase().equals("inactive")){
System.out.println("article class: user "+username+" is inactive?"+userStatus.toLowerCase().equals("inactive"));
return true;
}
return false;

    }

    /*returns username*/
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    /*return article id*/
    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    /*return all content*/
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    /*return date*/
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    /*return title*/
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    /*check if this date is in the future*/
    public boolean dateIsGreaterThan(String otherDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date1 = LocalDate.parse(this.date, formatter);
        LocalDate date2 = LocalDate.parse(otherDate, formatter);
        java.sql.Date thisDate = java.sql.Date.valueOf(date1);
        java.sql.Date otherDateReformat = java.sql.Date.valueOf(date2);
        if (thisDate.compareTo(otherDateReformat) >= 1) {
            return true;
        }
        return false;
    }

    /*returns the first paragraph of an article*/
    public String getContentPreview() {
        String preview = "";
        System.out.println();
        try {
            int indexOfFirstParagraph = content.indexOf("</p>") + 4;
            if (indexOfFirstParagraph < 4) {
                return "<br>"+content.substring(0, 50) + "...";
            } else {
                System.out.println("Article class: " + title + " (author "+username+"  )content preview: " + content.substring(0, indexOfFirstParagraph) + "..."+indexOfFirstParagraph);
                preview = content.substring(0, indexOfFirstParagraph);
            }
            return preview;
        } catch (StringIndexOutOfBoundsException e) {
            System.out.println("StringIndexOutOfBounds error: array out of bound");
            return "<br>"+this.content;
        }
    }
}
