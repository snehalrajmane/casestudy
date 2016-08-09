package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
 
public class Database
{
                private static Database _instance = null;
                private Connection conn;
 
                private Database() throws InstantiationException, IllegalAccessException,ClassNotFoundException, SQLException
                {
                                this.conn = null;
                                String url = "jdbc:mysql://localhost:3306/";
                                String dbName = "voltage";
                                String driver = "com.mysql.jdbc.Driver";
                                String userName = "root";
                                String password = "root";
                                Class.forName(driver).newInstance();
                                this.conn = DriverManager.getConnection(url + dbName, userName, password);
                                System.out.println("Success");
                }
 
                public static Database getInstance() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException
                {
                                if (_instance == null)
                                {
                                                _instance = new Database();
                                }
                                return _instance;
                }
 
                public Connection getConn()
                {
                                return conn;
                }
               
                public void closeConnection() throws SQLException
                {
                                conn.close();
                }
 
}