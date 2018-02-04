import DAO_setup.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


/**
 * Created by rher490 on 22/01/2018.
 */
public class LoadArticlesServlet extends HttpServlet {
    private int pageNumber = 1;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String number = req.getParameter("_p");
        System.out.println("Load article servlet: "+number);
        try{
            pageNumber = Integer.parseInt(number);
        }catch (NumberFormatException e){
            System.out.println("LoadArticleServlet: Someone tried to cheat the pages get method");
        }
        System.out.print("do get");
        doPost(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("> now post");

        HttpSession session = req.getSession(false);

        ServletContext servletContext = getServletContext();

        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("LoadArticlesServlet Signup done");
            int totalArticlesSoFar = dao.getTotalArticles();
            int totalPages = totalArticlesSoFar/10;
            if(pageNumber >totalPages){
                pageNumber =totalPages;
            }else if(pageNumber<1){
                pageNumber=1;
            }
//            List<Article> articles = dao.getAllArticles();
            int checkNumber = this.pageNumber;
            List<Article> articles = dao.getTenArticles("date",checkNumber,true);
            req.setAttribute("lastPage",totalPages);
            req.setAttribute("currentPage",checkNumber);
            req.setAttribute("articleList", articles);
            System.out.println("LoadArticlesServlet Articles created");

            req.getRequestDispatcher("explore.jsp").forward(req, resp);
            System.out.println("LoadArticlesServlet request has been dispatched");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
