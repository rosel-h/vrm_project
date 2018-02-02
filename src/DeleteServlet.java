import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jooq.tools.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/26
 * Time : 16:06
 **/
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String csrfSessionToken = (String) (session.getAttribute("csrfSessionToken"));
        String reqCsrfToken = req.getParameter("csrfToken");

        System.out.println("csrfSessionToken is " + csrfSessionToken);
        System.out.println("reqCSRFToken is " + reqCsrfToken);

        if (!csrfSessionToken.equals(reqCsrfToken)) {
            System.out.println("Session Error");
            resp.sendError(666);
            return;

        } else {
            String username = (String) session.getAttribute("personLoggedIn");
            System.out.println("DeleteServlet enter line 26: session id = " + session.getId() + ", username=" + username);

            try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("DeleteServlet Connection Successful");

                boolean deleteSuccess = userDAO.deleteUser(username);
                if (deleteSuccess) {
                    System.out.println("DeleteServlet enter line 41: delete success");
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
