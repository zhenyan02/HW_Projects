<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="finalproject.bookstore.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>

<body background="back13.jpg">
	<h1>Publisher</h1>

<%
	SellerDAO dao = new SellerDAO();
    BranchDAO daoo = new BranchDAO();
	
	//controller{
	String action = request.getParameter("action");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String id = request.getParameter("id");
	String action2 = request.getParameter("action2");
    String nameBuy = request.getParameter("nameBuy");
    String priceBuy = request.getParameter("priceBuy");
    String quantityBuy = request.getParameter("quantityBuy");
    String id2 = request.getParameter("id2");
    Seller app = new Seller();
    Branch apB = new Branch();
    
    /*
    			statement.setDouble(1, buyer.getSaleprice());
			statement.setInt(2, buyer.getQuantity());
			statement.setString(3, buyer.getName());*/

	//saleprice, quantity, name
    //Seller aXX2 = new Seller();
    //Seller aXX1 = new Seller();
    
    if("createSeller".equals(action)){
    	int idInt = Integer.parseInt(id);
    	double priceD = Double.parseDouble(price);
        app = new Seller(idInt, name, priceD); 
    	dao.create(app);
    }else if("createBuyer".equals(action)){
    	int quantityBuyInt = Integer.parseInt(quantityBuy);
    	double priceBuyD = Double.parseDouble(priceBuy);
        apB = new Branch(priceBuyD, quantityBuyInt, nameBuy,0); 
    	daoo.create(apB);
    }else if("remove".equals(action)){
    	//String nameString = String.parseString(id);
    	dao.remove(name);
    }else if("select".equals(action)){
    	//int idInt = Integer.parseInt(id);
    	app = dao.selectOne(name);
    }else if("update".equals(action)){
    	int idInt = Integer.parseInt(id);
    	double priceD = Double.parseDouble(price);
    	app = new Seller(idInt, name, priceD); 
    	dao.update(name, app);
    }else if("create2".equals(action)){
    	int idInt = Integer.parseInt(id);
    	double priceD = Double.parseDouble(price);
        app = new Seller(idInt, name, priceD); 
    	int quantityBuyInt = Integer.parseInt(quantityBuy);
    	double priceBuyD = Double.parseDouble(priceBuy);
        apB = new Branch(priceBuyD, quantityBuyInt, nameBuy,0 ); 
		dao.buyersellerInsert(app,apB);
    }else if("delete2".equals(action)){
    	//List<Seller> multiDelete = new ArrayList<Seller>();
    	//multiDelete.add(request.getParameterValues("ckbdelete"));
	    //dao.listDelete(multiDelete);
			System.out.println(request.getParameterValues("ckbdelete"));

    }
    	
    	
	//Seller app1 = new Seller("xxxyxx", 8.99);
	//dao.create(app1);
	
	
	List<Seller> sellers = dao.selectAll();
	 //}
%> 
<form action="PublisherWeb.jsp">
	<table class= "table">
	
			<tr>	
			<td>Book ID for publisher:</td>
			<td>Book name for publisher:</td>
			<td>Price for publisher:</td>
			</tr>
			
			<tr>	
			<td><input name="id" class="form-control" value="<%= app.getId()%>"/></td>
			<td><input name="name" class="form-control" value="<%= app.getName()%>"/></td>
			<td><input name="price" class="form-control" value="<%= app.getPrice()%>"/></td>
			<td>
				<button class="btn btn-success" name="action" value="createSeller">
					Add Publisher
				</button>
				<button class="btn btn-primary" name="action" value="update">
					Update
				</button>
			</td>
		</tr>
			<tr>	
			<td>Price for branch store&customer:</td>
			<td>Stock for branch store&customer:</td>
			<td>Name for branch store&customer:</td>
			</tr>
		<tr>			
			<td><input name="priceBuy" class="form-control" value="<%= apB.getSaleprice()%>"/></td>
			<td><input name="quantityBuy" class="form-control" value="<%= apB.getStock()%>"/></td>
			<td><input name="nameBuy" class="form-control" value="<%= apB.getName()%>"/></td>
			<td>
				<button class="btn btn-success" name="action" value="createBuyer">
					Add Branch Store
				</button>
				<button class="btn btn-success" name="action" value="create2">
					Add Publisher and Branch Store
				</button>
			</td>
		</tr>
		
		
			<tr><td></td>	
			<td>id for publisher:</td>
			<td>name for publisher:</td>
			<td>price for publisher:</td>
			</tr>
			
<% for(Seller ap:sellers){	
	
	
%>  <tr>
		<td><input name="ckbdelete" type="checkbox" value="<%= ap.getName()%>"/></td>
		<td><%= ap.getId() %></td>
		<td><%= ap.getName() %></td>
		<td><%= ap.getPrice() %></td>
		<td>
			<a class="btn btn-danger" href="PublisherWeb.jsp?action=remove&name=<%= ap.getName() %>">
				Delete
			</a>
			<a class="btn btn-warning" href="PublisherWeb.jsp?action=select&name=<%= ap.getName() %>">
				Select
			</a>
		</td>
	</tr>
<% 
	}
%>	
   </table>
</form>
				<button class="btn btn-success" name="action" value="delete2">
					Delete All Selected
				</button>
</body>
</html>