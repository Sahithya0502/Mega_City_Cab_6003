package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Booking;
import Services.BookingService;

@WebServlet("/addBooking")
@MultipartConfig // Enables handling file uploads
public class addBooking extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    public addBooking() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Create a Booking object
        Booking booking = new Booking();
        booking.setCab_ID(Integer.parseInt(request.getParameter("CabID")));
        booking.setCustomer_ID(Integer.parseInt(request.getParameter("CustomerID")));
        booking.setCustomer_Current_Location(request.getParameter("CustomerCurrentLocation"));
        booking.setCustomer_Destination(request.getParameter("CustomerDestination"));
        booking.setHire_Charge(request.getParameter("HireCharge"));
        booking.setTotal_Payable_Amount(request.getParameter("TotalPayableAmount"));

        // Pass the Booking object to the service layer
        BookingService bookingService = new BookingService();
        boolean isRegistered = bookingService.registerBooking(booking);

        // Generate JavaScript response
        response.setContentType("text/html");
        if (isRegistered) {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Dear Customer, Your Booking is Successful and Check out the Hire Amount and the Total Amount Payable in your Bookings!');");
            response.getWriter().println("window.location.href = 'Home.jsp';");
            response.getWriter().println("</script>");
        } else {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Booking Failed');");
            response.getWriter().println("window.location.href = 'Home.jsp';");
            response.getWriter().println("</script>");
        }
    }
}