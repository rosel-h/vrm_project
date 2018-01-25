//import com.google.gson.Gson;

import DAO_setup.MYSQLDatabase;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

//logic to communcate with FB

public class OAuth2fb extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Facebook WebApp authentication
    private static final String clientID = "352195078594245";
    private static final String clientSecret = "f1c2f612640b399bd0ef017ed83b68c4";
    private static final String redirectURI = "http://localhost:8181/oauth2fb";

    //https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=http://localhost:8181/oauth2fb&scope=email&scope=email

    //note: need to implement state-param setting in URL to prevent cross-site-request forgery attach.

    //default constructor
    public OAuth2fb() {
        super();
    }

    //setup get
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FbResponse fbUser = new FbResponse();
        try {
            //checks if request_id exists, this is used for games and not relevant
            String rid = request.getParameter("request_ids");
            if (rid != null) {
                response.sendRedirect("https://www.facebook.com/dialog/oauth?client_id="
                        + clientID + "&redirect_uri=" + redirectURI);
            } else {
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

                    System.out.println(outputString);

                    //get facebook email
                    String fbUserEmail = outputString.substring(outputString.indexOf("{\"email\":") + 10, outputString.indexOf("\",\"first_name\""));
                    fbUserEmail = fbUserEmail.replace("\\u0040", "@");

                    //get facebook first name
                    String fbFirstName = outputString.substring(outputString.indexOf("first_name\":\"") + 13, outputString.indexOf("\",\"last_name"));
                    //get facebook last name

                    String fbLastName = outputString.substring(outputString.indexOf("\"last_name\":\"") + 13, outputString.indexOf("\",\"id\""));

                    //put all into FBResponse object
                    fbUser.setEmail(fbUserEmail);
                    fbUser.setFirst_name(fbFirstName);
                    fbUser.setLast_name(fbLastName);
                    System.out.println(fbUser.getEmail());
                    System.out.println(fbUser.getFirst_name());
                    System.out.println(fbUser.getLast_name());
                }

            }

        } catch (Exception e) {
            e.printStackTrace();

        }

        if (checkFbUser(fbUser.getEmail())) {
            System.out.println("good");
            RequestDispatcher rs = request.getRequestDispatcher("welcome.jsp");
            rs.forward(request, response);

        } else {
            System.out.println("false");
            RequestDispatcher rs = request.getRequestDispatcher("signup.jsp");
            rs.forward(request, response);
        }
    }

    public boolean checkFbUser(String email) {

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
        try (Connection conn = DriverManager.getConnection(dbProps.getProperty("url"), dbProps)) {
            System.out.println("connection successful");
            PreparedStatement ps = conn.prepareStatement
                    ("select * from vrm_users where binary email_address=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery(); // will be an empty set if login in correct
            loginStatus = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return loginStatus;
    }

}