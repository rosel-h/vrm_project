import DAO_setup.Article;
import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by rher490 on 25/01/2018.
 */
public class EditArticle extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //set up prerequisites
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);

        //csrfToken Logic
        String csrfSessionToken = (String) session.getAttribute("csrfSessionToken");
        String csrfToken = req.getParameter("csrfToken");

        if (!csrfSessionToken.equals(csrfToken)) {
            System.out.println("csrfTokens not verified");
            resp.sendError(666);
            return;
        }

        System.out.println("in Edit ArticleServlet");
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("WEB-INF/mysql.properties");

        String op = req.getParameter("operation");
        String id = req.getParameter("articleID");
        System.out.println("in Edit ArticleServlet: op " + op + "(id +" + id + ")");
        int articleID = Integer.parseInt(id);

        boolean articleHasBeenEdited;
        if ("goToEditPage".equals(op)) {
            //landing page for edit article
            try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {
                Article articleToBeEdited = dao.getOneArticle(articleID);
                req.setAttribute("articleToEdit", articleToBeEdited);
                req.getRequestDispatcher("editArticle.jsp").forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("userHasEditedArticle".equals(op)) {
            System.out.println("EditArticle Servlet: add to dao");
            String author = req.getParameter("author");
            String newTitle = req.getParameter("title");
            String newContent = req.getParameter("content");
            String newDate = req.getParameter("futureDate");
            java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());

            System.out.println("EditArticle Servlet: author " + author + "newTitle: " + newTitle);

            try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {

                if (newDate.length() < 5) {
                    System.out.println("EditArticle Servlet: newContent " + newContent);
                    articleHasBeenEdited = dao.editArticle(articleID, newTitle, newContent);
                    System.out.println("EditArticle Servlet: Article added to database without date");

                } else {
                    //if user has opted to change the publish date
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate submittedDateReformatted = LocalDate.parse(newDate, formatter);
                    java.sql.Date anotherSqlDate = java.sql.Date.valueOf(submittedDateReformatted);
                    articleHasBeenEdited = dao.editArticle(articleID, newTitle, newContent, anotherSqlDate);
                    System.out.println("EditArticle Servlet: Article added to database with date: " + newDate);
                }
                if (articleHasBeenEdited) {
                    System.out.println("EditArticle Servlet: Article added to database");

                    //print log to file
                    Map<String, String> map = new HashMap<>();
                    map.put("articleID", String.valueOf(articleID));
                    map.put("newTitle", newTitle);
                    map.put("newContent", newContent);
                    map.put("submittedDate", String.valueOf(sqlDate));
                    map.put("operation", op);

                    String ipAddress = req.getRemoteAddr();
                    map.put("ip", ipAddress);

                    String logType = "EditArticle";
                    LogWriter logWriter = new LogWriter(logType);
                    logWriter.init(getServletContext().getRealPath("log"));
                    logWriter.write(logType, map);
                    //end of logging code
                }
                req.getRequestDispatcher("myArticles").forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}