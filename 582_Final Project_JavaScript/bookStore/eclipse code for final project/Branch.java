package finalproject.bookstore;

public class Branch {
	private double saleprice = 0.0;
	private int stock=0;
	private String name = "";
	private int version ;
		
	public Branch() {
		super();
	}
	
	public Branch(double saleprice, int stock, String name, int version) {
		super();
		this.saleprice = saleprice;
		this.stock = stock;
		this.name = name;
		this.version = version;
	}
	
	public double getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(double saleprice) {
		this.saleprice = saleprice;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
		
}


/*		<tr>			
<td><input name="stock2" class="form-control" value="<%= apB2.getStock()%>"/></td>
<td><input name="name2" class="form-control" value="<%= apB2.getName()%>"/></td>
<td><input name="saleprice2" class="form-control" value="<%= apB2.getSaleprice()%>"/></td>
<td><input name="version2" class="form-control" value="<%= apB2.getVersion()%>"/></td>	
<td>
	<button class="btn btn-success" name="action" value="create2">
		Add 2 together
	</button>
</td>
</tr>


<div>			
<td><input name="stock" class="form-control" value="<%= app.getStock()%>"/></td>
<span class="input-group-addon">-</span>
<td> <select name = "options">
	<% for(Branch ap:branchs){%>  
			<option><%= ap.getName() %></option>
	<% }%>		
</select> 	</td>		
</div>*/