import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

/**
 * Created by Mengjie
 * Date : 2018/2/6
 * Time : 13:37
 **/
public class ResetPassword extends HttpServlet {

    boolean hasUppercase = false;
    boolean hasLowercase = false;
    boolean hasInteger = false;
    boolean hasFour = false;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Establishing connection to the database
        System.out.println("ResetPassword Connection attempt...");
        try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("ResetPassword Connection Successful");

            // load field value from sign up page
            Map<String, String[]> paraMaps = req.getParameterMap();
            String username = (paraMaps.get("username")[0].equals("")) ? "" : paraMaps.get("username")[0];
            String password= (paraMaps.get("password")[0].equals("")) ? "" : paraMaps.get("password")[0];
            String cPassword = (paraMaps.get("cPassword")[0].equals("")) ? "" : paraMaps.get("cPassword")[0];

            // method call to validate passwaord format
            passwordValidate(password);

            // method call to valid confirm password
            confirmPasswordValidate(req, resp, password, cPassword);

            // hash password
            String password_hashed = SiteSecurity.hashString(password);

            User user = userDAO.getUserByUsername(username);
            user.setPassword(password_hashed);

            //update user info in database
            boolean updateSuccess = userDAO.updatePassword(user);

            //if update success, redirect to welcome.jsp
            if (updateSuccess) {
                System.out.println("ResetPassword enter line 55: updateSuccess=" + updateSuccess);
                req.setAttribute("successMessage", "Reset password successfully");
                req.setAttribute("user", user);
                req.getRequestDispatcher("login.jsp").forward(req, resp);
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

    private void passwordValidate(String password) {
        for (int j = 0; j < password.length(); j++) {
            if (password.charAt(j) >= 'A' && password.charAt(j) <= 'Z') {
                hasUppercase = true;
            }
            if (password.charAt(j) >= 'a' && password.charAt(j) <= 'z') {
                hasLowercase = true;
            }
            if (password.charAt(j) >= '0' && password.charAt(j) <= '9') {
                hasInteger = true;
            }
            if (password.length() >= 4) {
                hasFour = true;
            }
        }
    }

    private void confirmPasswordValidate(HttpServletRequest req, HttpServletResponse resp, String password, String cPassword) throws ServletException, IOException {
        if (!cPassword.equals(password)) {
            req.setAttribute("passwordError", "two passwords are different");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        } else if (!hasUppercase || !hasLowercase || !hasInteger || !hasFour) {
            req.setAttribute("passwordError", "Your password should contain at least 1 UPPERCASE character, 1 lowercase character, 1 digit number, and minimum length is 4!");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
    }

}
