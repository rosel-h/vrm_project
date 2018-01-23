package blah;

/**
 * Created by vwen239 on 23/01/2018.
 */

import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.StringJoiner;

public class LogInServlet extends HttpServlet  {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html"); // change to text/jsp at a later stage
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String pass = request.getParameter("pass");

        if(Validate.checkUser(username, pass))
        {
            RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
            rs.forward(request, response);
        }
        else
        {
            out.println("Username or Password incorrect");
            RequestDispatcher rs = request.getRequestDispatcher("index.html");
            rs.include(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
