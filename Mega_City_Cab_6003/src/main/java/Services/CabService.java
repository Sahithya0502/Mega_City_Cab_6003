package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Controllers.DatabaseConnector;
import Models.Cab;

public class CabService {
	
    public boolean registerCab(Cab cab) {
        String insertCabQuery = "INSERT INTO cab_table "
                              + "(Cab_ID, Cab_Name, Cab_Brand, Cab_Number_Plate, Cab_Colour, Cab_Image, Cab_Booking_Price, Driver_Name, Driver_Telephone_Number)"
                              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the cab
            try (PreparedStatement insertCabStmt = connection.prepareStatement(insertCabQuery)) {
                insertCabStmt.setInt(1, cab.getCab_ID());
                insertCabStmt.setString(2, cab.getCab_Name());
                insertCabStmt.setString(3, cab.getCab_Brand());
                insertCabStmt.setString(4, cab.getCab_Number_Plate());
                insertCabStmt.setString(5, cab.getCab_Colour());
                insertCabStmt.setBytes(6, cab.getCab_Image());
                insertCabStmt.setDouble(7, cab.getCab_Booking_Price());
                insertCabStmt.setString(8, cab.getDriver_Name());
                insertCabStmt.setString(9, cab.getDriver_Telephone_Number());
                insertCabStmt.executeUpdate();
            }

            // Commit transaction
            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isCabNumberPlateDuplicate(String cabNumberPlate) {
        String query = "SELECT COUNT(*) FROM cab_table WHERE Cab_Number_Plate = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, cabNumberPlate);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Duplicate found
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in isCabNumberPlateDuplicate: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error in isCabNumberPlateDuplicate: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public static List<Cab> getAllCabs() {
        String query = "SELECT * FROM cab_table";
        List<Cab> allCabs = new ArrayList<>();
        
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            // Iterate through the result set to create Cab objects
            while (resultSet.next()) {
                Cab cab = new Cab();
                cab.setCab_ID(resultSet.getInt("Cab_ID"));
                cab.setCab_Name(resultSet.getString("Cab_Name"));
                cab.setCab_Brand(resultSet.getString("Cab_Brand"));
                cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
                cab.setCab_Colour(resultSet.getString("Cab_Colour"));
                cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
                cab.setDriver_Name(resultSet.getString("Driver_Name"));
                cab.setDriver_Telephone_Number(resultSet.getString("Driver_Telephone_Number"));
                cab.setCab_Status(resultSet.getString("Cab_Status"));
                
                byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);

                allCabs.add(cab);
                // Add the cab to the list
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return allCabs;
    }
    
    public static List<Cab> getCabsBySearch(String searchQuery) throws ClassNotFoundException {
        List<Cab> cabList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnector.getConnection();
            String query = "SELECT * FROM cab_table WHERE Cab_Name LIKE ? OR Cab_Brand LIKE ? OR Cab_Number_Plate LIKE ? OR Cab_Colour LIKE ? OR Cab_Booking_Price LIKE ? OR Cab_Status LIKE ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, "%" + searchQuery + "%");
            preparedStatement.setString(2, "%" + searchQuery + "%");
            preparedStatement.setString(3, "%" + searchQuery + "%");
            preparedStatement.setString(4, "%" + searchQuery + "%");
            preparedStatement.setString(5, "%" + searchQuery + "%");
            preparedStatement.setString(6, "%" + searchQuery + "%");
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Cab cab = new Cab();
                cab.setCab_ID(resultSet.getInt("Cab_ID"));
                cab.setCab_Name(resultSet.getString("Cab_Name"));
                cab.setCab_Brand(resultSet.getString("Cab_Brand"));
                cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
                cab.setCab_Colour(resultSet.getString("Cab_Colour"));
                cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
                cab.setDriver_Name(resultSet.getString("Driver_Name"));
                cab.setDriver_Telephone_Number(resultSet.getString("Driver_Telephone_Number"));
                cab.setCab_Status(resultSet.getString("Cab_Status"));
                byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);
                cabList.add(cab);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return cabList;
    }
    
    public boolean updateCab(Cab cab) {
        String updateCabQuery = "UPDATE cab_table SET Cab_Name = ?, Cab_Brand = ?, Cab_Number_Plate = ?, Cab_Colour = ?, Cab_Image = ?, Cab_Booking_Price = ?, Driver_Name = ?, Driver_Telephone_Number = ? WHERE Cab_ID = ?";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the cab
            try (PreparedStatement updateCabStmt = connection.prepareStatement(updateCabQuery)) {
                updateCabStmt.setString(1, cab.getCab_Name());
                updateCabStmt.setString(2, cab.getCab_Brand());
                updateCabStmt.setString(3, cab.getCab_Number_Plate());
                updateCabStmt.setString(4, cab.getCab_Colour());
                updateCabStmt.setBytes(5, cab.getCab_Image());
                updateCabStmt.setDouble(6, cab.getCab_Booking_Price());
                updateCabStmt.setString(7, cab.getDriver_Name());
                updateCabStmt.setString(8, cab.getDriver_Telephone_Number());
                updateCabStmt.setInt(9, cab.getCab_ID());

                int rowsUpdated = updateCabStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    connection.commit(); // Commit only if update was successful
                    return true;
                } else {
                    connection.rollback(); // Rollback if update fails
                    return false;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public byte[] getCabImage(int cabId) {
        String query = "SELECT Cab_Image FROM cab_table WHERE Cab_ID = ?";
        byte[] cabImage = null;

        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, cabId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                cabImage = rs.getBytes("Cab_Image");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cabImage; // Returns null if no image is found
    }
    
    public static Cab getCabById(int cabId) throws ClassNotFoundException {
        Cab cab = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnector.getConnection();
            String query = "SELECT * FROM cab_table WHERE Cab_ID = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, cabId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                cab = new Cab();
                cab.setCab_ID(resultSet.getInt("Cab_ID"));
                cab.setCab_Name(resultSet.getString("Cab_Name"));
                cab.setCab_Brand(resultSet.getString("Cab_Brand"));
                cab.setCab_Number_Plate(resultSet.getString("Cab_Number_Plate"));
                cab.setCab_Colour(resultSet.getString("Cab_Colour"));
                cab.setCab_Booking_Price(resultSet.getDouble("Cab_Booking_Price"));
                cab.setDriver_Name(resultSet.getString("Driver_Name"));
                cab.setDriver_Telephone_Number(resultSet.getString("Driver_Telephone_Number"));
                cab.setCab_Status(resultSet.getString("Cab_Status"));
                byte[] cabImageBytes = resultSet.getBytes("Cab_Image");
                cab.setCab_Image(cabImageBytes);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cab;
    }


}