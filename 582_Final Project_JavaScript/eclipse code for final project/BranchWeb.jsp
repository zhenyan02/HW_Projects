<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="finalproject.bookstore.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>

<body background="back12.jpg">
	<h1>Branch Store</h1>

<%
	BranchDAO dao = new BranchDAO();
	
	//controller{
	String action = request.getParameter("action");
    String name = request.getParameter("name");
    String saleprice = request.getParameter("saleprice");
    String stock = request.getParameter("stock");
    String version = request.getParameter("version");
    String action2 = request.getParameter("action2");
    String name2 = request.getParameter("name2");
    String saleprice2 = request.getParameter("saleprice2");
    String stock2 = request.getParameter("stock2");
    String version2 = request.getParameter("version2");
    Branch app = new Branch();
    Branch apB2 = new Branch();
    
    if("create".equals(action)){
    	int stockInt = Integer.parseInt(stock);
    	double salepriceD = Double.parseDouble(saleprice);
    	int versionInt = Integer.parseInt(version);
    	app = new Branch(salepriceD, stockInt, name, versionInt);
    	dao.create(app);
    }else if("remove".equals(action)){
    	int versionInt = Integer.parseInt(version);
    	dao.remove(name,versionInt);
    }else if("select".equals(action)){
    	int versionInt = Integer.parseInt(version);
    	app = dao.selectOne(name,versionInt);
    }else if("update".equals(action)){
    	int stockInt = Integer.parseInt(stock);
    	double salepriceD = Double.parseDouble(saleprice);
    	int versionInt = Integer.parseInt(version);
        app = new Branch(salepriceD, stockInt,name,versionInt); 
    	dao.update(name,versionInt, app);
    }else if("create2".equals(action)){
    	int stockInt = Integer.parseInt(stock);
    	double salepriceD = Double.parseDouble(saleprice);
    	int versionInt = Integer.parseInt(version);
        app = new Branch(salepriceD, stockInt,name,versionInt); 
    	int stockInt2 = Integer.parseInt(stock2);
    	double salepriceD2 = Double.parseDouble(saleprice2);
    	int versionInt2 = Integer.parseInt(version2);
        apB2 = new Branch(salepriceD2, stockInt2,name2,versionInt2); 
		List<Branch> twoInputs = new ArrayList<Branch>();
		twoInputs.add(app);
		twoInputs.add(apB2);
		dao.listInsert(twoInputs);
    }
    	
    	
    	
	//Seller app1 = new Seller("xxxyxx", 8.99);
	//dao.create(app1);
	
	
	List<Branch> branchs = dao.selectAll();
	 //}
%> 
<form action="BranchWeb.jsp">
	<table class= "table">
			<tr>	
			<td>stock for bookstore:</td>
			<td>name for bookstore:</td>
			<td>price for bookstore:</td>
			</tr>
		<tr>			
			<td><input name="stock" class="form-control" value="<%= app.getStock()%>"/></td>
			<td><input name="name" class="form-control" value="<%= app.getName()%>"/></td>
			<td><input name="saleprice" class="form-control" value="<%= app.getSaleprice()%>"/></td>
			<td><input name="version" type='hidden' class="form-control" value="<%= app.getVersion()%>"/></td>			
			<td>
				<button class="btn btn-success" name="action" value="create">
					Add
				</button>
				<button class="btn btn-primary" name="action" value="update">
					Update Stock or Price
				</button>
			</td>
		</tr>
		
<tr>	
		<tr>			
			<td><input name="stock2" class="form-control" value="<%= apB2.getStock()%>"/></td>
			<td><input name="name2" class="form-control" value="<%= apB2.getName()%>"/></td>
			<td><input name="saleprice2" class="form-control" value="<%= apB2.getSaleprice()%>"/></td>
			<td><input name="version2" type='hidden' class="form-control" value="<%= apB2.getVersion()%>"/></td>	
			<td>
				<button class="btn btn-success" name="action" value="create2">
					Add 2 books together into Branch store
				</button>
			</td>
		</tr>
		
		
		
<% for(Branch ap:branchs){	
%>  <tr>
		<td><%= ap.getStock() %></td>
		<td><%= ap.getName() %></td>
		<td><%= ap.getSaleprice() %></td>
		<td><%= ap.getVersion() %></td>
		<td>
			<a class="btn btn-danger" href="BranchWeb.jsp?action=remove&name=<%= ap.getName() %>&version=<%= ap.getVersion() %>">
				Delete
			</a>
			<a class="btn btn-warning" href="BranchWeb.jsp?action=select&name=<%= ap.getName() %>&version=<%= ap.getVersion() %>">
				Select
			</a>
		</td>
	</tr>
<% 
	}
%>	
   </table>
</form>
</body>
</html>

