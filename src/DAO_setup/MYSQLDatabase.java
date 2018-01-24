package DAO_setup;


import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by rher490 on 24/01/2018.
 */
public class MYSQLDatabase implements Database {
    Connection conn;

    public MYSQLDatabase(String filepath) throws IOException, SQLException{
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Properties dbProps = new Properties();
//        ServletContext s = getServletContext();
//        String filepath = s.getRealPath("mysql.properties");
        try (FileInputStream fis = new FileInputStream(filepath)) {
            dbProps.load(fis);
        }

        conn = DriverManager.getConnection(dbProps.getProperty("url"), dbProps);
    }

    @Override
    public Connection getConnection() throws IOException, SQLException {
        /*        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Properties dbProps = new Properties();
//        ServletContext s = getServletContext();
//        String filepath = s.getRealPath("mysql.properties");
        try (FileInputStream fis = new FileInputStream("H:\\vrm_project\\web\\mysql.properties")) {
            dbProps.load(fis);
        }

        conn = DriverManager.getConnection(dbProps.getProperty("url"), dbProps);
        return conn*/



        return this.conn;
    }
}
