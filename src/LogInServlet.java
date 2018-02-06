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

    User user; // user object that will be stored in session
    String errorMessage = ""; //relevant error message to be send back to the login fails

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Obtain Parameters
        String username = request.getParameter("username");
        String pass = request.getParameter("pass");

        if (checkUser(username, pass)) {
            //create new session if username is verified
            HttpSession sess = request.getSession(true);

            //storing the username into a json file - in case server crashes, can recover

            Map<String, String> jsonMap = new HashMap<>();
            jsonMap.put("username", username);
            String jsonText = JSONValue.toJSONString(jsonMap);
            String sessiont_id = sess.getId();

            //grab directory
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("WEB-INF/Sessions");
            File sessionFolder = new File(filePath);

            //create directory if not exists
            if (!sessionFolder.exists()) {
                sessionFolder.mkdir();
            }

            //wrote the file name
            String fileName = filePath + "\\" + sessiont_id + ".json";
            File sessionFile = new File(fileName);

            try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(sessionFile))) {
                bufferedWriter.write(jsonText);
            }

            //logging code
            Map<String, String> map = new HashMap<>();
            map.put("username", username);

            String ipAddress = request.getRemoteAddr();
            map.put("ip", ipAddress);

            String logType = "Login";
            LogWriter logWriter = new LogWriter(logType);
            logWriter.init(getServletContext().getRealPath("log"));
            logWriter.write(logType, map);
            //end of logging code

            //set the session attributes
            sess.setAttribute("personLoggedIn", user.getUsername());
            sess.setAttribute("user", user);
            sess.setAttribute("logintimestamp", new Date().getTime());
            sess.setAttribute("username", username);
            sess.setAttribute("csrfSessionToken", SiteSecurity.randomString(60));

            //direct user to welcome page
            RequestDispatcher rs = request.getRequestDispatcher("Welcome");
            rs.forward(request, response);
        } else {
            //responde to login page with error message
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    //check password function
    public boolean checkUser(String username, String pass) {

        //database connection drivers
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


        //use DAO object to verify user password
        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {

            user = dao.getUserStandard(username, pass);

            // if no user returned - return a wrong userpw msg and fail login
            if (user == null) {
                errorMessage = "Invalid Username or Password";
                return false;
            }

            // if user exist but status is inactive, return a user deleted message and fail login
            if (user.getStatus().equals("inactive")) {
                errorMessage = "User account has been deleted, please contact us to reactivate.";
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        //otherwise login success
        return true;

    }

    //get function is post function
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //we do not want get access to get as password will be in URL
        response.sendError(404);
    }

}
