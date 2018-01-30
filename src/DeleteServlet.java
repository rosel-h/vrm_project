import DAO_setup.BlogDAO;
import DAO_setup.MYSQLDatabase;
import DAO_setup.User;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jooq.tools.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/26
 * Time : 16:06
 **/
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        System.out.println("DeleteServlet enter line 26: session id = " + session.getId());

        MYSQLDatabase mysqlDatabase = (MYSQLDatabase) session.getAttribute("database");
        if (mysqlDatabase == null) {
            try {
                mysqlDatabase = new MYSQLDatabase(getServletContext().getRealPath("mysql.properties"));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        ServletContext servletContext = getServletContext();
        String sessionFilePath = servletContext.getRealPath("/Sessions");
        String sessionID = session.getId();
        String seesionFileName = sessionFilePath + "\\" + sessionID + ".json";
        JSONObject userJson;

        File sessionFile = new File(seesionFileName);
        System.out.println("DeleteServlet enter line 46:");
        if (sessionFile.exists()) {
            System.out.println("DeleteServlet enter line 48:");
            userJson = User.readJSONFile(seesionFileName);
            System.out.println(JSONObject.toJSONString(userJson));
            String username = String.valueOf(userJson.get("username"));
            if (true) {
                try (BlogDAO dao = new BlogDAO(mysqlDatabase)) {
                    System.out.println("EditProfileServlet enter line 69:");
                    User user = dao.getOneUser(username);

                    try (Connection conn = mysqlDatabase.getConnection()){
                        try (PreparedStatement stmt = conn.prepareStatement("UPDATE vrm_users " +
                                "SET status = ? WHERE username = ?;")) {

                            stmt.setString(1,"inactive");
                            stmt.setString(2, username);

                            stmt.executeUpdate();

                            req.getRequestDispatcher("index.jsp").forward(req, resp);

                        } catch (ServletException e) {
                            e.printStackTrace();
                        }
                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
