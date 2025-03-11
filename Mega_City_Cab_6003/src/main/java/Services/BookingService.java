package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Controllers.DatabaseConnector;
import Models.Booking;
import Models.Cab;
import Models.Customer;

public class BookingService {
	public boolean registerBooking(Booking booking) {
        String insertBookingQuery = "INSERT INTO booking_table "
                              + "(Booking_ID, Cab_ID, Customer_ID, Customer_Current_Location, Customer_Destination, Hire_Charge, Total_Payable_Amount)"
                              + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        String updateCabStatusQuery = "UPDATE cab_table "
                                       + "SET Cab_Status = 'Not Available' "
                                       + "WHERE Cab_ID = ? AND Cab_Status = 'Available'";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertBookingStmt = connection.prepareStatement(insertBookingQuery)) {
            	insertBookingStmt.setInt(1, booking.getBooking_ID());
                insertBookingStmt.setInt(2, booking.getCab_ID());
                insertBookingStmt.setInt(3, booking.getCustomer_ID());
                insertBookingStmt.setString(4, booking.getCustomer_Current_Location());
                insertBookingStmt.setString(5, booking.getCustomer_Destination());
                insertBookingStmt.setString(6, booking.getHire_Charge());
                insertBookingStmt.setString(7, booking.getTotal_Payable_Amount());
                insertBookingStmt.executeUpdate();
            }

