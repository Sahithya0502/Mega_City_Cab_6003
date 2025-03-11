package Models;

import java.sql.Date;
import java.sql.Time;

public class Booking {
	private int Booking_ID;
	private int Cab_ID;
	private int Customer_ID;
	private String Customer_Current_Location;
	private String Customer_Destination;
	private Date Booked_Date;  // Add this
    private Time Booked_Time;  // Add this
	private String Hire_Charge;
	private String Total_Payable_Amount;
	private String Journey_Status;
	private Customer customer;  // Add this
    private Cab cab;  // Add this
	
	public int getBooking_ID() {
		return Booking_ID;
	}
	
	public void setBooking_ID(int booking_ID) {
		Booking_ID = booking_ID;
	}
	
	public int getCab_ID() {
		return Cab_ID;
	}
	
	public void setCab_ID(int cab_ID) {
		Cab_ID = cab_ID;
	}
	
	public int getCustomer_ID() {
		return Customer_ID;
	}
	
	public void setCustomer_ID(int customer_ID) {
		Customer_ID = customer_ID;
	}
	
	public String getCustomer_Current_Location() {
		return Customer_Current_Location;
	}
	
	public void setCustomer_Current_Location(String customer_Current_Location) {
		Customer_Current_Location = customer_Current_Location;
	}
	
	public String getCustomer_Destination() {
		return Customer_Destination;
	}
	
	public void setCustomer_Destination(String customer_Destination) {
		Customer_Destination = customer_Destination;
	}
	
	public Date getBooked_Date() {
		return Booked_Date;
	}

	public void setBooked_Date(Date booked_Date) {
		Booked_Date = booked_Date;
	}

	public Time getBooked_Time() {
		return Booked_Time;
	}

	public void setBooked_Time(Time booked_Time) {
		Booked_Time = booked_Time;
	}

	public String getHire_Charge() {
		return Hire_Charge;
	}
	
	public void setHire_Charge(String hire_Charge) {
		Hire_Charge = hire_Charge;
	}
	
	public String getTotal_Payable_Amount() {
		return Total_Payable_Amount;
	}
	
	public void setTotal_Payable_Amount(String total_Payable_Amount) {
		Total_Payable_Amount = total_Payable_Amount;
	}
	
	public String getJourney_Status() {
		return Journey_Status;
	}
	
	public void setJourney_Status(String journey_Status) {
		Journey_Status = journey_Status;
	}
	
	public Customer getCustomer() { return customer; }  // Getter
    public void setCustomer(Customer customer) { this.customer = customer; }  // Setter

    public Cab getCab() { return cab; }  // Getter
    public void setCab(Cab cab) { this.cab = cab; }  // Setter
}