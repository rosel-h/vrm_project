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
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


public class LogInServlet extends HttpServlet {
    User user;
    String errorMessage = ""; //error message to be send back to the login if failed

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
            String sessiont_id = sess.getId();
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("WEB-INF/Sessions");
            File sessionFolder = new File(filePath);

            if (!sessionFolder.exists()) {
                sessionFolder.mkdir();
            }

            String fileName = filePath + "\\" + sessiont_id + ".json";
            File sessionFile = new File(fileName);

            try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(sessionFile))) {
                bufferedWriter.write(jsonText);
            }

            sess.setAttribute("personLoggedIn", user.getUsername());
            sess.setAttribute("user", user);

            //print log to file
            Map<String, String> map = new HashMap<>();
            map.put("username",username);

            String ipAddress =  request.getRemoteAddr();
            map.put("ip", ipAddress);

            String logType = "Login";
            LogWriter logWriter = new LogWriter(logType);
            logWriter.init(getServletContext().getRealPath("log"));
            logWriter.write(logType,map);
            //end of logging code
            sess.setAttribute("logintimestamp", new Date().getTime());
            sess.setAttribute("username",username);


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

        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {
            user = dao.getUserStandard(username, pass);

            if (user == null) {
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
