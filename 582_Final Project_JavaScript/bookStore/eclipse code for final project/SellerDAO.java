package finalproject.bookstore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SellerDAO {
	
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
	
	public void create(Seller seller){
		
		String sql = "insert into sellers(id, name, price) values (? ,?, ?)";
		
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, seller.getId());
			statement.setString(2, seller.getName());
			statement.setDouble(3, seller.getPrice());
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
	}

	
	
	public List<Seller> selectAll(){
		List<Seller> sellers = new ArrayList<Seller>();
		
		String sql = "select * from sellers";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while(results.next()){
				int id = results.getInt("id");
				String name = results.getString("name");
				double price = results.getDouble("price");
				//int stockquantity = results.getInt("stockquantity");
				Seller seller = new Seller(id, name, price); 
				sellers.add(seller);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally { 		
			closeConnection(connection);
		}
		
		return sellers;
	}
	
	public void remove(String name){
		String sql = "delete from sellers where name=?";
		
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
		
	
	public Seller selectOne(String name) {
		Seller app = null;
		
		String sql = "select * from sellers where name=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1,  name);
			ResultSet results = statement.executeQuery();
			if(results.next()){
				int id = results.getInt("id");
				name = results.getString("name");
				double price = results.getDouble("price");
				app = new Seller(id,name,price);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
		return app;
	}
	
	public void update(String name, Seller app) {
		
		
		String sql = "update sellers set id=?, name=?, price=? where name=?";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1, app.getId());
			statement.setString(2, app.getName());
			statement.setDouble(3, app.getPrice());
			statement.setString(4, name);
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}		
	}
	
	
	/////////////////////////////////////////////////
	public void  listInsert(List<Seller> allInput){
		
		
		String sql = "insert into sellers(id, name, price) values (? ,?, ?)";
		Connection connection = getConnection();
		
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
	        for (Seller seller : allInput) {
				statement.setInt(1, seller.getId());
				statement.setString(2, seller.getName());
				statement.setDouble(3, seller.getPrice());
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
	public void  listDelete(List<Seller> allInput){


		String sql = "delete from sellers where name=?";
		Connection connection = getConnection();

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			//ResultSet results = statement.executeQuery();
			connection.setAutoCommit(false);
			for (Seller seller : allInput) {				
				statement.setString(1, seller.getName());				
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
	public void  buyersellerInsert(Seller seller, Branch branch){
		
		
		String sqlS = "insert into sellers(id, name, price) values (? ,?, ?)";
		String sqlB = "insert into branchs(saleprice, stock, name, version) values (? ,?, ?,?)";
		Connection connection = getConnection();
		
		try {connection.setAutoCommit(false);
			PreparedStatement statementS = connection.prepareStatement(sqlS);
			statementS.setInt(1, seller.getId());
			statementS.setString(2, seller.getName());
			statementS.setDouble(3, seller.getPrice());
			statementS.execute();
			PreparedStatement statementB = connection.prepareStatement(sqlB);
			statementB.setDouble(1, branch.getSaleprice());
			statementB.setInt(2, branch.getStock());
			statementB.setString(3, branch.getName());
			statementB.setInt(4, branch.getVersion());
			statementB.execute();
			System.out.println("Reach here");
			//ResultSet results = statement.executeQuery();
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
	////////////////////////////////////////////////////
	
	
	public static void main(String[] args) {
		/*
		SellerDAO dao = new SellerDAO();

		
		Seller app1 = new Seller(1,"The Lord of Ring", 28.99);
		Seller app2 = new Seller(2,"The Kite Runner", 55.99);
		Seller app3 = new Seller(3,"The Da Vinci Code ", 36.59);
		Seller app4 = new Seller(4,"The Hunger Games", 56.89);
		Seller app5 = new Seller(5,"Life of Pi", 43.89);
		Seller app6 = new Seller(6,"Animal Farm", 67.99);
		Seller app7 = new Seller(7,"The Help", 19.99);
		Seller app8 = new Seller(8,"Gone Girl", 17.99);
		Seller app9 = new Seller(9,"Harry Potter", 39.99);
		Seller app10 = new Seller(10,"War and Peace", 47.99);
		dao.create(app1);
		dao.create(app2);
		dao.create(app3);
		dao.create(app4);
		dao.create(app5);
		dao.create(app6);
		dao.create(app7);
		dao.create(app8);
		dao.create(app9);
		dao.create(app10);
		*/
		/*
		BranchDAO daoo = new BranchDAO();
		
		
		Branch app11 = new Branch(38.99, 1,"The Lord of Ring",0);
		Branch app22 = new Branch(65.99,2,"The Kite Runner",0);
		Branch app33 = new Branch(46.59,1,"The Da Vinci Code ",0 );
		Branch app44 = new Branch(66.89, 3,"The Hunger Games" ,0);
		Branch app55 = new Branch(53.89, 1,"Life of Pi",0);
		Branch app66 = new Branch(77.99, 3,"Animal Farm",0);
		Branch app77 = new Branch(29.99,1,"The Help",0);
		Branch app88 = new Branch(27.99, 3,"Gone Girl",0);
		Branch app99 = new Branch(49.99, 6, "Harry Potter",0);
		//Branch app10 = new Branch(57.99, 10,"War and Peace");
		daoo.create(app11);
		daoo.create(app22);
		daoo.create(app33);
		daoo.create(app44);
		daoo.create(app55);
		daoo.create(app66);
		daoo.create(app77);
		daoo.create(app88);
		daoo.create(app99);
		*/
		
		
	}

}



///////////////////////TEST CODE////////////////////////////////

//Seller aXX2 = new Seller(11,"AYA", 28.99);
//Buyer aXX3 = new Buyer(38.99, 1,"ATA");
//dao.create(aXX2);
//daoo.create(aXX3);
//dao.buyersellerInsert(aXX2,aXX3);
//Seller aXX1 = new Seller(11,"AYA", 28.99);
//List<Seller> multiDelete = new ArrayList<Seller>();
//multiDelete.add(aXX2);
//multiDelete.add(aXX1);
//dao.listDelete(multiDelete);

//Seller apS1 = new Seller(11,"AXA", 28.99);
//dao.create(apS1);
//Seller apS2 = new Seller(12,"AYA", 66.66);
//dao.create(apS2);
//Seller apS3 = new Seller(13,"ZZZ", 28.99);
//dao.create(apS2);
//List<Seller> twoInputs = new ArrayList<Seller>();
//twoInputs.add(apS1);
//twoInputs.add(apS2);
//twoInputs.add(apS3);
//dao.listInsert(twoInputs);

//dao.listDelete(twoInputs);

//Buyer apB1 = new Buyer(38.99, 1,"XXX");
//daoo.create(apB1);
/*
Connection connection = dao.getConnection();
System.out.println(connection);
dao.closeConnection(connection);
*/
