package DAO_setup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by rher490 on 24/01/2018.
 */
public interface Database {
    Connection getConnection() throws IOException, SQLException;
}
