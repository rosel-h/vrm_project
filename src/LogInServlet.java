/**
 * Created by vwen239 on 23/01/2018.
 */

import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import DAO_setup.UserDAO;
import org.jooq.tools.json.JSONObject;
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

    //    String stateParam = ""; //StateParam is a secret random code generated that passes to FB to prevent cross-site-request forgery attacks.
    String avatarFile = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");

        HttpSession sess = request.getSession(true);

        if (checkUser(username, pass)) {

//            Map<String, String[]> map = request.getParameterMap();
            Map<String, String> jsonMap = new HashMap<>();
            jsonMap.put("username", username);
            jsonMap.put("pass", pass);

//            for (String key : map.keySet()) {
//                System.out.println("Writing JSON from LoginServlet");
//                String value = map.get(key)[0];
//                jsonMap.put(key, value);
//            }

            String jsonText = JSONValue.toJSONString(jsonMap);
            System.out.println("LoginServlet json text - " + jsonText);
            String sessiont_id = sess.getId();
            System.out.println("LoginServlet: " + sessiont_id);
            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("/Sessions");
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
            sess.setAttribute("avatarFile", avatarFile);
            RequestDispatcher rs = request.getRequestDispatcher("welcome.jsp");
            rs.forward(request, response);

        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    //check password function
    public boolean checkUser(String username, String pass) {
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
            user = dao.getUserStandard(username,pass);

            if (user==null){
                loginStatus = false;
            } else {
                loginStatus = true;
                avatarFile = user.getAvatar_icon();
                System.out.println("avatar file is " + avatarFile);
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
