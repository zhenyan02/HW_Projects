package finalproject.bookstore;


public class Buyer {
	private double saleprice;
	private int quantity ;
	private String name = "";
	
	public Buyer(double saleprice, int quantity, String name) {
		super();
		this.saleprice = saleprice;
		this.quantity = quantity;
		this.name = name;
	}

	public Buyer() {
		super();
	}
	
	public Buyer(int quantity, String name) {
		super();
		this.quantity = quantity;
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(double saleprice) {
		this.saleprice = saleprice;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	