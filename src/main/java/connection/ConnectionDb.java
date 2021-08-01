package connection;

import java.sql.*;
public class ConnectionDb {

	public static Connection connection;
		
		
		static {
		try {
		Class.forName("oracle.jdbc.OracleDriver");		
		connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
		System.out.println("Driver is connected");
		//Statement statement = connection .createStatement();
		//int result = statement.executeUpdate("INSERT INTO digitadmin values (1, 'S.Kumar','admin@test.com', 9876543218,'2021-07-21','2021-07-21',1,0,1, 'Test@15')");
		//System.out.println(result+" rows got inserted");
		
		}
				
		catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		}
	public static Connection getConnection() {
		return connection;
	}

}
