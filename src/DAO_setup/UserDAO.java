package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by Mengjie
 * Date : 2018/1/31
 * Time : 11:09
 **/
public class UserDAO  implements AutoCloseable  {
    private final Connection conn;

    private final Database db;

    public UserDAO(Database db) throws IOException, SQLException {
        this.db = db;
        this.conn = db.getConnection();
    }


    @Override
    public void close() throws Exception {
        this.conn.close();
    }
}
