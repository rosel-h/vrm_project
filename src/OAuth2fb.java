//import com.google.gson.Gson;

import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;
import org.json.simple.JSONObject;
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
import java.sql.*;
import java.util.*;

//logic to communcate with FB

public class OAuth2fb extends HttpServlet {
    private static final long serialVersionUID = 1L;

//    public static String stateParam = "";

    // Facebook WebApp authentication
    private static final String clientID = "352195078594245";
    private static final String clientSecret = "f1c2f612640b399bd0ef017ed83b68c4";
    private static final String redirectURI = "http://localhost:8181/oauth2fb";
    String avatarFile = "";
    String username = "";

    //https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=http://localhost:8181/oauth2fb&scope=email&scope=email

    //default constructor
    public OAuth2fb() {
        super();
    }

    //setup get
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fbUserEmail = "";
        String fbFirstName = "";
        String fbLastName = "";

        try {
            //checks if request_id exists, this is used for games and should not show up for our requests
            String rid = request.getParameter("request_ids");
            // Get special code
            String code = request.getParameter("code");
            System.out.println(code);

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

                System.out.println("start reader");

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    while ((line = reader.readLine()) != null) {
                        outputString += line;
                    }
                }

                System.out.println(outputString);

                // extract access token from response
                String accessToken = outputString.substring(outputString.indexOf(":\"") + 2, outputString.indexOf("\","));
                System.out.println(accessToken);

                // request for user info
                url = new URL("https://graph.facebook.com/me?fields=email,first_name,last_name&access_token="
                        + accessToken);

                System.out.println(url);
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

                System.out.println("Facebook email is " + fbUserEmail);
                System.out.println("Facebook fname is " + fbFirstName);
                System.out.println("Facebook lname is " + fbLastName);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (checkFbUser(fbUserEmail, fbFirstName, fbLastName)) {
            System.out.println("Facebook User Exists in Database");
            HttpSession sess = request.getSession(true);
            Map<String, String[]> map = request.getParameterMap();
            Map<String, String> jsonMap = new HashMap<>();

            for (String key : map.keySet()) {
                String value = map.get(key)[0];
                jsonMap.put(key, value);
            }

            String jsonText = JSONValue.toJSONString(jsonMap);

            System.out.println("LoginServlet json text - " + jsonText);
//            HttpSession sess = request.getSession(true);
            String sessiont_id = sess.getId();
            System.out.println("LoginServlet: " + sessiont_id);
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

            sess.setAttribute("personLoggedIn", username);
            sess.setAttribute("avatarFile", avatarFile);
            System.out.println("Avatar File is " + avatarFile);
            RequestDispatcher rs = request.getRequestDispatcher("welcome.jsp");
            rs.forward(request, response);

        } else {
            request.setAttribute("successMessage", "Sign up successfully!");
            request.setAttribute("directMessage", "You will be directed to login page");
            request.setAttribute("directErrorMessage", "true");
            request.setAttribute("success", true);
            request.getRequestDispatcher("signupsuccess.jsp").forward(request, response);
            System.out.println("Success = " + true);
        }

    }

    public boolean checkFbUser(String email, String firstName, String lastName) {
        boolean loginStatus = false;
        User user;

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("LoginServlet Connection attempt...");

        try (UserDAO dao = new UserDAO(new MYSQLDatabase(getServletContext().getRealPath("mysql.properties")))) {
            System.out.println("LoginServlet connection successful");
            user = dao.getUserFacebook(email);

            if (user == null) {
                System.out.println("user is null");
                dao.addUserFB(firstName, lastName, email);
            } else {
                loginStatus = true;
                avatarFile = user.getAvatar_icon();
                System.out.println("avatar file is " + avatarFile);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("check user method returning " + loginStatus);
        return loginStatus;

    }
}