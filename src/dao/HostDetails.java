package dao;

public class HostDetails {
	
	private String ProductName;
	private int TotalLowCount;
	private int TotalMediumCount;
	private int TotalHighCount;
	private int TotalCriticalCount;
	public String getProductName() {
		return ProductName;
	}
	@Override
	public String toString() {
		return "HostDetails [ProductName=" + ProductName + ", TotalLowCount="
				+ TotalLowCount + ", TotalMediumCount=" + TotalMediumCount
				+ ", TotalHighCount=" + TotalHighCount
				+ ", TotalCriticalCount=" + TotalCriticalCount + "]";
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public int getTotalLowCount() {
		return TotalLowCount;
	}
	public void setTotalLowCount(int totalLowCount) {
		TotalLowCount = totalLowCount;
	}
	public int getTotalMediumCount() {
		return TotalMediumCount;
	}
	public void setTotalMediumCount(int totalMediumCount) {
		TotalMediumCount = totalMediumCount;
	}
	public int getTotalHighCount() {
		return TotalHighCount;
	}
	public void setTotalHighCount(int totalHighCount) {
		TotalHighCount = totalHighCount;
	}
	public int getTotalCriticalCount() {
		return TotalCriticalCount;
	}
	public void setTotalCriticalCount(int totalCriticalCount) {
		TotalCriticalCount = totalCriticalCount;
	}
	
	public int[] getDetails(String HNAME){
		
		
		
		
		return null;
		
		
		
	}
	public HostDetails() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HostDetails(String productName) {
		super();
		ProductName = productName;
	/*	this.TotalLowCount=TotalLowCount;
		this.TotalMediumCount=TotalMediumCount;
		this.TotalHighCount=TotalHighCount;
		this.TotalCriticalCount=TotalCriticalCount;*/
	}

}
