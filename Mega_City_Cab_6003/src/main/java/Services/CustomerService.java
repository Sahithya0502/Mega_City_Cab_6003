package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import Controllers.DatabaseConnector;
import Models.Customer;

public class CustomerService {
    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO customer_table "
                     + "(Customer_ID, Customer_Full_Name, Customer_Email, Customer_NIC, Customer_Address, Customer_Telephone_Number, Customer_Password) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setInt(1, customer.getCustomer_ID()); // Assuming Customer_ID is a string
            preparedStatement.setString(2, customer.getCustomer_Full_Name());
            preparedStatement.setString(3, customer.getCustomer_Email());
            preparedStatement.setString(4, customer.getCustomer_NIC());
            preparedStatement.setString(5, customer.getCustomer_Address());
            preparedStatement.setString(6, customer.getCustomer_Telephone_Number());
            preparedStatement.setString(7, customer.getCustomer_Password()); // Already hashed password
            
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was inserted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an exception occurs
        }
    }
    
    public boolean isNICDuplicate(String userNIC) {
        String query = "SELECT COUNT(*) FROM customer_table WHERE Customer_NIC = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userNIC);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Duplicate found
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in isNICDuplicate: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error in isNICDuplicate: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailDuplicate(String userEmail) {
        String query = "SELECT COUNT(*) FROM customer_table WHERE Customer_Email = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Duplicate found
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in isEmailDuplicate: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error in isEmailDuplicate: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean validateCustomerLogin(Customer customer, HttpServletRequest request) {
        String query = "SELECT Customer_ID, Customer_Full_Name, Customer_Address, Customer_Telephone_Number FROM customer_table WHERE Customer_Email = ? AND Customer_Password = ?";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setString(1, customer.getCustomer_Email()); // Email provided by the customer
            preparedStatement.setString(2, customer.getCustomer_Password()); // Hashed password provided by the customer
            
            // Execute query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // If a record exists, set session attributes
                    int userId = resultSet.getInt("Customer_ID");
                    String username = resultSet.getString("Customer_Full_Name");
                    String telephonenumber = resultSet.getString("Customer_Telephone_Number");
                    String userAddress = resultSet.getString("Customer_Address");
                    
                    // Create or retrieve the session
                    HttpSession session = request.getSession();
                    session.setAttribute("Customer_ID", userId);
                    session.setAttribute("Customer_Full_Name", username);
                    session.setAttribute("Customer_Telephone_Number", telephonenumber);
                    session.setAttribute("Customer_Address", userAddress);
                    
                    return true; // Login successful
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if no record exists or an exception occurs
    }
}