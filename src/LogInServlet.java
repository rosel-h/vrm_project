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
import java.util.HashMap;
import java.util.Map;


public class LogInServlet extends HttpServlet {
    User user;
    String errorMessage = ""; //error message to be send back to the login if failed

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println(SiteSecurity.hashString("1234"));

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");
        System.out.println("the hashed pw is " + pass);
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
            sess.setAttribute("user", user);

            if (duration != null) {
                System.out.println("setting maximum session duration");
                sess.setMaxInactiveInterval(3600 * 24 * 10); // log out after a month of inactivity
                System.out.println("max session set to " + sess.getMaxInactiveInterval());
            }

            // Mr Meads generates a long random key for csrfToken
            sess.setAttribute("csrfSessionToken", SiteSecurity.randomString(60));
            RequestDispatcher rs = request.getRequestDispatcher("Welcome");
            rs.forward(request, response);
        } else {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    //check password function
    public boolean checkUser(String username, String pass) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("LoginServlet Connection attempt...");

        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            System.out.println("LoginServlet connection successful");
            user = dao.getUserStandard(username, pass);

            if (user == null) {
                System.out.println("User login has failed");
                errorMessage = "Invalid Username or Password";
                return false;
            }

            if (user.getStatus().equals("inactive")) {
                errorMessage = "User account has been deleted, please contact us to reactivate.";
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;

    }

    //get function is post function
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