            // Update the driver's status
            try (PreparedStatement updateCabStmt = connection.prepareStatement(updateCabStatusQuery)) {
                updateCabStmt.setInt(1, booking.getCab_ID());
                int rowsUpdated = updateCabStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    // If no rows were updated, rollback and return false
                    connection.rollback();
                    return false;
                }
            }

            // Commit transaction
            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public boolean updateHireChargeandTotalPayableAmount(Booking booking) {
        String updateHireChargeAndTotalPayableAmountQuery = "UPDATE booking_table SET Hire_Charge = ?, Total_Payable_Amount = ? WHERE Booking_ID = ?";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertHireChargeAndTotalPayableAmountStmt = connection.prepareStatement(updateHireChargeAndTotalPayableAmountQuery)) {
            	insertHireChargeAndTotalPayableAmountStmt.setString(1, booking.getHire_Charge());
            	insertHireChargeAndTotalPayableAmountStmt.setString(2, booking.getTotal_Payable_Amount());
            	insertHireChargeAndTotalPayableAmountStmt.setInt(3, booking.getBooking_ID());
                insertHireChargeAndTotalPayableAmountStmt.executeUpdate();
            }

            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public boolean makeCabStatusAvailable(Booking booking) {
        String finishJourneyQuery = "UPDATE booking_table SET Journey_Status = ? WHERE Booking_ID = ? AND Cab_ID = ?";
        
        String updateCabStatusQuery1 = "UPDATE cab_table "
                                       + "SET Cab_Status = 'Available' "
                                       + "WHERE Cab_ID = ? AND Cab_Status = 'Not Available'";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertBookingStmt = connection.prepareStatement(finishJourneyQuery)) {
            	insertBookingStmt.setString(1, booking.getJourney_Status());
                insertBookingStmt.setInt(2, booking.getBooking_ID());
                insertBookingStmt.setInt(3, booking.getCab_ID());
                insertBookingStmt.executeUpdate();
            }

            // Update the driver's status
            try (PreparedStatement updateCabStmt = connection.prepareStatement(updateCabStatusQuery1)) {
                updateCabStmt.setInt(1, booking.getCab_ID());
                int rowsUpdated = updateCabStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    // If no rows were updated, rollback and return false
                    connection.rollback();
                    return false;
                }
            }

            // Commit transaction
            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error details: " + e.getMessage());
            return false;
        }
    }
	
	public static List<Booking> getAllHireChargeEnteringCabs() {
	    String query = "SELECT b.Booking_ID, b.Cab_ID, b.Customer_ID, b.Booked_Date, b.Booked_Time, b.Customer_Current_Location, b.Customer_Destination, b.Hire_Charge, b.Total_Payable_Amount, b.Journey_Status," +
	                   "c.Customer_Full_Name, c.Customer_Address, c.Customer_Telephone_Number, " +
	                   "cb.Cab_Name, cb.Cab_Number_Plate, cb.Cab_Booking_Price, cb.Cab_Image " +
	                   "FROM booking_table b " +
	                   "INNER JOIN customer_table c ON b.Customer_ID = c.Customer_ID " +
	                   "INNER JOIN cab_table cb ON b.Cab_ID = cb.Cab_ID " +
	                   "WHERE b.Hire_Charge = 'It will be Informed Soon' " +
	                   "AND b.Total_Payable_Amount = 'It will be Informed Soon'";

	    List<Booking> allBookings = new ArrayList<>();

	    try (Connection connection = DatabaseConnector.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        while (resultSet.next()) {
	            Booking booking = new Booking();
	            booking.setBooking_ID(resultSet.getInt("Booking_ID"));
	            booking.setCab_ID(resultSet.getInt("Cab_ID"));
	            booking.setCustomer_ID(resultSet.getInt("Customer_ID"));
	            booking.setBooked_Date(resultSet.getDate("Booked_Date"));
	            booking.setBooked_Time(resultSet.getTime("Booked_Time"));
	            booking.setCustomer_Current_Location(resultSet.getString("Customer_Current_Location"));
	            booking.setCustomer_Destination(resultSet.getString("Customer_Destination"));
	            booking.setHire_Charge(resultSet.getString("Hire_Charge"));
	            booking.setTotal_Payable_Amount(resultSet.getString("Total_Payable_Amount"));
	            booking.setJourney_Status(resultSet.getString("Journey_Status"));

	            // Set Customer details
	            Customer customer = new Customer();
	            customer.setCustomer_Full_Name(resultSet.getString("Customer_Full_Name"));
	            customer.setCustomer_Address(resultSet.getString("Customer_Address"));
	            customer.setCustomer_Telephone_Number(resultSet.getString("Customer_Telephone_Number"));
	            booking.setCustomer(customer);

	            // Set Cab details
	            Cab cab = new Cab();
	            cab.setCab_Name(resultSet.getString("Cab_Name"));
	            cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
	            cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
	            byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);
	            booking.setCab(cab);

	            allBookings.add(booking);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return allBookings;
	}
	
	public static Booking getBookingById(int bookingId) throws ClassNotFoundException {
	    Booking booking = null;
	    Cab cab = null;

	    String query = "SELECT b.Booking_ID, b.Cab_ID, b.Customer_ID, b.Customer_Current_Location, " +
	                   "b.Customer_Destination, b.Booked_Date, b.Booked_Time, b.Hire_Charge, " +
	                   "b.Total_Payable_Amount, b.Journey_Status, cb.Cab_Booking_Price " +
	                   "FROM booking_table b " +
	                   "INNER JOIN cab_table cb ON b.Cab_ID = cb.Cab_ID " +
	                   "WHERE b.Booking_ID = ?";

	    try (Connection connection = DatabaseConnector.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setInt(1, bookingId);
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next()) {
	                booking = new Booking();
	                booking.setBooking_ID(resultSet.getInt("Booking_ID"));
	                booking.setCab_ID(resultSet.getInt("Cab_ID"));
	                booking.setCustomer_ID(resultSet.getInt("Customer_ID"));
	                booking.setCustomer_Current_Location(resultSet.getString("Customer_Current_Location"));
	                booking.setCustomer_Destination(resultSet.getString("Customer_Destination"));
	                booking.setBooked_Date(resultSet.getDate("Booked_Date"));
	                booking.setBooked_Time(resultSet.getTime("Booked_Time"));
	                booking.setHire_Charge(resultSet.getString("Hire_Charge"));
	                booking.setTotal_Payable_Amount(resultSet.getString("Total_Payable_Amount"));
	                booking.setJourney_Status(resultSet.getString("Journey_Status"));

	                // Set Cab details
	                cab = new Cab();
	                cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
	                booking.setCab(cab); // Assign cab to booking
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return booking;
	}
	
	public static List<Booking> getAllHireFinishingCabs() {
	    String query = "SELECT b.Booking_ID, b.Cab_ID, b.Customer_ID, b.Booked_Date, b.Booked_Time, b.Customer_Current_Location, b.Customer_Destination, b.Hire_Charge, b.Total_Payable_Amount, b.Journey_Status," +
	                   "c.Customer_Full_Name, c.Customer_Address, c.Customer_Telephone_Number, " +
	                   "cb.Cab_Name, cb.Cab_Number_Plate, cb.Cab_Booking_Price, cb.Cab_Image " +
	                   "FROM booking_table b " +
	                   "INNER JOIN customer_table c ON b.Customer_ID = c.Customer_ID " +
	                   "INNER JOIN cab_table cb ON b.Cab_ID = cb.Cab_ID " +
	                   "WHERE b.Hire_Charge != 'It will be Informed Soon' " +
	                   "AND b.Total_Payable_Amount != 'It will be Informed Soon' AND b.Journey_Status = 'You are on Journey'";

	    List<Booking> allBookings = new ArrayList<>();

	    try (Connection connection = DatabaseConnector.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        while (resultSet.next()) {
	            Booking booking = new Booking();
	            booking.setBooking_ID(resultSet.getInt("Booking_ID"));
	            booking.setCab_ID(resultSet.getInt("Cab_ID"));
	            booking.setCustomer_ID(resultSet.getInt("Customer_ID"));
	            booking.setBooked_Date(resultSet.getDate("Booked_Date"));
	            booking.setBooked_Time(resultSet.getTime("Booked_Time"));
	            booking.setCustomer_Current_Location(resultSet.getString("Customer_Current_Location"));
	            booking.setCustomer_Destination(resultSet.getString("Customer_Destination"));
	            booking.setHire_Charge(resultSet.getString("Hire_Charge"));
	            booking.setTotal_Payable_Amount(resultSet.getString("Total_Payable_Amount"));
	            booking.setJourney_Status(resultSet.getString("Journey_Status"));

	            // Set Customer details
	            Customer customer = new Customer();
	            customer.setCustomer_Full_Name(resultSet.getString("Customer_Full_Name"));
	            customer.setCustomer_Address(resultSet.getString("Customer_Address"));
	            customer.setCustomer_Telephone_Number(resultSet.getString("Customer_Telephone_Number"));
	            booking.setCustomer(customer);

	            // Set Cab details
	            Cab cab = new Cab();
	            cab.setCab_Name(resultSet.getString("Cab_Name"));
	            cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
	            cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
	            byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);
	            booking.setCab(cab);

	            allBookings.add(booking);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return allBookings;
	}
	
	public static List<Booking> getAllBookingsForAdmin() {
	    String query = "SELECT b.Booking_ID, b.Cab_ID, b.Customer_ID, b.Booked_Date, b.Booked_Time, b.Customer_Current_Location, b.Customer_Destination, b.Hire_Charge, b.Total_Payable_Amount, b.Journey_Status," +
	                   "c.Customer_Full_Name, c.Customer_Address, c.Customer_Telephone_Number, " +
	                   "cb.Cab_Name, cb.Cab_Number_Plate, cb.Cab_Booking_Price, cb.Cab_Image " +
	                   "FROM booking_table b " +
	                   "INNER JOIN customer_table c ON b.Customer_ID = c.Customer_ID " +
	                   "INNER JOIN cab_table cb ON b.Cab_ID = cb.Cab_ID " +
	                   "WHERE b.Hire_Charge != 'It will be Informed Soon' " +
	                   "AND b.Total_Payable_Amount != 'It will be Informed Soon' AND b.Journey_Status = 'Your Journey is Finished'";

	    List<Booking> allBookings = new ArrayList<>();

	    try (Connection connection = DatabaseConnector.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        while (resultSet.next()) {
	            Booking booking = new Booking();
	            booking.setBooking_ID(resultSet.getInt("Booking_ID"));
	            booking.setCab_ID(resultSet.getInt("Cab_ID"));
	            booking.setCustomer_ID(resultSet.getInt("Customer_ID"));
	            booking.setBooked_Date(resultSet.getDate("Booked_Date"));
	            booking.setBooked_Time(resultSet.getTime("Booked_Time"));
	            booking.setCustomer_Current_Location(resultSet.getString("Customer_Current_Location"));
	            booking.setCustomer_Destination(resultSet.getString("Customer_Destination"));
	            booking.setHire_Charge(resultSet.getString("Hire_Charge"));
	            booking.setTotal_Payable_Amount(resultSet.getString("Total_Payable_Amount"));
	            booking.setJourney_Status(resultSet.getString("Journey_Status"));

	            // Set Customer details
	            Customer customer = new Customer();
	            customer.setCustomer_Full_Name(resultSet.getString("Customer_Full_Name"));
	            customer.setCustomer_Address(resultSet.getString("Customer_Address"));
	            customer.setCustomer_Telephone_Number(resultSet.getString("Customer_Telephone_Number"));
	            booking.setCustomer(customer);

	            // Set Cab details
	            Cab cab = new Cab();
	            cab.setCab_Name(resultSet.getString("Cab_Name"));
	            cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
	            cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
	            byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);
	            booking.setCab(cab);

	            allBookings.add(booking);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return allBookings;
	}
	
	public static List<Booking> getAllBookingsForCustomer(int customerID) {
	    String query = "SELECT b.Booking_ID, b.Cab_ID, b.Customer_ID, b.Booked_Date, b.Booked_Time, b.Customer_Current_Location, b.Customer_Destination, b.Hire_Charge, b.Total_Payable_Amount, b.Journey_Status, " +
	                   "c.Customer_Full_Name, c.Customer_Address, c.Customer_Telephone_Number, " +
	                   "cb.Cab_Name, cb.Cab_Number_Plate, cb.Cab_Booking_Price, cb.Cab_Image " +
	                   "FROM booking_table b " +
	                   "INNER JOIN customer_table c ON b.Customer_ID = c.Customer_ID " +
	                   "INNER JOIN cab_table cb ON b.Cab_ID = cb.Cab_ID " +
	                   "WHERE b.Customer_ID = ?";

	    List<Booking> allBookings = new ArrayList<>();

	    try (Connection connection = DatabaseConnector.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        // Set the Customer_ID in the prepared statement
	        preparedStatement.setInt(1, customerID);
	        
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            while (resultSet.next()) {
	                Booking booking = new Booking();
	                booking.setBooking_ID(resultSet.getInt("Booking_ID"));
	                booking.setCab_ID(resultSet.getInt("Cab_ID"));
	                booking.setCustomer_ID(resultSet.getInt("Customer_ID"));
	                booking.setBooked_Date(resultSet.getDate("Booked_Date"));
	                booking.setBooked_Time(resultSet.getTime("Booked_Time"));
	                booking.setCustomer_Current_Location(resultSet.getString("Customer_Current_Location"));
	                booking.setCustomer_Destination(resultSet.getString("Customer_Destination"));
	                booking.setHire_Charge(resultSet.getString("Hire_Charge"));
	                booking.setTotal_Payable_Amount(resultSet.getString("Total_Payable_Amount"));
	                booking.setJourney_Status(resultSet.getString("Journey_Status"));

	                // Set Customer details
	                Customer customer = new Customer();
	                customer.setCustomer_Full_Name(resultSet.getString("Customer_Full_Name"));
	                customer.setCustomer_Address(resultSet.getString("Customer_Address"));
	                customer.setCustomer_Telephone_Number(resultSet.getString("Customer_Telephone_Number"));
	                booking.setCustomer(customer);

	                // Set Cab details
	                Cab cab = new Cab();
	                cab.setCab_Name(resultSet.getString("Cab_Name"));
	                cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
	                cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
	                byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
	                cab.setCab_Image(cabImageBytes);
	                booking.setCab(cab);

	                allBookings.add(booking);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return allBookings;
	}
}