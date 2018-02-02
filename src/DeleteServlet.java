import DAO_setup.MYSQLDatabase;
import DAO_setup.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/26
 * Time : 16:06
 **/
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("DeleteServlet enter delete user servlet");

        HttpSession session = req.getSession(false);

        if (session == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }else {
            String username = (String) session.getAttribute("personLoggedIn");
            System.out.println("DeleteServlet enter line 26: session id = " + session.getId() + ", username=" + username);

            try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("DeleteServlet Connection Successful");

                boolean deleteSuccess =  userDAO.deleteUser(username);
                if (deleteSuccess) {
                    System.out.println("DeleteServlet enter line 43: delete success");
                    session.invalidate();
                    req.getRequestDispatcher("Main").forward(req, resp);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
