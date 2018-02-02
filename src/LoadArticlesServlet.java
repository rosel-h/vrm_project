import DAO_setup.*;
import org.jooq.DSLContext;
import org.jooq.Record;
import org.jooq.Result;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;
import org.jooq.tools.json.JSONObject;

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

        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("WEB-INF/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;
        File sessionFile = new File(fileName);
        String user = null;
        String op = req.getParameter("operation");

        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("LoadArticlesServlet Signup done");

            if (sessionFile.exists()) {
                System.out.println("session exists");
                userJson = User.readJSONFile(fileName);
                System.out.println(JSONObject.toJSONString(userJson));
                user = String.valueOf(userJson.get("username"));
            } else {
                System.out.println("session doesnt exist");
            }



            String icon = dao.getIcon(user);
            System.out.println(icon + " " + user);
            if (user != null) {
                req.setAttribute("personLoggedIn", user);
                String iconPath = getServletContext().getRealPath("avatars");
                req.setAttribute("personAvatarIcon", icon);
            }

//            List<User> users = dao.getAllUsers();
//            System.out.println("LoadArticlesServlet Users uploaded");
            List<Article> articles = dao.getAllArticles();
            req.setAttribute("articleList", articles);
            System.out.println("LoadArticlesServlet Articles created");
//            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
//            System.out.println("LoadArticlesServlet Comments on articles uploaded. Size: " + firstDegreeComments.size());
//            List<CommentOnArticles> commentsWithChildren = CommentOnArticles.pairCommentsRelationship(firstDegreeComments);
//            System.out.println("LoadArticlesServlet Comments as nestedshape. Size: " + commentsWithChildren.size());
//            List<CommentsOnComments> nestedComments = dao.getAllNestedComments();
//            System.out.println("LoadArticlesServlet nestedcomments created. Size: " + nestedComments.size());
//            req.setAttribute("userList", users);
//            req.setAttribute("commentList", commentsWithChildren/*firstDegreeComments*/);

//            req.setAttribute("nestedList", nestedComments);

            req.getRequestDispatcher("explore.jsp").forward(req, resp);
            System.out.println("LoadArticlesServlet request has been dispatched");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
