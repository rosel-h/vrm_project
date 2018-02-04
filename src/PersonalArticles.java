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
import java.util.List;

/**
 * Created by rher490 on 30/01/2018.
 */
public class PersonalArticles extends HttpServlet {
    private int pageNumber = 1;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Personal Articles: do get");
        String number = req.getParameter("_p");
        System.out.println("Personal Articles: "+number);
        try{
            pageNumber = Integer.parseInt(number);
        }catch (NumberFormatException e){
            System.out.println("Personal Articles: Someone tried to cheat the pages get method");
        }
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Personal Articles: do post");
        //get username details
        HttpSession session = req.getSession(false);

        String user = String.valueOf(session.getAttribute("personLoggedIn"));
        String op = req.getParameter("operation");
        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("Personal Articles Signup done");
            int totalArticlesSoFar = dao.getTotalArticles(user);
            int totalPages = totalArticlesSoFar/10+1;
            if(pageNumber >totalPages){
                pageNumber =totalPages;
            }else if(pageNumber<1){
                pageNumber=1;
            }

//            String icon = dao.getIcon(user);
//            System.out.println("Personal Articles user datails = "+icon + " " + user);
//            if (user != null) {
//                req.setAttribute("personLoggedIn", user);
//                String iconPath = getServletContext().getRealPath("avatars");
//                req.setAttribute("personAvatarIcon", icon);
//            }

            int checkNumber = this.pageNumber;
//            List<Article> myArticles = dao.getMyArticles(user);
            List<Article> myArticles = dao.getTenOfMyArticles(user,"date",checkNumber,true);
            System.out.println(myArticles.size());
            System.out.println("Personal Articles: Articles added (size: "+myArticles.size()+")");
            req.setAttribute("lastPage",totalPages);
            req.setAttribute("currentPage",checkNumber);
            req.setAttribute("myArticles",myArticles);
            req.getRequestDispatcher("myArticles.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
