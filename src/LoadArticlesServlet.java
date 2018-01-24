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
        PrintWriter out = resp.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8' />");
        out.println("<title>VRM Explorer</title>");
        out.println("</head>\n<body>");
//        HttpSession session = req.getSession();
//        try {
//            try {
//                Class.forName("com.mysql.jdbc.Driver");
//            } catch (ClassNotFoundException e) {
//                e.printStackTrace();
//            }
//
//            System.out.println("Connection attempt...");
//            Properties dbProps = new Properties();
//            ServletContext s = getServletContext();
//            String filepath = s.getRealPath("mysql.properties");
//            try (FileInputStream fis = new FileInputStream(filepath)) {
//                dbProps.load(fis);
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            // Establishing connection to the database
//            try (Connection conn = DriverManager.getConnection(dbProps.getProperty("url"), dbProps)) {
//                System.out.println("Connection Successful");
//                // Access the JOOQ library through this variable.
//                DSLContext create = DSL.using(conn, SQLDialect.MYSQL);
//
//                Result<Record> articles = create.select().from(VRM_ARTICLES).fetch();
//                Result<Record> comments = create.select().from(VRM_COMMENTS_ON_ARTICLES).fetch();
//                Result<Record> nestedComments = create.select().from(VRM_COMMENTS_ON_COMMENTS).fetch();
//
//                out.println("<h1> All the Articles <h1>");
//                for (Record r : articles) {
//                    /*prints out the articles and content*/
//                    out.println("<h3> Title: " + r.getValue("title") + "</h3>");
//                    out.println("<p> Written by: " + r.getValue("username") + " on " + r.getValue("date") + "</p>");
//                    out.println("<p> " + r.getValue("content") + "</p>");
//                    out.println("<br>");
//                    String id = r.getValue("article_id").toString();
//                    System.out.println(id);
////                    Result<Record> comments = create.select().from(VRM_COMMENTS_ON_ARTICLES).where(VRM_COMMENTS_ON_ARTICLES.ARTICLE_ID.eq(Integer.parseInt(r.getValue("articleid").toString()))).fetch();
//                    out.println("<p>Comments</p>");
//                    for (Record com: comments){
//                        if(com.getValue("article_id")==r.getValue("article_id")) {
//                            out.println("<p> " + com.getValue("username") +": "+ com.getValue("content") + "</p>");
//                            for(Record nest: nestedComments){
//                                if(nest.getValue("parent_comment_id")==com.getValue("comment_id")){
//                                    out.println("<p> "+ nest.getValue("username")+ ": "+nest.getValue("content"));
//                                }
//                            }
//                        }
//                                            }
//                    out.println("<hr>");
//                }
//            }
//            out.println("</body>\n</html>");
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        ServletContext s = getServletContext();
            String filepath = s.getRealPath("mysql.properties");
        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(filepath))) {
            System.out.println("Signup done");
            List<User> users = dao.getAllUsers();
            System.out.println("Users uploaded");
            List<Article> articles = dao.getAllArticles();
            System.out.println("Articles created");
            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
            System.out.println("Comments on articles uploaded. Size: "+firstDegreeComments.size());
            List<CommentsOnComments> nestedComments = dao.getAllNestedComments();
            System.out.println("nestedcomments created. Size: "+nestedComments.size());


            System.out.println();
            for(Article b:articles) {
                System.out.println(b.getTitle());
                for (CommentOnArticles a : firstDegreeComments) {
//                    System.out.println(a);
                    if (a.getArticleID()==b.getArticleID()){
                        System.out.println(a.getCommentAuthor() + ": " + a.getContent());
                        System.out.println("yes");
                    }
                }
            }


            req.setAttribute("articleList",articles);
            req.setAttribute("userList",users);
            req.setAttribute("commentList",firstDegreeComments);
            req.setAttribute("nestedList",nestedComments);

            req.getRequestDispatcher("explore.jsp").forward(req,resp);
            System.out.println("request has been dispatched");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("post");
    }
}
