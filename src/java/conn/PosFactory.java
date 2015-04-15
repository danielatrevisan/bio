
package conn;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author danielatrevisan
 */
public class PosFactory {

    static final String DRIVER = "org.postgresql.Driver";
    static final String URL = "jdbc:postgresql://localhost:5432/bio";
    static final String USERNAME = "postgres";
    static final String PASSWORD = "admin";

    public static Connection getConnection() throws Exception {
        Class.forName(DRIVER);
        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        return conn;
    }
}
