import DAO_setup.Article;
import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import org.jooq.tools.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

/**
 * Created by rher490 on 25/01/2018.
 */
public class CreateArticle extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");
//        System.out.println("Create Article: "+session.isNew());
//        System.out.println("Create Aritcle "+session.getAttribute("username"));
//        String user = "thisshouldnotbehere" /*(String) session.getAttribute("username")*/;
//        if (!session.isNew()){
//            user = String.valueOf(session.getAttribute("username"));
//        }

        HttpSession session = req.getSession(true);
        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(fileName);
        String user = null;

        if (sessionFile.exists()) {
            System.out.println("session exists");
            userJson = User.readJSONFile(fileName);
            System.out.println(JSONObject.toJSONString(userJson));
            user = String.valueOf(userJson.get("username"));
        } else {
            System.out.println("session doesnt exist");
        }

        String op = req.getParameter("operation");
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {

            req.getAttributeNames();

            Map<String, String[]> parameterMap = req.getParameterMap();

            for (String key : parameterMap.keySet()) {

                String[] a = parameterMap.get(key);

                for (int i = 0; i < a.length; i++) {

                    System.out.println(a[i]);

                }

            }


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
