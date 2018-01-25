import DAO_setup.*;
import org.jooq.DSLContext;
import org.jooq.Record;
import org.jooq.Result;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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
        System.out.println("do get");

        HttpSession session = req.getSession(true);
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try (BlogDAO dao = new BlogDAO(mysqlDatabase)) {
            System.out.println("LoadArticlesServlet Signup done");
            List<User> users = dao.getAllUsers();
            System.out.println("LoadArticlesServlet Users uploaded");
            List<Article> articles = dao.getAllArticles();
            System.out.println("LoadArticlesServlet Articles created");
            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
            System.out.println("LoadArticlesServlet Comments on articles uploaded. Size: " + firstDegreeComments.size());
            List<CommentsOnComments> nestedComments = dao.getAllNestedComments();
            System.out.println("LoadArticlesServlet nestedcomments created. Size: " + nestedComments.size());


//            System.out.println();
//            for (Article b : articles) {
//                System.out.println(b.getTitle());
//                for (CommentOnArticles a : firstDegreeComments) {
////                    System.out.println(a);
//                    if (a.getArticleID() == b.getArticleID()) {
//                        System.out.println(a.getCommentAuthor() + ": " + a.getContent());
//                        System.out.println("yes");
//                    }
//                }
//            }

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("post");
    }
}
