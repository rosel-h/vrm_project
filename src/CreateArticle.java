import DAO_setup.Article;
import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

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
        HttpSession session = req.getSession(true);
        String user = (String) session.getAttribute("username");

        String op = req.getParameter("operation");
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            java.sql.Date sqlDate = java.sql.Date.valueOf( LocalDate.now());
//            deletelater
            List<Article> articlesTemp = dao.getAllArticles();
            System.out.println("CreateArticles: Articles List temp created. Size "+articlesTemp.size());

            dao.addArticle(title,content,user,sqlDate);
            System.out.println("CreateArticles: new article made");
            List<Article> articles = dao.getAllArticles();
            System.out.println("CreateArticles: Articles List created. Size "+articles.size());
            req.setAttribute("articleList", articles);
            req.getRequestDispatcher("explore.jsp").forward(req, resp);
            System.out.println("request from CreateArticles has been dispatched");

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


//            else if ("delete".equals(op)) {
//
//                int id = Integer.parseInt(req.getParameter("articleId"));
//                dao.deleteArticle(id);
//
//            }


    }
}
