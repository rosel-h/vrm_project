import DAO_setup.MYSQLDatabase;
import DAO_setup.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/2/6
 * Time : 12:49
 **/
public class ForgetPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String dob = req.getParameter("dob");
        String security_q = req.getParameter("security_q");
        String security_a = req.getParameter("security_a");
        System.out.println("ForgetPassword enter line 22: username=" + username + ",dob=" + dob + ",sq=" + security_q + ",sa=" + security_a);

        try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("ForgetPassword Connection Successful");

            if (userDAO.getUserByUsername(username) == null) {
                System.out.println("ForgetPassword enter line 149: username doesn't exist");
                req.setAttribute("Error", "There is something wrong with the information provided");
                req.getRequestDispatcher("forgetPassword.jsp").forward(req, resp);

            } else if (userDAO.getUserByUsername(username).getStatus().equals("facebook")) {
                System.out.println("ForgetPassword enter line 149: username doesn't exist");
                req.setAttribute("Error", "This is a Facebook account");
                req.getRequestDispatcher("forgetPassword.jsp").forward(req, resp);

            } else if (!userDAO.getUserByUsername(username).getDateOfBirth().equals(dob)) {
                System.out.println("ForgetPassword enter line 149: date of birth is wrong");
                req.setAttribute("Error", "There is something wrong with the information provided");
                req.getRequestDispatcher("forgetPassword.jsp").forward(req, resp);

            }else if (userDAO.getUserByUsername(username).getSecurity_q().equals("") || userDAO.getUserByUsername(username).getSecurity_a().equals("") ){
                System.out.println("ForgetPassword enter line 149: security question or answer is wrong");
                req.setAttribute("Error", "You didn't set security question or answer. Please contact administrator.");
                req.getRequestDispatcher("forgetPassword.jsp").forward(req, resp);

            } else if (!userDAO.getUserByUsername(username).getSecurity_q().equals(security_q) || !userDAO.getUserByUsername(username).getSecurity_a().equals(security_a)) {
                System.out.println("ForgetPassword enter line 149: security question or answer is wrong");
                req.setAttribute("Error", "There is something wrong with the information provided");
                req.getRequestDispatcher("forgetPassword.jsp").forward(req, resp);

            } else {
                System.out.println("ForgetPassword enter line 36: username and dob verification success");
                req.setAttribute("username", username);
                req.setAttribute("verify", "success");
                req.getRequestDispatcher("reset").forward(req, resp);
            }

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
