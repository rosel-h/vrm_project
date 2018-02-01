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

        System.out.println("CheckPasswordServlet enter line 33: password=" + password + ", cPassword=" + cPassword);

        String error = "";
        if (password.equals("")) {
            if (cPassword.equals("")) {
                //both empty
                error = "999";
            }else {
                //psw empty
                error = "888";
            }
        }else {
            if (cPassword.equals("")) {
                //check psw, confirm empty
                error = checkPassword(password) + "0";
            }else {
                //check psw and confirm
                error = checkPassword(password) + "0" + checkPassword(cPassword);

                if (error.equals("000")) {
                    if (!password.equals(cPassword)) {
                        error = "0004";
                    }
                }else if (error.charAt(0) == '0') {
                    error = "0004";
                }

            }
        }

        System.out.println("CheckPasswordServlet enter line 55: error=" + error);
        resp.getWriter().write(error);

    }

    public int checkPassword(String password) {

        int msg = 0;
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasInt = false;
        boolean hasFour = false;

        for (int i = 0; i < password.length(); i++) {
            if (password.charAt(i) >= 'A' && password.charAt(i) <= 'Z') {
                hasUpper = true;
            }
            if (password.charAt(i) >= 'a' && password.charAt(i) <= 'z') {
                hasLower = true;
            }
            if (password.charAt(i) >= '0' && password.charAt(i) <= '9') {
                hasInt = true;
            }
            if (password.length() >= 4) {
                hasFour = true;
            }
        }

        if (!hasUpper) {
            msg = 1;
        }else if (!hasLower) {
            msg = 2;
        }else if (!hasInt) {
            msg = 3;
        }else if (!hasFour) {
            msg = 4;
        }

        return msg;

    }

    public boolean checkTwoPasswords(String psw, String cpsw) {
        boolean msg = false;
        if (psw.equals(cpsw)) {
            msg = true;
        }

        return msg;
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
