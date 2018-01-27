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
 * Time : 15:08
 **/
public class CheckPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CheckPasswordServlet enter sign up servlet");

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println("CheckPasswordServlet Connection attempt...");
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
        System.out.println("CheckPasswordServlet enter line 44:" + session.getId());
        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            Connection conn = mysqlDatabase.getConnection();
            System.out.println("CheckPasswordServlet Connection Successful");

            String password = req.getParameter("password");
            String cPassword = req.getParameter("cPassword");
            System.out.println("CheckPasswordServlet enter line 57: " + password + "," + cPassword);

            if (!cPassword.equals(password)) {
                resp.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                resp.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                resp.getWriter().write("two passwords are different!");
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
