package Controllers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
	public static Connection getConnection() throws ClassNotFoundException,SQLException {
		String username = "root";
		String password =  "";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab6003?characterEncoding=utf8&serverTimezone=UTC&useSSL=false&verifyServerCertificate=false", username, password);
		return connection;
	}
	
	public static void main(String[] args) {
	    try {
	        Connection conn = DatabaseConnector.getConnection();
	        if (conn != null) {
	            System.out.println("Database connected successfully!");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}