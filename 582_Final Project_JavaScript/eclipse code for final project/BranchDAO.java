package finalproject.bookstore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BranchDAO {
	
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
	
	public void create(Branch branch){
		
		String sql = "insert into branchs(saleprice, stock, name, version) values (? ,?, ?, ?)";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, branch.getSaleprice());
			statement.setInt(2, branch.getStock());
			statement.setString(3, branch.getName());
			statement.setInt(4, 0);			
			statement.execute();
	        connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
									try {
										connection.rollback();
									} catch (SQLException e1) {
										e1.printStackTrace();
									}
		}finally { 		
			closeConnection(connection);
		}
	}
	
	
	
	public List<Branch> selectAll(){
		List<Branch> branchs = new ArrayList<Branch>();
		
		String sql = "select * from branchs";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				double saleprice = results.getDouble("saleprice");
				int stock = results.getInt("stock");
				String name = results.getString("name");
				int version = results.getInt("version");
				//int stockquantity = results.getInt("stockquantity");
				Branch branch = new Branch(saleprice, stock, name, version); 
				branchs.add(branch);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
		
		return branchs;
	}
	
	
	
	public void remove(String name, int version){
		String sql = "delete from branchs where name=? and version=?";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,  name);
			statement.setInt(2, version);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
	}
	
	
	
	public Branch selectOne(String name, int version) {
		Branch app = null;
		
		String sql = "select * from branchs where name=? and version=?";
		Connection connection = getConnection();
		
		try {			connection.setAutoCommit(false);
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,  name);
			statement.setInt(2, version);
			ResultSet results = statement.executeQuery();
			if(results.next()){
				double saleprice = results.getDouble("saleprice");
				int stock = results.getInt("stock");
				name = results.getString("name");
				version = results.getInt("version");
				app = new Branch(saleprice, stock, name, version);
			}else{
				System.out.println("AAAAAAbranch test REACH");
				return new Branch(0.0, 0, "Please refresh the page!!", 0);
			};
	        connection.commit();
			System.out.println("branch test REACH");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
		return app;
	}
	
	
	
	public void update(String name, int version, Branch app) {
		
		String sql = "update branchs set saleprice=?, stock=?, name=?, version=? where name=? and version =?";
		Connection connection = getConnection();
		int newVersion = version+1;
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, app.getSaleprice());
			statement.setInt(2, app.getStock());
			statement.setString(3, app.getName());
			statement.setInt(4, newVersion);
			statement.setString(5, name);
			statement.setInt(6, version);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}		
	}
	
	
	
	
	public void  listInsert(List<Branch> allInput){
		
		String sql = "insert into branchs(saleprice, stock, name, version) values (? ,?, ?, ?)";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
	        for (Branch branch : allInput) {
	        	statement.setDouble(1, branch.getSaleprice());
				statement.setInt(2, branch.getStock());
				statement.setString(3, branch.getName());
				statement.setInt(4, 0);
				statement.execute();
				}
	        connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
								try {
									connection.rollback();
								} catch (SQLException e1) {
									e1.printStackTrace();
								}
		}finally { 		
			closeConnection(connection);
		}
		
	}
	
	public String listOrder(List<Order> allInput){
		String sql = "update branchs set stock=?, version=? where name=? and version =?";
		Connection connection = getConnection();
		int leftMarker = 0;
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
			int count=0;
	        for (Order order : allInput) {
	        	int leftNbr = order.getStock()-order.getOrderNbr();

	        	if(leftNbr < 0){statement.setString(1, "leftNbr");}
	        	else{
				statement.setInt(1, leftNbr);}
				statement.setInt(2, order.getVersion()+1);
				statement.setInt(4, order.getVersion());
				statement.setString(3, order.getName());
				//statement.executeUpdate();
				 count = statement.executeUpdate() + count;
					
	        	}	
	        
			System.out.println(count);
				if(count ==1){
				try {
					connection.rollback();
				} catch (SQLException e2) {
					e2.printStackTrace();
				} return "page expired and order failed please refreash and try again";
				}

	        connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
								try {
									connection.rollback();
								} catch (SQLException e1) {
									e1.printStackTrace();
								}
								return "order failed  please try again";
		}finally { 		

			closeConnection(connection);
		}
		return "Please click the Order button to make an order";
	}
	
	

	
}