import DAO_setup.MYSQLDatabase;
import DAO_setup.UserDAO;
import com.mysql.fabric.xmlrpc.base.Array;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.JSONTokener;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;
import java.util.List;

/**
 * Created by mshe666 on 23/01/2018.
 */
public class SignUpServlet extends HttpServlet {
    // this is for local host
//    private static final String SECRET_KEY = "6Lcm70MUAAAAAACdrHaIDupGxaTx42JOwTZubiVn";

    // this is for sporadic
//    private static final String SECRET_KEY = "6LfS8UMUAAAAAKGHuY1p1voSxu1vPvWSeu4KcvKN";

    boolean hasUppercase = false;
    boolean hasLowercase = false;
    boolean hasInteger = false;
    boolean hasFour = false;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("SignUpServlet enter sign up servlet");

        try {
            createUser(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException, JSONException {

        String gRecaptchaResponse = req.getParameter("g-recaptcha-response");
        System.out.println("g-recaptcha-response=" + gRecaptchaResponse);
        boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
        writeLog(req, gRecaptchaResponse, verify);

        System.out.println("SignUpServlet enter line 70: reCAPTHCA verify=" + verify);

        if (!verify) {
            req.setAttribute("recaptchaError", "Hey! You are a ROBOT!");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

            // Establishing connection to the database
            System.out.println("SignUpServlet Connection attempt...");
            try (UserDAO userDAO = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
                System.out.println("SignUpServlet Connection Successful");

                // load field value from sign up page
                Map<String, String[]> paraMaps = req.getParameterMap();

                String username = (paraMaps.get("username")[0].equals("")) ? "" : paraMaps.get("username")[0];
                String password= (paraMaps.get("password")[0].equals("")) ? "" : paraMaps.get("password")[0];
                String cPassword = (paraMaps.get("cPassword")[0].equals("")) ? "" : paraMaps.get("cPassword")[0];
                String fname = (paraMaps.get("fname")[0].equals("")) ? "" : paraMaps.get("fname")[0];
                String lname = (paraMaps.get("lname")[0].equals("")) ? "" : paraMaps.get("lname")[0];
                String dob = (paraMaps.get("dob")[0].equals("")) ? "" : paraMaps.get("dob")[0];//if user's dob field is empty, use 1970-01-01 as default
                String country = (paraMaps.get("country")[0].equals("")) ? "" : paraMaps.get("country")[0];
                String description = (paraMaps.get("description")[0].equals("")) ? "" : paraMaps.get("description")[0];
                String avatar = (paraMaps.get("avatar") == null) ? "avatar_01.png" : paraMaps.get("avatar")[0];
                String email = "";

                System.out.println("SignUpServlet enter line 147: " + username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

                // method call to validate username
                usernameValidate(req, resp, userDAO, username);
                // method call to validate passwaord format
                passwordValidate(password);

                System.out.println("SignUpServlet enter line 173: " + hasUppercase + "," + hasLowercase + "," + hasInteger + "," + hasFour);
                // method call to valid confirm password
                confirmPasswordValidate(req, resp, password, cPassword);
                // method call to valid date of birth
                dobValidate(req, resp, dob);

                // hash password
                String password_hashed = SiteSecurity.hashString(password);
                // add user into database, return true if success
                boolean signupSuccess = userDAO.addUser(username, password_hashed, fname, lname, dob, country, description, avatar, "active", "");
                System.out.println("SignUpServlet enter line 231: success = " + signupSuccess);

                // direct to sign up success page
                req.setAttribute("successMessage", "Sign up successfully!");
                req.setAttribute("directMessage", "You will be directed to login page");
                req.setAttribute("directErrorMessage", "true");
                req.getRequestDispatcher("signupsuccess.jsp").forward(req, resp);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }


    }

    private void dobValidate(HttpServletRequest req, HttpServletResponse resp, String dob) throws ServletException, IOException {
        if (dob.equals("")) {
            System.out.println("SignUpServlet enter line 116: date of birth empty");
            req.setAttribute("dobError", "date of birth cannot be empty");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
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

    private void usernameValidate(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO, String username) throws ServletException, IOException {
        if (userDAO.getUserByUsername(username) != null) {
            System.out.println("SignUpServlet enter line 149: username exists");
            req.setAttribute("usernameError", "username already exists");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }else if (username.length() < 4) {
            System.out.println("SignUpServlet enter line 201: username too short");
            req.setAttribute("usernameError", "username at least contains 4 characters!");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
    }

    private void writeLog(HttpServletRequest req, String gRecaptchaResponse, boolean verify) throws IOException {
        // print log to file: reCAPTCHA log
        Map<String, String> map = new HashMap<>();
        map.put("recaptcha",gRecaptchaResponse);

        String ipAddress =  req.getRemoteAddr();
        map.put("ip", ipAddress);
        map.put("result",String.valueOf(verify));

        String logType = "reCAPTCHAVerification";
        LogWriter logWriter = new LogWriter(logType);
        logWriter.init(getServletContext().getRealPath("log"));
        logWriter.write(logType,map);
        // end of logging code
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


}