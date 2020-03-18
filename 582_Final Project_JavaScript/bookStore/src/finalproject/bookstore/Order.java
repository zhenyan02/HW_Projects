package finalproject.bookstore;

public class Order {
		private int orderNbr = 0;
		private int stock=0;
		private String name = "";
		private int version ;
		
		
		
		public Order() {
			super();
		}

		public Order(int orderNbr, int stock, String name, int version) {
			super();
			this.orderNbr = orderNbr;
			this.stock = stock;
			this.name = name;
			this.version = version;
		}
		
		public int getOrderNbr() {
			return orderNbr;
		}
		public void setOrderNbr(int orderNbr) {
			this.orderNbr = orderNbr;
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
