package blah.generated;

import DAO_setup.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class testRandomCode {

    public static void main(String[] args) {
//        new testRandomCode().start();
        new testRandomCode().testDates();
    }

    private void start(){
        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase("E:\\PGCert InfoTech\\Project\\vrm_project\\web\\mysql.properties"))) {
            Article a = dao.getOneArticle(45);
            System.out.println("hi");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void testDates(){
//        String submittedDate = "9999-12-31";
        String submittedDate = "2018-01-30";
        System.out.println("CreateArticles: date " + submittedDate);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        System.out.println("Date today: " + LocalDate.now());

        java.sql.Date sqlDate1= java.sql.Date.valueOf(LocalDate.now());


            LocalDate submittedDateReformatted = LocalDate.parse(submittedDate, formatter);
            System.out.println(LocalDate.now().equals(submittedDateReformatted));
        java.sql.Date sqlDate2= java.sql.Date.valueOf(submittedDateReformatted);

//        System.out.println(sqlDate);

        System.out.println(sqlDate1.compareTo(sqlDate2));
        System.out.println(sqlDate2.compareTo(sqlDate1));
    }
}
