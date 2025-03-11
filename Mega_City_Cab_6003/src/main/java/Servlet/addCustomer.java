package Servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Customer;
import Services.CustomerService;

@WebServlet("/addCustomer")
public class addCustomer extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    public addCustomer() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Create a Customer object
        Customer customer = new Customer();
        customer.setCustomer_Full_Name(request.getParameter("CustomerFullName"));
        customer.setCustomer_Email(request.getParameter("CustomerEmail"));
        customer.setCustomer_NIC(request.getParameter("CustomerNIC"));
        customer.setCustomer_Address(request.getParameter("CustomerAddress"));
        customer.setCustomer_Telephone_Number(request.getParameter("CustomerTelephoneNumber"));
        
        // Hash the password before saving
        String plainPassword = request.getParameter("CustomerPassword");
        String hashedPassword = hashPassword(plainPassword);
        customer.setCustomer_Password(hashedPassword);

        CustomerService customerService = new CustomerService();
        
        // Check for duplicate Customer_NIC and Customer_Email
        boolean isNICDuplicate = customerService.isNICDuplicate(customer.getCustomer_NIC());
        boolean isEmailDuplicate = customerService.isEmailDuplicate(customer.getCustomer_Email());

        response.setContentType("text/html");
        if (isNICDuplicate) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Please Use a Diferent NIC Number!');");
            response.getWriter().println("history.back();"); // Go back to the previous page without redirecting
            response.getWriter().println("</script>");
        } else if (isEmailDuplicate) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Please Use a Diferent Email!');");
            response.getWriter().println("history.back();"); // Go back to the previous page without redirecting
            response.getWriter().println("</script>");
        } else {
            // Proceed with registration if no duplicates found
            boolean isRegistered = customerService.registerCustomer(customer); // Assume this method returns true/false

            if (isRegistered) {
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Your Registration is Successful!');");
                response.getWriter().println("window.location.href = 'Login.jsp';");
                response.getWriter().println("</script>");
            } else {
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Your Registration Failed!');");
                response.getWriter().println("window.location.href = 'Register.jsp';");
                response.getWriter().println("</script>");
            }
        }
    }

    // Utility method to hash a password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = messageDigest.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b)); // Convert byte to hex
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}