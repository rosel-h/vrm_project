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
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;

//logic to communcate with FB

public class OAuth2fb extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Facebook WebApp authentication
    private static final String clientID = "352195078594245";
    private static final String clientSecret = "f1c2f612640b399bd0ef017ed83b68c4";
    private static final String redirectURI = "https://sporadic.nz/vrm_mshe666/oauth2fb";
    private static final String scope = "email";
    private String stateParam;
    User user;

    private String username = "";
    private String errorMessage = null;

    //used for authentication and account creation
    private String fbUserEmail = "";
    private String fbFirstName = "";
    private String fbLastName = "";

    @Override
    //listens to requests from out server
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//            String url = "https://www.facebook.com/dialog/oauth?client_id=" + clientID + "&redirect_uri=" + redirectURI + "&scope=" + scope;
//            response.sendRedirect(url);
        //        window.location.href='https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=https://sporadic.nz/vrm_mshe666/oauth2fb&scope=email'
    }

    //setup get request to listen for FBServer contact - this is used for the actual token creation
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        connectFB(request, response);
        if (checkFbUser(fbUserEmail, fbFirstName, fbLastName)) {

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
                rs.forward(request, response);
                return;
            }

            HttpSession sess = request.getSession(true);

            Map<String, String> jsonMap = new HashMap<>();
            jsonMap.put("username", user.getUsername());

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

            //print log to file
            Map<String, String> map = new HashMap<>();
            map.put("username",user.getUsername());

            String ipAddress =  request.getRemoteAddr();
            map.put("ip", ipAddress);

            String logType = "Login";
            LogWriter logWriter = new LogWriter(logType);
            logWriter.init(getServletContext().getRealPath("log"));
            logWriter.write(logType,map);
            //end of logging code

            sess.setAttribute("csrfSessionToken", SiteSecurity.randomString(60));
            sess.setAttribute("logintimestamp", new Date().getTime());
            sess.setAttribute("username",username);
            sess.setAttribute("personLoggedIn", user.getUsername());
            sess.setAttribute("user", user);
            String url = "Welcome";
            response.sendRedirect(url);

        } else {
            request.setAttribute("successMessage", "Sign up successfully!");
            request.setAttribute("directMessage", "You will be directed to login page");
            request.setAttribute("directErrorMessage", "true");
            request.setAttribute("success", true);
            request.getRequestDispatcher("signupsuccess.jsp").forward(request, response);
        }
//        }
    }

    private void connectFB(HttpServletRequest request, HttpServletResponse response) {
        try {
            //checks if request_id exists, this is used for games and should not show up for our requests
            String rid = request.getParameter("request_ids");
            // Get special code
            String code = request.getParameter("code");

            if (code != null) {
                // Format parameters
                URL url = new URL(
                        "https://graph.facebook.com/oauth/access_token?client_id="
                                + clientID + "&redirect_uri=" + redirectURI
                                + "&client_secret=" + clientSecret
                                + "&code=" + code);

                // request for Access Token
                HttpURLConnection conn = (HttpURLConnection) url.openConnection(); //opens connection and sets get method
                conn.setRequestMethod("GET");
                String line, outputString = "";

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    while ((line = reader.readLine()) != null) {
                        outputString += line;
                    }
                }

                // extract access token from response
                String accessToken = outputString.substring(outputString.indexOf(":\"") + 2, outputString.indexOf("\","));

                // request for user info
                url = new URL("https://graph.facebook.com/me?fields=email,first_name,last_name&access_token="
                        + accessToken);

                URLConnection conn1 = url.openConnection();
                outputString = "";

                try (Scanner reader = new Scanner(new InputStreamReader(conn1.getInputStream()))) {
                    while (reader.hasNextLine()) {
                        line = reader.nextLine();
                        outputString += line;
                    }
                }

                //get facebook email
                fbUserEmail = outputString.substring(outputString.indexOf("{\"email\":") + 10, outputString.indexOf("\",\"first_name\""));
                fbUserEmail = fbUserEmail.replace("\\u0040", "@");

                //get facebook first name
                fbFirstName = outputString.substring(outputString.indexOf("first_name\":\"") + 13, outputString.indexOf("\",\"last_name"));

                //get facebook last name
                fbLastName = outputString.substring(outputString.indexOf("\"last_name\":\"") + 13, outputString.indexOf("\",\"id\""));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private boolean checkFbUser(String email, String firstName, String lastName) {

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("WEB-INF/mysql.properties")))) {

            user = dao.getUserFacebook(email);

            if (user == null) {
                dao.addUserFB(firstName, lastName, email);

                //print log to file
                Map<String, String> map = new HashMap<>();
                map.put("username",firstName + "_" + lastName);
                map.put("fname",firstName);
                map.put("lname",lastName);

                String dob = "1900-11-11";
                String country = "New Zealand";
                String description = "New facebook user";
                String avatar = "avatar_01.png";
                String status = "facebook";

                map.put("dob",dob);
                map.put("country",country);
                map.put("description",description);
                map.put("avatar",avatar);
                map.put("status",status);
                map.put("email",email);

                String logType = "SignUp";
                LogWriter logWriter = new LogWriter(logType);
                logWriter.init(getServletContext().getRealPath("log"));
                logWriter.write(logType,map);
                //end of logging code
                return false;
            }

            if (user.getStatus().equals("inactive")) {
                errorMessage = "User account has been deleted, please contact us to reactivate.";
                return true;
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;

    }
}