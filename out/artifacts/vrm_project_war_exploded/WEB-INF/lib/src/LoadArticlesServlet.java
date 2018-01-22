import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;

import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by rher490 on 22/01/2018.
 */
public class LoadArticlesServlet extends HttpServlet {

    public void start() throws IOException, SQLException {
        System.out.println("enter servlet start()");
        try{
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
        }catch (IOException e){
            e.printStackTrace();
        }
        // Establishing connection to the database
        try (Connection conn = DriverManager.getConnection(dbProps.getProperty("url"), dbProps)) {
            System.out.println("Connection Successful");
            // Access the JOOQ library through this variable.
            DSLContext create = DSL.using(conn, SQLDialect.MYSQL);


        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            start();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }




}
