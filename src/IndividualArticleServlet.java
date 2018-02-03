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
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Created by rher490 on 2/02/2018.
 */
public class IndividualArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("IndividualArticleServlet Do get ");
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("> do post");
        HttpSession session = req.getSession(false);
        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("WEB-INF/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;
        File sessionFile = new File(fileName);
        String user = null;
        String op = req.getParameter("operation");
        System.out.println("in do post again");
        String checkIfTheresArticle= req.getParameter("articleID");
        System.out.println("IndividualArticleServlet - article  " + checkIfTheresArticle+ " operation "+op);
        if(checkIfTheresArticle==null&&op==null){
            System.out.println("IAS: this is being redirected to allarticles");
            req.getRequestDispatcher("/Articles").forward(req,resp);
        }else{
//            int articleID = Integer.parseInt(req.getParameter("articleID"));
        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("IndividualArticleServlet Connection success");

            if (sessionFile.exists()) {
                System.out.println("IndividualArticleServlet - session exists");
                userJson = User.readJSONFile(fileName);
                System.out.println(JSONObject.toJSONString(userJson));
                user = String.valueOf(userJson.get("username"));
            } else {
                System.out.println("IndividualArticleServlet - session doesnt exist");
            }

            String icon = dao.getIcon(user);
            System.out.println(icon + " " + user);
            if (user != null) {
                req.setAttribute("personLoggedIn", user);
                String iconPath = getServletContext().getRealPath("avatars");
                req.setAttribute("personAvatarIcon", icon);
            }

            //add articles
            if ("add".equals(op)) {
                String title = req.getParameter("title");
                String content = req.getParameter("content");
                user = String.valueOf( session.getAttribute("personLoggedIn"));
                //check if date is to be published today or not
                String submittedDate = req.getParameter("futureDate");
                System.out.println("IndividualArticleServlet: date " + submittedDate);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                java.sql.Date sqlDate;

                if (submittedDate.length() < 10) {
                    sqlDate = java.sql.Date.valueOf(LocalDate.now());
                } else {
                    LocalDate submittedDateReformatted = LocalDate.parse(submittedDate, formatter);
                    sqlDate = java.sql.Date.valueOf(submittedDateReformatted);
                }
                dao.addArticle(title, content, user, sqlDate);
                System.out.println("IndividualArticleServlet: new article made");
                System.out.println("transfer to new article");
//                adding articles goes to my articles
                req.getRequestDispatcher("myArticles").forward(req, resp);
            } else if ("delete".equals(op)) {
                System.out.println("IndividualArticleServlet: Delete option");
                System.out.println(req.getParameter("articleID"));
                int id = Integer.parseInt(req.getParameter("articleID"));
                dao.deleteArticle(id);
                //deleting articles goes to my articles as well
                req.getRequestDispatcher("myArticles").forward(req, resp);
            } else {
                System.out.println("IndividualArticleServlet: Else Statement");
                //deals with article manipulation
                if ("commentOnArticle".equals(op)) {
                    String userWhoCommented = req.getParameter("userWhoCommented");
                    String comment = req.getParameter("newComment");
                int articleID = Integer.parseInt(req.getParameter("articleID"));
                    java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
                    dao.addCommentToArticle(articleID, userWhoCommented, sqlDate, comment);
                } else if ("editarticle".equals(op)) {
                    String title = req.getParameter("title");
                    String content = req.getParameter("content");
                    java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
                    dao.addArticle(title, content, user, sqlDate);
                    System.out.println("IndividualArticleServlet: new article made");
                } else if ("deleteCommentOnArticle".equals(op)) {
                    System.out.println("IndividualArticleServlet: delete button pressed");
                    String commentIDToBeDeleted = req.getParameter("commentID");
                    System.out.println();
                    System.out.println("LAS: id - " + commentIDToBeDeleted);
                    dao.deleteCommentOnArticle(Integer.parseInt(commentIDToBeDeleted));
                } else if ("replyToAComment".equals(op)) {
                    System.out.println("IndividualArticleServlet replying to comment button pressed");
                    java.sql.Date sqlDate = java.sql.Date.valueOf(LocalDate.now());
                    String userWhoCommented = req.getParameter("userWhoCommented");
                    String comment = req.getParameter("newComment");
                int articleID = Integer.parseInt(req.getParameter("articleID"));
                    int parentComment = Integer.parseInt(req.getParameter("fatherComment"));
                    dao.addCommentToAnotherComment(articleID, userWhoCommented, sqlDate, comment, parentComment);
                }
                int articleID = Integer.parseInt(req.getParameter("articleID"));
                Article articleToLoad = dao.getOneArticle(articleID);
                System.out.println("IndividualArticleServlet - articletitle: " + articleToLoad.getTitle());
                List<CommentOnArticles> list = dao.getAllCommentOfArticle(articleID);
                System.out.println("IndividualArticleServlet - commentList: " + list.size());
                List<CommentOnArticles> commentsWithChildren = CommentOnArticles.pairCommentsRelationship(list);
                System.out.println("IndividualArticleServlet - commentListCompressed: " + commentsWithChildren.size());
                req.setAttribute("articleToLoad", articleToLoad);
                req.setAttribute("commentList", commentsWithChildren/*firstDegreeComments*/);

                req.getRequestDispatcher("oneArticle.jsp").forward(req, resp);

            }


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        }
    }
}
