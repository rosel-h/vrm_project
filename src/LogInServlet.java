/**
 * Created by vwen239 on 23/01/2018.
 */

import DAO_setup.MYSQLDatabase;
import org.json.simple.JSONValue;



import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


public class LogInServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html"); // change to text/jsp at a later stage
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");

        HttpSession sess = request.getSession(true);
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) sess.getAttribute("database");
        System.out.println("enter line 36:"+ sess.getId());

        System.out.println(checkUser(username, pass, mysqlDatabase));

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
            System.out.println("enter line 52:" + sessiont_id);
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("/Sessions");
            System.out.println("enter line 50: " + filePath);
            File sessionFolder = new File(filePath);
            if (!sessionFolder.exists()) {
                sessionFolder.mkdir();
            }

            String fileName = filePath + "\\" + sessiont_id + ".json";
            System.out.println("enter line 53: " + fileName );
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

        System.out.println("Connection attempt...");
        Properties dbProps = new Properties();
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");

        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Establishing connection to the database
        try (Connection conn = mysqlDatabase.getConnection()) {
            System.out.println("connection successful");
            PreparedStatement ps = conn.prepareStatement
                    ("select * from vrm_users where binary username=? and binary psw_hash=?");
            ps.setString(1, username);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery(); // will be an empty set if login in correct
            loginStatus = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return loginStatus;
    }

    //get function is post function
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
