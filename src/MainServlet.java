import DAO_setup.MYSQLDatabase;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/24
 * Time : 11:17
 **/
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



        HttpSession sess = req.getSession(true);

        ServletContext s = getServletContext();
        String filepath = s.getRealPath("mysql.properties");
        try {
            MYSQLDatabase mysqlDatabase = new MYSQLDatabase(filepath);
            sess.setAttribute("database",mysqlDatabase);
            System.out.println("enter line 37: " + sess.getId());
            req.setAttribute("database",mysqlDatabase);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String logout = req.getParameter("logout_button");
        if (logout != null && logout.equals("Logout")) {
            sess.invalidate();
            System.out.println("enter line 32: session is invalidated");
            req.getRequestDispatcher("index.jsp").forward(req,resp);

        }else {

            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("/Sessions");

            String sessiont_id = sess.getId();
            String fileName = filePath + "\\" + sessiont_id + ".json";
            File sessionFile = new File(fileName);

            System.out.println("MainServlet enter line 40: " + sessiont_id);
            System.out.println("MainServlet enter line 41: " + sessionFile);

            if (sessionFile.exists()) {
                req.getRequestDispatcher("welcome.jsp").forward(req,resp);
            }else {
                req.getRequestDispatcher("index.jsp").forward(req,resp);
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
