package finalproject.bookstore;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
 
public class BuyerDAO {
	
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
	
	public void create(Buyer buyer){
		
		String sql = "insert into buyers(saleprice, quantity, name) values (? ,?, ?)";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, buyer.getSaleprice());
			statement.setInt(2, buyer.getQuantity());
			statement.setString(3, buyer.getName());
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
	}

	public List<Buyer> selectAll(){
		List<Buyer> buyers = new ArrayList<Buyer>();
		
		String sql = "select * from buyers";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				double saleprice = results.getDouble("saleprice");
				int quantity = results.getInt("quantity");
				String name = results.getString("name");
				//int stockquantity = results.getInt("stockquantity");
				Buyer buyer = new Buyer(saleprice, quantity, name); 
				buyers.add(buyer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
		
		return buyers;
	}
	
	public void remove(String name){
		String sql = "delete from buyers where name=?";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,  name);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
	}
		
	
	public Buyer selectOne(String name) {
		Buyer app = null;
		
		String sql = "select * from buyers where name=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,  name);
			ResultSet results = statement.executeQuery();
			if(results.next()){
				double saleprice = results.getDouble("saleprice");
				int quantity = results.getInt("quantity");
				name = results.getString("name");
				
				app = new Buyer(saleprice, quantity, name);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
		return app;
	}
	
	public void update(String name, Buyer app) {
		
		
		String sql = "update buyers set saleprice=?, quantity=?, name=? where name=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setDouble(1, app.getSaleprice());
			statement.setInt(2, app.getQuantity());
			statement.setString(3, app.getName());
			statement.setString(4, name);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}		
	}






	/////////////////////////////////////////////////
	public void  listInsert(List<Buyer> allInput){
		
		
		String sql = "insert into buyers(salespric,quantity, name) values (? ,?, ?)";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
	        for (Buyer buyer : allInput) {
	        	statement.setDouble(1, buyer.getSaleprice());
				statement.setInt(2, buyer.getQuantity());
				statement.setString(3, buyer.getName());
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
	///////////////////////////////////////////////////
	
	/////////////////////////////////////////////////
	public void  listDelete(List<Buyer> allInput){

		String sql = "delete from buyers where name=?";
		Connection connection = getConnection();

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
			for (Buyer buyer : allInput) {
				statement.setString(1, buyer.getName());
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
		///////////////////////////////////////////////////
	
	
}
/*
 			<tr>

			<td> <select name = "options1">
				<% for(Branch apb:branchs){%>  
						<option value="$<%=apb%>">
						<%= apb.getName() %> -- Price:$<%= apb.getStock() %> -- only <%= apb.getStock() %> left
						</option>
				<% }%>		
			</select> 	</td>		
			<td><input name="orderNbr2" class="form-control" value="<%= ap2.getOrderNbr()%>"/></td>
			</tr>
 */