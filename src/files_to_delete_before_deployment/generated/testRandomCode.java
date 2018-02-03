package files_to_delete_before_deployment.generated;

import DAO_setup.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class testRandomCode {

    public static void main(String[] args) {
        new testRandomCode().start();
//        new testRandomCode().testDates();
//        new testRandomCode().testNest();

    }

    private void start() {
        try {
            String preview = "<p style=\"margin-bottom: 15px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam volutpat ligula lacinia nibh iaculis aliquam. Nam dolor mauris, dapibus in malesuada et, pharetra ac tortor. Nullam dapibus fermentum dui, quis iaculis mauris bibendum ac. Quisque tempus ultricies lorem, quis rutrum lectus finibus vitae. Mauris ut laoreet neque, eget molestie massa. Ut lacinia, ipsum in vehicula cursus, sem tellus cursus orci, vitae rutrum magna justo a leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac turpis et risus maximus cursus eget sed leo. Nunc pretium, nisl ut pellentesque ullamcorper, dolor ligula dignissim ligula, ac luctus eros elit a turpis. Fusce lacinia augue in cursus hendrerit. Phasellus in auctor dolor, et pellentesque odio. Duis id mi quis risus placerat luctus convallis vel ex. Mauris sit amet odio est. Cras finibus, nunc laoreet maximus euismod, enim est interdum purus, id imperdiet elit ipsum vitae sem. Maecenas ultricies facilisis imperdiet.</p><p style=\"margin-bottom: 15px; padding: 0px; text-align: justify; font-family: &quot;Open Sans&quot;, Arial, sans-serif;\">Maecenas fringilla magna ut sapien cursus dignissim. Pellentesque ornare quis urna vel varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum blandit ut mauris eget dignissim. Suspendisse tristique aliquet dolor. Vivamus viverra nisl eget urna semper tempor. Maecenas sed dui condimentum, faucibus magna non, blandit nunc. In a aliquam velit. Sed vitae nisl gravida, maximus tellus id, tincidunt mi. Aliquam vitae erat interdum, congue nunc sit amet, convallis orci. Nullam aliquet blandit massa, mollis sodales sapien tempus vel. Integer vestibulum, enim eu convallis ultrices, quam felis dictum elit, vitae faucibus leo nisi vitae nunc. Proin finibus volutpat rutrum.</p>";
//            hello = "<p>hi</p>";
            System.out.println(preview.indexOf(">"));
            System.out.println(preview.indexOf("</p>"));
            System.out.println(preview.lastIndexOf("</p>"));
//            System.out.println(hello.substring(0, 50));

            boolean openingPTagIsLessThan50 = preview.indexOf(">")<50;
            int startOfPreview =preview.indexOf(">");
            int contentpreview=(preview.indexOf(">")+50);
            int firstClosingTag = preview.indexOf("</p>");

//            System.out.println(hello.substring(0,hello.indexOf("</p>")+4));
//            System.out.println(hello.substring(0,hello.indexOf(">")+50));

            int indexOfFirstParagraph = preview.indexOf("</p>")+4;
            int indexOfIntendedContextPreview = preview.indexOf(">")+50/*+4*/;

            if(indexOfFirstParagraph<indexOfIntendedContextPreview){
                System.out.println(preview.substring(0,indexOfFirstParagraph)+"...");
            }else{
                System.out.println(preview.substring(0,indexOfIntendedContextPreview)+"...</p>");
            }

        } catch (StringIndexOutOfBoundsException e) {
            System.out.println("OOB caught");
        }
//        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase("E:\\PGCert InfoTech\\Project\\vrm_project\\web\\mysql.properties"))) {
//            Article a = dao.getOneArticle(45);
//            System.out.println("hi");
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    private void testDates() {
//        String submittedDate = "9999-12-31";
        String submittedDate = "2018-01-30";
        System.out.println("CreateArticles: date " + submittedDate);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        System.out.println("Date today: " + LocalDate.now());

        java.sql.Date sqlDate1 = java.sql.Date.valueOf(LocalDate.now());


        LocalDate submittedDateReformatted = LocalDate.parse(submittedDate, formatter);
        System.out.println(LocalDate.now().equals(submittedDateReformatted));
        java.sql.Date sqlDate2 = java.sql.Date.valueOf(submittedDateReformatted);

//        System.out.println(sqlDate);

        System.out.println(sqlDate1.compareTo(sqlDate2));
        System.out.println(sqlDate2.compareTo(sqlDate1));
    }

    private void testNest() {
        System.out.println("test nest");

        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase("E:\\PGCert InfoTech\\Project\\vrm_projectTuesday\\web\\mysql.properties"))) {
            System.out.println(" Connection Success");
            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
            System.out.println("TestRandomCode Comments on articles uploaded. Size: " + firstDegreeComments.size());
            int count = 0;
            for (CommentOnArticles com : firstDegreeComments) {
                if (com.getParentCommentID() == 0) {
                    System.out.println("this is a parent: " + com.getContent());
                    count++;
                    for (CommentOnArticles son : firstDegreeComments) {
                        if (son.getParentCommentID() == com.getCommentID()) {
                            System.out.println("\tmy child: " + son.getContent());
                            count++;
                        }
                    }
                }
            }
            System.out.println("Total printed: " + count + " out of " + firstDegreeComments.size());

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private ArrayList<CommentOnArticles> getNestedList(List<CommentOnArticles> comments, int parent) {
        ArrayList<CommentOnArticles> newList = new ArrayList<>();
        for (CommentOnArticles com : comments) {
            if (com.getParentCommentID() == 0) {
                System.out.println(com.getCommentAuthor() + ": " + com.getContent());
            }
        }

        return newList;
    }

}
