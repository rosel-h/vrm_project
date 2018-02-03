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
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Personal Articles: do post");

        //get username details
        HttpSession session = req.getSession(true);
        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("WEB-INF/Sessions");
        String sessionID = session.getId();
        String fileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(fileName);
        String user = null;
        String op = req.getParameter("operation");
        try (BlogDAO dao = new BlogDAO(/*mysqlDatabase*/ new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("Personal Articles Signup done");

            if (sessionFile.exists()) {
                System.out.println("session exists");
                userJson = User.readJSONFile(fileName);
                System.out.println(JSONObject.toJSONString(userJson));
                user = String.valueOf(userJson.get("username"));
            } else {
                System.out.println("session doesnt exist");
            }
            String icon = dao.getIcon(user);
            System.out.println("Personal Articles user datails = "+icon + " " + user);
            if (user != null) {
                req.setAttribute("personLoggedIn", user);
                String iconPath = getServletContext().getRealPath("avatars");
                req.setAttribute("personAvatarIcon", icon);
            }

            System.out.println();
            List<Article> myArticles = dao.getMyArticles(user);
            System.out.println("Personal Articles: Articles added (size: "+myArticles.size()+")");
//            List<User> users = dao.getAllUsers();
//            System.out.println("Personal Articles Users uploaded");
//            List<CommentOnArticles> firstDegreeComments = dao.getAllFirstComments();
//            System.out.println("Personal Articles Comments on articles uploaded. Size: " + firstDegreeComments.size());
//            List<CommentsOnComments> nestedComments = dao.getAllNestedComments();
//            System.out.println("Personal Articles nestedcomments created. Size: " + nestedComments.size());
//            req.setAttribute("userList", users);
//            req.setAttribute("commentList", firstDegreeComments);
//            req.setAttribute("nestedList", nestedComments);

            req.setAttribute("myArticles",myArticles);
            req.getRequestDispatcher("myArticles.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
