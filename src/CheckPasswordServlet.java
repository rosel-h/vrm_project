
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Created by Mengjie
 * Date : 2018/1/27
 * Time : 15:08
 **/
public class CheckPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //get password and confirm password
        String password = req.getParameter("password");
        String cPassword = req.getParameter("cPassword");

        System.out.println("CheckPasswordServlet enter line 33: password=" + password + ", cPassword=" + cPassword);

        //generate error code for password check
        String error = getErrorCode(password, cPassword);

        //print out error code in console window and send error code to response
        System.out.println("CheckPasswordServlet enter line 56: error=" + error);
        resp.getWriter().write(error);

    }

    private String getErrorCode(String password, String cPassword) {
        String error;
        if (password.equals("")) {
            if (cPassword.equals("")) {
                //password and confirm password both are empty
                error = "999";
            }else {
                //only password is empty
                error = "888";
            }
        }else {
            if (cPassword.equals("")) {
                //confirm password is empty, check password is valid or not
                error = checkPassword(password) + "0";
            }else {
                //check both password and confirm password are valid or not
                error = checkPassword(password) + "0" + checkPassword(cPassword);

                //if bot password and confirm password are valid, check if they are the same
                if (error.equals("000")) {
                    if (!password.equals(cPassword)) {
                        error = "0004";
                    }
                }else if (error.charAt(0) == '0') {
                    error = "0004";
                }

            }
        }

        return error;
    }

    //method to check single password and return error msg for single password
    private int checkPassword(String password) {

        int msg = 0;
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasInt = false;
        boolean hasFour = false;

        for (int i = 0; i < password.length(); i++) {
            if (password.charAt(i) >= 'A' && password.charAt(i) <= 'Z') {
                hasUpper = true; }
            if (password.charAt(i) >= 'a' && password.charAt(i) <= 'z') {
                hasLower = true; }
            if (password.charAt(i) >= '0' && password.charAt(i) <= '9') {
                hasInt = true; }
            if (password.length() >= 4) {
                hasFour = true; }
        }

        if (!hasUpper) { msg = 1; }
        else if (!hasLower) { msg = 2; }
        else if (!hasInt) { msg = 3; }
        else if (!hasFour) { msg = 4; }

        return msg;

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
