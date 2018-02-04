package DAO_setup;

import org.jsoup.Jsoup;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

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

    public String getFormattedDate() {
        String YMD = date.substring(9) + " ";
        int month = Integer.parseInt(date.substring(5, 7));
        switch (month) {
            case 1:
                YMD += "Jan ";
                break;
            case 2:
                YMD += "Feb ";
                break;
            case 3:
                YMD += "Mar ";
                break;
            case 4:
                YMD += "Apr ";
                break;
            case 5:
                YMD += "May ";
                break;
            case 6:
                YMD += "Jun ";
                break;
            case 7:
                YMD += "Jul ";
                break;
            case 8:
                YMD += "Aug ";
                break;
            case 9:
                YMD += "Sep ";
                break;
            case 10:
                YMD += "Oct ";
                break;
            case 11:
                YMD += "Nov ";
                break;
            case 12:
                YMD += "Dec ";
                break;
        }

        return YMD + date.substring(0, 4);
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

    public String getContentPreview() {
        String preview = "";
        System.out.println();
        try {
            int indexOfFirstParagraph = content.indexOf("</p>") + 4;
            int indexOfIntendedContextPreview = content.indexOf(">") + 50/*+4*/;

//            if(indexOfFirstParagraph<indexOfIntendedContextPreview){
//                System.out.println("Article class: "+title+" content preview: "+content.substring(0,indexOfFirstParagraph)+"...");
//                preview=content.substring(0,indexOfFirstParagraph)+"...";
//            }else{
//                System.out.println("Article class: content preview "+content.substring(0,indexOfIntendedContextPreview)+"...</p>");
//                preview=content.substring(0,indexOfIntendedContextPreview)+"...</p>";
//            }

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
