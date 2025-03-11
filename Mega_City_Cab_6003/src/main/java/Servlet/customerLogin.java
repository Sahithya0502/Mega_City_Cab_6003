package Servlet;

import java.io.IOException;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Customer;
import Services.CustomerService;

@WebServlet("/customerLogin")
public class customerLogin extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;

	public customerLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("CustomerEmail");
	    String password = request.getParameter("CustomerPassword"); // Plain text password from user input
	    
	    if (email.equals("admin@megacitycabs.lk") && password.equals("12345")) {
	        request.getSession().setAttribute("adminLoggedIn", true); // Set session
	        
	        response.setContentType("text/html");
	        response.getWriter().println("<script type=\"text/javascript\">");
	        response.getWriter().println("alert('Admin Login is Successful!');");
	        response.getWriter().println("window.location.href = 'AdminDashboard.jsp';"); // Redirect using JavaScript
	        response.getWriter().println("</script>");
	        return; // Stop further execution
	    }
	    
	    // Hash the password before checking against the database
	    String hashedPassword = PasswordHasher.hashPassword(password); // Custom utility to hash password

	    Customer customer = new Customer();
	    customer.setCustomer_Email(email);
	    customer.setCustomer_Password(hashedPassword);

	    CustomerService customerService = new CustomerService();
	    boolean isValid = customerService.validateCustomerLogin(customer, request); // Pass HttpServletRequest

	    if (isValid) {
	        response.setContentType("text/html");
	        response.getWriter().println("<script type=\"text/javascript\">");
	        response.getWriter().println("alert('Your Login is Successful!');");
	        response.getWriter().println("window.location.href = 'Home.jsp';");
	        response.getWriter().println("</script>");
	    } else {
	        response.setContentType("text/html");
	        response.getWriter().println("<script type=\"text/javascript\">");
	        response.getWriter().println("alert('Login Failed due to Invalid Customername or Password');");
	        response.getWriter().println("window.location.href = 'Login.jsp';");
	        response.getWriter().println("</script>");
	    }
	}
	
	public class PasswordHasher {
	    public static String hashPassword(String password) {
	        try {
	            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
	            byte[] hashedBytes = messageDigest.digest(password.getBytes("UTF-8"));

	            // Convert byte array to hexadecimal string
	            StringBuilder hexString = new StringBuilder();
	            for (byte b : hashedBytes) {
	                String hex = Integer.toHexString(0xff & b);
	                if (hex.length() == 1) hexString.append('0');
	                hexString.append(hex);
	            }
	            return hexString.toString();
	        } catch (Exception e) {
	            throw new RuntimeException("Error hashing password", e);
	        }
	    }
	}
}