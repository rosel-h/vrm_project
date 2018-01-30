/**
 * Created by vwen239 on 23/01/2018.
 */

import DAO_setup.MYSQLDatabase;
import org.json.simple.JSONValue;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.security.SecureRandom;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


public class LogInServlet extends HttpServlet {

//    String stateParam = ""; //StateParam is a secret random code generated that passes to FB to prevent cross-site-request forgery attacks.

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html"); // change to text/jsp at a later stage
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");

        HttpSession sess = request.getSession(true);
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) sess.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("LoginServlet enter line 38: " + checkUser(username, pass, mysqlDatabase));

        if (checkUser(username, pass, mysqlDatabase)) {

            Map<String, String[]> map = request.getParameterMap();
            Map<String, String> jsonMap = new HashMap<>();
            for (String key : map.keySet()) {
                String value = map.get(key)[0];
                jsonMap.put(key, value);
            }

            String jsonText = JSONValue.toJSONString(jsonMap);

//            HttpSession sess = request.getSession(true);
            String sessiont_id = sess.getId();

            System.out.println("LoginServlet enter line 52:" + sessiont_id);

            ServletContext servletContext = getServletContext();

            String filePath = servletContext.getRealPath("/Sessions");

            File sessionFolder = new File(filePath);
            if (!sessionFolder.exists()) {
                sessionFolder.mkdir();
            }

            String fileName = filePath + "\\" + sessiont_id + ".json";
            System.out.println("LoginServlet enter line 53: " + fileName);
            File sessionFile = new File(fileName);

            try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(sessionFile))) {
                bufferedWriter.write(jsonText);
            }

            RequestDispatcher rs = request.getRequestDispatcher("welcome.jsp");
            rs.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    //check password function
    public boolean checkUser(String username, String pass, MYSQLDatabase mysqlDatabase) {
        boolean loginStatus = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("LoginServlet Connection attempt...");
        Properties dbProps = new Properties();
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");

        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Establishing connection to the database
        try {

            System.out.println("LoginServlet connection successful");
            Connection conn = mysqlDatabase.getConnection();
            PreparedStatement ps = conn.prepareStatement
                    ("select * from vrm_users where binary username=? and binary psw_hash=? and status = ?");

            // code to generate random salt
            String salt = BCrypt.gensalt(12);
            String hashed = BCrypt.hashpw("1234", salt);
            System.out.println("hash is " + hashed);
            System.out.println("salt is " + salt);

            if (BCrypt.checkpw("1234", hashed)) {
                System.out.println("matches");
            }

            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, "active");
            ResultSet rs = ps.executeQuery(); // will be an empty set if login in correct
            loginStatus = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return loginStatus;
    }

    //get function is post function
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        System.out.println("dispatching facebook");
//        stateParam = randomString();
//        OAuth2fb.stateParam = this.stateParam;
//
//        String url = "https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=http://localhost:8181/oauth2fb&scope=email&state=" + stateParam;
//        System.out.println(url);
//        response.sendRedirect(url);
    }

}
