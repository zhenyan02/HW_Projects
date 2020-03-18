package edu.neu.cs5200.s3.onlineide.applications;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApplicationsDAO {
	
	public Connection getConnection(){
		String connectionUrl = "jdbc:mysql://localhost:3306/onlineide"; 
		Connection connection = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionUrl, "root", "zhenyanl");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void create(Application application){
		
		String sql = "insert into applications(name, price) values (?, ?)";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, application.getName());
			statement.setDouble(2, application.getPrice());
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
	}

	public List<Application> selectAll(){
		List<Application> applications = new ArrayList<Application>();
		
		String sql = "select * from applications";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				int id = results.getInt("id");
				String name = results.getString("name");
				double price = results.getDouble("price");
				Application application = new Application(id, name, price); 
				applications.add(application);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
		
		return applications;
	}
	
	public void remove(int id){
		String sql = "delete from applications where id=?";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,  id);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
	}
		
	
	public Application selectOne(int id) {
		Application app = null;
		
		String sql = "select * from applications where id=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,  id);
			ResultSet results = statement.executeQuery();
			if(results.next()){
				id = results.getInt("id");
				String name = results.getString("name");
				double price = results.getDouble("price");
				app = new Application(id,name,price);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
		return app;
	}
	
	public void update(int id, Application app) {
		
		
		String sql = "update applications set name=?, price=? where id=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, app.getName());
			statement.setDouble(2, app.getPrice());
			statement.setInt(3, id);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}		
	}
	
	
	public static void main(String[] args) {
		
		ApplicationsDAO dao = new ApplicationsDAO();
		
		Application app1 = new Application("xxxxx", 8.99);
		//dao.create(app1);
		
		/*
		Connection connection = dao.getConnection();
		System.out.println(connection);
		dao.closeConnection(connection);
		*/
		
	}

}
