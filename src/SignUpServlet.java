import DAO_setup.MYSQLDatabase;
import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;
import org.jooq.util.mysql.mysql.Mysql;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.JSONTokener;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.Map;
import java.util.Properties;

/**
 * Created by mshe666 on 23/01/2018.
 */
public class SignUpServlet extends HttpServlet {

    private static final String SITE_SECRET = "6LdzZkIUAAAAAEqAh4IqpMguulLqX0O1CzG7twq7";
    private static final String SECRET_PARAM = "secret";
    private static final String RESPONSE_PARAM = "response";
    private static final String G_RECAPTCHA_RESPONSE = "g-recaptcha-response";
    private static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    private JSONObject performRecaptchaSiteVerify(String recaptchaResponseToken) throws IOException, JSONException {
        URL url = new URL(SITE_VERIFY_URL);
        StringBuilder postData = new StringBuilder();
        addParam(postData, SECRET_PARAM, SITE_SECRET);
        addParam(postData, RESPONSE_PARAM, recaptchaResponseToken);

        return postAndParseJSON(url, postData.toString());
    }

    private StringBuilder addParam(StringBuilder postData, String param, String value) throws UnsupportedEncodingException {
        if (postData.length() != 0) {
            postData.append("&");
        }
        return postData.append(
                String.format("%s=%s",
                        URLEncoder.encode(param, StandardCharsets.UTF_8.displayName()),
                        URLEncoder.encode(value, StandardCharsets.UTF_8.displayName())));
    }

    private JSONObject postAndParseJSON(URL url, String postData) throws IOException, JSONException {
        HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
        urlConnection.setDoOutput(true);
        urlConnection.setRequestMethod("POST");
        urlConnection.setRequestProperty(
                "Content-Type", "application/x-www-form-urlencoded");
        urlConnection.setRequestProperty(
                "charset", StandardCharsets.UTF_8.displayName());
        urlConnection.setRequestProperty(
                "Content-Length", Integer.toString(postData.length()));
        urlConnection.setUseCaches(false);
        urlConnection.getOutputStream()
                .write(postData.getBytes(StandardCharsets.UTF_8));
        JSONTokener jsonTokener = new JSONTokener(urlConnection.getInputStream());
        return new JSONObject((Map) jsonTokener);
    }


    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException, JSONException {

        System.out.println("SignUpServlet enter sign up servlet");
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // Establishing connection to the database

        System.out.println("SignUpServlet Connection attempt...");
        //plan A:
/*        Properties dbProps = new Properties();
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");
        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }*/
        //plan B:
        HttpSession session = req.getSession(true);
        System.out.println("SignUpServlet enter line 44:" + session.getId());
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // connect to the database
        try {
            Connection conn = mysqlDatabase.getConnection();
            System.out.println("SignUpServlet Connection Successful");

            //username, password, cPassword, fname, lname, dob, country, description, avatar
            Map<String, String[]> paraMap = req.getParameterMap();

            //get username from input and check if it already exists in database
            //if true, return usernameError message
            String username = paraMap.get("username")[0];

            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username = ?;")) {
                stmt.setString(1, username);
                try (ResultSet r = stmt.executeQuery()) {
                    while (r.next()) {
                        req.setAttribute("usernameError", "username already exists");
                        req.getRequestDispatcher("signup.jsp").forward(req, resp);
                        break;
                    }
                }
            }

            //get password and confirm password from input and check if they are exactly the same
            //if true, return password Error message
            String password = paraMap.get("password")[0];
            String cPassword = paraMap.get("cPassword")[0];

            if (!cPassword.equals(password)) {
                req.setAttribute("passwordError", "two passwords are different");
                req.getRequestDispatcher("signup.jsp").forward(req, resp);
            }

            //
            String fname = checkNull(paraMap.get("fname")[0]);
            String lname = checkNull(paraMap.get("lname")[0]);
            String dob = checkNull(paraMap.get("dob")[0]);
            String country = checkNull(paraMap.get("country")[0]);
            String description = checkNull(paraMap.get("description")[0]);
            String avatar = checkNull(paraMap.get("avatar")[0]);
            String email = "";

            System.out.println("SignUpServlet enter line 81: " + username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

            try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_users VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, fname);
                stmt.setString(4, lname);
                stmt.setString(5, dob);
                stmt.setString(6, country);
                stmt.setString(7, description);
                stmt.setString(8, avatar);
                stmt.setString(9, "active");
                stmt.setString(10, email);

                stmt.executeUpdate();

                req.setAttribute("successMessage", "Sign up successfully!");
                req.setAttribute("directMessage", "You will be directed to login page");
                req.setAttribute("directErrorMessage", "true");
                req.getRequestDispatcher("signupsuccess.jsp").forward(req, resp);

                JSONObject jsonObject = performRecaptchaSiteVerify(req.getParameter(G_RECAPTCHA_RESPONSE));
                boolean success = (boolean) jsonObject.get("success");
                req.setAttribute("success", success);
                System.out.println("Success = " + success);


            } catch (ServletException e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

    private String checkNull(Object object) {
        String returnStr = "";
        if (object == null) {
            return returnStr;
        }else {
            return object.toString();
        }
    }


}
