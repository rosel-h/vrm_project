package files_to_delete_before_deployment.generated;

import DAO_setup.Article;
import DAO_setup.BlogDAO;
import DAO_setup.CommentOnArticles;
import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Mengjie
 * Date : 2018/2/4
 * Time : 17:00
 **/
public class FeaturedArticle extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int articleID = Integer.parseInt(req.getParameter("articleID"));

        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            Article articleToLoad = dao.getOneArticle(articleID);
            System.out.println("FeaturedArticle - articletitle: " + articleToLoad.getTitle());
            List<CommentOnArticles> list = dao.getAllCommentOfArticle(articleID);
            System.out.println("FeaturedArticle - commentList: " + list.size());
            List<CommentOnArticles> commentsWithChildren = CommentOnArticles.pairCommentsRelationship(list);
            System.out.println("FeaturedArticle - commentListCompressed: " + commentsWithChildren.size());
            req.setAttribute("articleToLoad", articleToLoad);
            req.setAttribute("commentList", commentsWithChildren/*firstDegreeComments*/);
            req.getRequestDispatcher("oneArticle.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
