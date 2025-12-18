package com.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

	private static final String URL ="jdbc:mysql://localhost:3306/sugar_factory_portal";
	private static final String USER = "root";
	private static final String PASS = "Akshay@2001";
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 System.out.println("MySQL Driver Loaded Successfully!");
		} catch (ClassNotFoundException e) {
				System.out.println("Class not load........");
		}
	}
	
	public static Connection getConnection() {
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(URL,USER,PASS);
			 System.out.println("Connection establish Successfully!");
		}catch (Exception e){
			System.out.println("Connection not establish");
		}
		return con;
	}
	
}
