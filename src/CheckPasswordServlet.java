import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by Mengjie
 * Date : 2018/1/27
 * Time : 15:08
 **/
public class CheckPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CheckPasswordServlet enter sign up servlet");

        System.out.println("CheckPasswordServlet Connection Successful");

        String password = req.getParameter("password");
        String cPassword = req.getParameter("cPassword");

        boolean hasUppercase = false;
        boolean hasLowercase = false;
        boolean hasInteger = false;
        boolean hasFour = false;
        for (int i = 0; i < password.length(); i++) {
            if (password.charAt(i) >= 'A' && password.charAt(i) <= 'Z') {
                hasUppercase = true;
            }
            if (password.charAt(i) >= 'a' && password.charAt(i) <= 'z') {
                hasLowercase = true;
            }
            if (password.charAt(i) >= '0' && password.charAt(i) <= '9') {
                hasInteger = true;
            }
            if (password.length() >= 4) {
                hasFour = true;
            }
        }

        resp.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
        resp.setCharacterEncoding("UTF-8"); // You want world domination, huh?
        if (!password.equals("") && cPassword.equals("")) {
            if (!hasUppercase) {
                resp.getWriter().write("At least contain 1 UPPERCASE character!");
            } else if (!hasLowercase) {
                resp.getWriter().write("At least contain 1 lowercase character!");
            } else if (!hasInteger) {
                resp.getWriter().write("At least contain 1 digit number!");
            } else if (!hasFour) {
                resp.getWriter().write("Minimum length of password is 4!");
            } else {
                resp.getWriter().write("Password is valid!");
            }
        }

        System.out.println("CheckPasswordServlet enter line 57: " + password + "," + cPassword);
        resp.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
        resp.setCharacterEncoding("UTF-8"); // You want world domination, huh?
        if (!cPassword.equals("")) {
            if (!cPassword.equals(password)) {
                resp.getWriter().write("Two passwords are different!");
            } else {
                resp.getWriter().write("Password is valid!");
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
