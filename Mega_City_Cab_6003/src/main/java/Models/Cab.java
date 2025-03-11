package Models;

import java.util.Base64;

public class Cab {
	private int Cab_ID;
	private String Cab_Name;
	private String Cab_Brand;
	private String Cab_Number_Plate;
	private String Cab_Colour;
	private byte[] Cab_Image;
	private Double Cab_Booking_Price;
	private String Driver_Name;
	private String Driver_Telephone_Number;
	private String Cab_Status;

	public int getCab_ID() {
		return Cab_ID;
	}

	public void setCab_ID(int cab_ID) {
		Cab_ID = cab_ID;
	}

	public String getCab_Name() {
		return Cab_Name;
	}

	public void setCab_Name(String cab_Name) {
		Cab_Name = cab_Name;
	}

	public String getCab_Brand() {
		return Cab_Brand;
	}

	public void setCab_Brand(String cab_Brand) {
		Cab_Brand = cab_Brand;
	}

	public String getCab_Number_Plate() {
		return Cab_Number_Plate;
	}

	public void setCab_Number_Plate(String cab_Number_Plate) {
		Cab_Number_Plate = cab_Number_Plate;
	}

	public String getCab_Colour() {
		return Cab_Colour;
	}

	public void setCab_Colour(String cab_Colour) {
		Cab_Colour = cab_Colour;
	}

	public byte[] getCab_Image() {
		return Cab_Image;
	}

	public void setCab_Image(byte[] cab_Image) {
		Cab_Image = cab_Image;
	}

	public Double getCab_Booking_Price() {
		return Cab_Booking_Price;
	}

	public void setCab_Booking_Price(Double cab_Booking_Price) {
		Cab_Booking_Price = cab_Booking_Price;
	}

	public String getDriver_Name() {
		return Driver_Name;
	}

	public void setDriver_Name(String driver_Name) {
		Driver_Name = driver_Name;
	}

	public String getDriver_Telephone_Number() {
		return Driver_Telephone_Number;
	}

	public void setDriver_Telephone_Number(String driver_Telephone_Number) {
		Driver_Telephone_Number = driver_Telephone_Number;
	}

	public String getCab_Status() {
		return Cab_Status;
	}

	public void setCab_Status(String cab_Status) {
		Cab_Status = cab_Status;
	}

	public String getCabImageBase64() {
        if (Cab_Image != null) {
            return Base64.getEncoder().encodeToString(Cab_Image);
        }
        return null;
    }
}