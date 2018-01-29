package blah.generated;

import DAO_setup.*;

import java.sql.ResultSet;
import java.sql.SQLException;

public class testing  {

    public static void main(String[] args) {
        new testing().start();
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
}
