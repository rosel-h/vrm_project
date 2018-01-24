import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Map;
import java.util.Properties;

/**
 * Created by mshe666 on 23/01/2018.
 */
public class SignUpServlet extends HttpServlet {
    public void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException,ServletException {

        System.out.println("enter sign up servlet");
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
            System.out.println("Connection Successful");
            // Access the JOOQ library through this variable.
            DSLContext create = DSL.using(conn, SQLDialect.MYSQL);

            PrintWriter out = resp.getWriter();

            Map<String, String[]> paraMap = req.getParameterMap();
            //username, password, cPassword, fname, lname, dob, country, description, avatar
            String username = paraMap.get("username")[0];
            try (PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM vrm_users WHERE username = ?;")) {
                stmt.setString(1, username);
                try (ResultSet r = stmt.executeQuery()) {
                    while (r.next()) {
                        req.setAttribute("usernameError","username already exists");
                        req.getRequestDispatcher("signup.jsp").forward(req,resp);
                        break;
//                        out.println("Username \"" + username + "\"" + " already exists!! Please choose another one.");
//                        break;
                    }
                }
            }

            String password = paraMap.get("password")[0];
            String cPassword = paraMap.get("cPassword")[0];
            String fname = paraMap.get("fname")[0];
            String lname = paraMap.get("lname")[0];
            String dob = paraMap.get("dob")[0];
            String country = paraMap.get("country")[0];
            String description = paraMap.get("description")[0];
            String avatar = paraMap.get("avatar")[0];

            System.out.println(username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar);

            if (!cPassword.equals(password)) {
                req.setAttribute("passwordError","two passwords are different");
                req.getRequestDispatcher("signup.jsp").forward(req,resp);
//                out.println("Two passwords are different!!");
            }else{
                try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO vrm_users VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?);")) {
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    stmt.setString(3, fname);
                    stmt.setString(4, lname);
                    stmt.setString(5, dob);
                    stmt.setString(6, country);
                    stmt.setString(7, description);
                    stmt.setString(8, avatar);
                    stmt.setString(9, "active");

                    stmt.executeUpdate();

//                    out.println("Create a new user successfully!!");
//                    out.println(username + "," + password + "," + cPassword + "," + fname + "," + lname + "," + dob + "," + country + "," + description + "," + avatar + "," + "active");

                    req.setAttribute("successMessage","Sign up successfully!");
                    req.setAttribute("directMessage","You will be directed to login page");
                    req.setAttribute("directErrorMessage","true");
                    req.getRequestDispatcher("signupsuccess.jsp").forward(req,resp);


                    req.setAttribute("signUpStatus", true);
                    req.getRequestDispatcher("index.jsp").forward(req,resp);


                } catch (ServletException e) {
                    e.printStackTrace();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            createUser(req,resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }


}
