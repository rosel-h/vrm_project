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
import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

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
        System.out.println("in Edit ArticleServlet");
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");

//        PrintWriter out = resp.getWriter();
//        out.println("<p>do the edit<p>");

        String op = req.getParameter("operation");

        String id = req.getParameter("articleID");
        int articleID = Integer.parseInt(id);
//        System.out.println("in Edit ArticleServlet: op "+ op+ "(id +" +id+")" + "(parsed id: "+articleID+")");
        boolean articleHasBeenEdited;
        if("goToEditPage".equals(op)) {
            try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {
                Article articleToBeEdited = dao.getOneArticle(articleID);
                req.setAttribute("articleToEdit",articleToBeEdited);
                req.getRequestDispatcher("editArticle.jsp").forward(req, resp);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else if ("userHasEditedArticle".equals(op)) {
                System.out.println("EditArticle Servlet: add to dao");
            String author = req.getParameter("author");
            String newTitle = req.getParameter("title");
            String newContent = req.getParameter("content");
            java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
            newContent =  newContent+ "<p> Edited on:"+sqlDate+"<p>";
//        add date updated
            System.out.println("EditArticle Servlet: author "+author);
            System.out.println("EditArticle Servlet: newTitle "+newTitle);
            System.out.println("EditArticle Servlet: newContent "+newContent);
                try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {
                    articleHasBeenEdited= dao.editArticle(articleID,newTitle,newContent);
                    if(articleHasBeenEdited){
                        System.out.println("EditArticle Servlet: Artciel added to database");
                    }
                    req.getRequestDispatcher("/Articles").forward(req, resp);
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }

