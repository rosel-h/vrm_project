import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/27
 * Time : 14:34
 **/
public class CheckUsernameServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CheckUsernameServlet enter sign up servlet");

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("CheckUsernameServlet Connection attempt...");
        //plan A:
/*        Properties dbProps = new Properties();
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");
        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        } catch (IOException e) {
            e.printStackTrace();
        }*/
        //plan B:
        HttpSession session = req.getSession(true);
        System.out.println("CheckUsernameServlet enter line 44:" + session.getId());
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try(Connection conn = mysqlDatabase.getConnection()) {

            System.out.println("CheckUsernameServlet Connection Successful");

            String username = req.getParameter("username");
            System.out.println("CheckUsernameServlet enter line 57: " + username);

            try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vrm_users WHERE username = ?;")) {
                stmt.setString(1, username);
                try (ResultSet r = stmt.executeQuery()) {
                    while (r.next()) {
                        System.out.println("CheckUsernameServlet enter line 62: " + r);
                        resp.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                        resp.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                        resp.getWriter().write("username already exists");

                    }
                }
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
