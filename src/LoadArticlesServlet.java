import DAO_setup.*;
import org.jooq.DSLContext;
import org.jooq.Record;
import org.jooq.Result;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;
import org.jooq.tools.json.JSONObject;

import javax.ejb.Local;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Properties;

import static blah.generated.Tables.VRM_COMMENTS_ON_ARTICLES;
import static blah.generated.Tables.*;
import static blah.generated.tables.VrmArticles.VRM_ARTICLES;


/**
 * Created by rher490 on 22/01/2018.
 */
public class LoadArticlesServlet extends HttpServlet {

    public void start() throws IOException, SQLException {
//        Article n
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.print("do get");
        doPost(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("> now post");

        HttpSession session = req.getSession(true);

        boolean userHasLoggedIn = session.isNew();

//        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
//        if (mysqlDatabase == null) {
//            try {
//                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }

        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(fileName);
        String user = null;
        String op = req.getParameter("operation");
        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("mysql.properties")))) {
            System.out.println("LoadArticlesServlet Signup done");

            if (sessionFile.exists()) {
                System.out.println("session exists");
                userJson = User.readJSONFile(fileName);
                System.out.println(JSONObject.toJSONString(userJson));
                user = String.valueOf(userJson.get("username"));
            } else {
                System.out.println("session doesnt exist");
            }
            //add articles
            if ("add".equals(op)) {
                String title = req.getParameter("title");
                String content = req.getParameter("content");

                //check if date is to be published today or not
                String submittedDate = req.getParameter("futureDate");
                System.out.println("CreateArticles: date " + submittedDate);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                java.sql.Date sqlDate;

                if(submittedDate.length()<10){
                    sqlDate = java.sql.Date.valueOf(LocalDate.now());
                }else{
                    LocalDate submittedDateReformatted = LocalDate.parse(submittedDate, formatter);
                    sqlDate = java.sql.Date.valueOf(submittedDateReformatted);
                }

                dao.addArticle(title, content, user, sqlDate);
                System.out.println("CreateArticles: new article made");

            } else if ("delete".equals(op)) {
                System.out.println("EditArticle: Delete option");
//                String qwak = ;
                System.out.println(req.getParameter("articleId"));
                int id = Integer.parseInt(req.getParameter("articleId"));
                dao.deleteArticle(id);

            } else if ("commentOnArticle".equals(op)) {
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
                System.out.println("CreateArticles: new article made");
            } else if ("deleteCommentOnArticle".equals(op)) {
                System.out.println("LoadArticlesServlet: delete button pressed");
                String commentIDToBeDeleted = req.getParameter("commentID");
                System.out.println();
                System.out.println("LAS: id - " + commentIDToBeDeleted);
                dao.deleteCommentOnArticle(Integer.parseInt(commentIDToBeDeleted));
            }


            String icon = dao.getIcon(user);
            System.out.println(icon + " " + user);
            if (user != null) {
                req.setAttribute("personLoggedIn", user);
                String iconPath = getServletContext().getRealPath("avatars");
                req.setAttribute("personAvatarIcon", icon);
            }

            List<User> users = dao.getAllUsers();
            System.out.println("LoadArticlesServlet Users uploaded");
            List<Article> articles = dao.getAllArticles();
            System.out.println("LoadArticlesServlet Articles created");
            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
            System.out.println("LoadArticlesServlet Comments on articles uploaded. Size: " + firstDegreeComments.size());
            List<CommentsOnComments> nestedComments = dao.getAllNestedComments();
            System.out.println("LoadArticlesServlet nestedcomments created. Size: " + nestedComments.size());
            req.setAttribute("articleList", articles);
            req.setAttribute("userList", users);
            req.setAttribute("commentList", firstDegreeComments);
            req.setAttribute("nestedList", nestedComments);

            req.getRequestDispatcher("explore.jsp").forward(req, resp);
            System.out.println("LoadArticlesServlet request has been dispatched");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
