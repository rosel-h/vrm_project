/**
 * Created by vwen239 on 23/01/2018.
 */

import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;
import org.json.simple.JSONValue;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class LogInServlet extends HttpServlet {
    User user;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");
        String duration = request.getParameter("remember");

        HttpSession sess = request.getSession(true);

        if (checkUser(username, pass)) {
            Map<String, String> jsonMap = new HashMap<>();
            jsonMap.put("username", username);

            String jsonText = JSONValue.toJSONString(jsonMap);
            System.out.println("LoginServlet json text - " + jsonText);
            String sessiont_id = sess.getId();
            System.out.println("LoginServlet: " + sessiont_id);
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("WEB-INF/Sessions");
            System.out.println("LoginServlet enter line 55: filePath= " + filePath);
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

            sess.setAttribute("personLoggedIn", jsonMap.get("username"));
            try {
                sess.setAttribute("user",new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties"))).getUserByUsername(username));
            } catch (SQLException e) {
                e.printStackTrace();
            sess.setAttribute("user", user);

            if (duration != null) {
                System.out.println("setting maximum session duration");
                sess.setMaxInactiveInterval(60 * 60 * 24 * 21); // log out after a month of inactivity
                System.out.println("max session set to " + sess.getMaxInactiveInterval());
            }

            // Mr Meads generates a long random key for csrfToken
            sess.setAttribute("csrfSessionToken", MrMeads.randomString(60));
            RequestDispatcher rs = request.getRequestDispatcher("Welcome");
            rs.forward(request, response);

        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    //check password function
    public boolean checkUser(String username, String pass) {
        boolean loginStatus = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("LoginServlet Connection attempt...");

        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("LoginServlet connection successful");
            user = dao.getUserStandard(username, pass);

            if (user != null) {
                loginStatus = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return loginStatus;
    }

    //get function is post function
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
