import DAO_setup.Article;
import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by rher490 on 30/01/2018.
 * This java class deals with retrieves articles that the logged in user has created so far.
 * Only shows 10 pages at the time.
 */
public class PersonalArticles extends HttpServlet {
    private int pageNumber = 1;
    private boolean wentThroughGetMethod = false;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Personal Articles: do get");
        String number = req.getParameter("_p");
        System.out.println("Personal Articles: " + number);
        try {
            pageNumber = Integer.parseInt(number);
            wentThroughGetMethod = true;
        } catch (NumberFormatException e) {
            System.out.println("Personal Articles: Someone tried to cheat the pages get method");
        }
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Personal Articles: do post");
        HttpSession session = req.getSession(false);
        //get username details
        String user = String.valueOf(session.getAttribute("personLoggedIn"));
        try (BlogDAO dao = new BlogDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("Personal Articles Signup done");
            int totalArticlesSoFar = dao.getTotalArticles(user);
            int totalPages = totalArticlesSoFar / 10 + 1;
            if (pageNumber > totalPages) {
                pageNumber = totalPages;
            } else if (pageNumber < 1) {
                pageNumber = 1;
            }

            int checkNumber = this.pageNumber;
            //ensures that when user leaves the all articles page and comes back, the user will see the start of the page
            if (!wentThroughGetMethod) {
                checkNumber = 1;
            }

            List<Article> myArticles = dao.getTenOfMyArticles(user, "date", checkNumber, true);
            System.out.println(myArticles.size());
            System.out.println("Personal Articles: Articles added (size: " + myArticles.size() + ")");
            req.setAttribute("lastPage", totalPages);
            req.setAttribute("currentPage", checkNumber);
            req.setAttribute("myArticles", myArticles);
            req.getRequestDispatcher("myArticles.jsp").forward(req, resp);
            wentThroughGetMethod = false;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
