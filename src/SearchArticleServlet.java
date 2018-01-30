import DAO_setup.*;
import org.jooq.tools.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Mengjie
 * Date : 2018/1/27
 * Time : 15:31
 **/
public class SearchArticleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("SearchArticleServlet enter servlet");

        HttpSession session = req.getSession(true);

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(fileName);
        String user = null;
        String op = req.getParameter("operation");
        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("mysql.properties")))) {
            System.out.println("SearchArticleServlet enter line 50: ");

            if (sessionFile.exists()) {
                System.out.println("SearchArticleServlet enter line 53: session exists");
                userJson = User.readJSONFile(fileName);
                System.out.println(JSONObject.toJSONString(userJson));
                user = String.valueOf(userJson.get("username"));
            } else {
                System.out.println("SearchArticleServlet enter line 58: session does'nt exist");
            }

            String icon = dao.getIcon(user);
            System.out.println(icon + " "+ user);
            if (user != null) {
                req.setAttribute("personLoggedIn", user);
                String iconPath = getServletContext().getRealPath("avatars");
                req.setAttribute("personAvatarIcon", icon);
            }

            List<Article> articles = new ArrayList<>();

            String searchType = req.getParameter("searchType");
            String keywordStr = req.getParameter("keywords");
            if (keywordStr.equals("")) {
                req.setAttribute("articleList", articles);

                req.getRequestDispatcher("searchresult.jsp").forward(req, resp);
            }
            String[] keywords = keywordStr.split(" ");

            if (searchType.equals("title")) {
                System.out.println("SearchArticleServlet enter line 78: search by title");
                articles = dao.getArticleByTitle(keywords);
            }else if (searchType.equals("username")) {
                System.out.println("SearchArticleServlet enter line 82: search by username");
                articles = dao.getArticleByUsername(keywords);
            }else if (searchType.equals("date")) {
                System.out.println("SearchArticleServlet enter line 86: search by date");
                articles = dao.getArticleByDate(keywords);
            }

            req.setAttribute("articleList", articles);

            req.getRequestDispatcher("searchresult.jsp").forward(req, resp);
            System.out.println("SearchArticleServlet request has been dispatched");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}