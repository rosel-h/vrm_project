import DAO_setup.MYSQLDatabase;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Mengjie
 * Date : 2018/1/24
 * Time : 11:17
 **/
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("MainServlet enter main servlet");
        HttpSession sess = req.getSession(true);
        ServletContext s = getServletContext();
        String filepath = s.getRealPath("WEB-INF/mysql.properties");

        try {
            MYSQLDatabase mysqlDatabase = new MYSQLDatabase(filepath);
            sess.setAttribute("database", mysqlDatabase);
            System.out.println("MainServlet enter line 35: " + sess.getId());
            req.setAttribute("database", mysqlDatabase);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String logout = req.getParameter("logout_button");
        System.out.println("MainServlet enter line 46: " + logout);
        // user clicks on logout button
        if (logout != null && logout.equals("Logout")) {
            System.out.println("MainServlet enter line 48: ");

            String username = (String) sess.getAttribute("username");
            long logintimestamp = (long) sess.getAttribute("logintimestamp");

            writeLog(req, username, logintimestamp);

            sess.invalidate();
            System.out.println("MainServlet enter line 45: session is invalidated");
            resp.sendRedirect("Index");
        // user comes to main page from other page
        } else {

            ServletContext servletContext = getServletContext();
            String filePath = servletContext.getRealPath("WEB-INF/Sessions");

            String session_id = sess.getId();
            String fileName = filePath + "\\" + session_id + ".json";
            File sessionFile = new File(fileName);

            System.out.println("MainServlet enter line 40: " + session_id);

            if (sessionFile.exists()) {
                resp.sendRedirect("Welcome");
            } else {
                resp.sendRedirect("Index");
            }
        }
    }

    private void writeLog(HttpServletRequest req, String username, long logintimestamp) throws IOException {
        //print log to file
        Map<String, String> map = new HashMap<>();
        map.put("username",username);
        String ipAddress =  req.getRemoteAddr();
        map.put("ip", ipAddress);
        long online = new Date().getTime() - logintimestamp;
        map.put("online", String.valueOf(online));

        System.out.println("print this line");

        String logType = "Logout";
        LogWriter logWriter = new LogWriter(logType);
        logWriter.init(getServletContext().getRealPath("log"));
        logWriter.write(logType,map);
        //end of logging code
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
