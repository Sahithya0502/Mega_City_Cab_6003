package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Booking;
import Services.BookingService;

@WebServlet("/finishTheJourney")
@MultipartConfig // Enables handling file uploads
public class finishTheJourney extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;

    public finishTheJourney() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Create a Booking object
        Booking booking = new Booking();
        booking.setBooking_ID(Integer.parseInt(request.getParameter("BookingID")));
        booking.setJourney_Status(request.getParameter("JourneyStatus"));
        booking.setCab_ID(Integer.parseInt(request.getParameter("CabID")));

        // Pass the Booking object to the service layer
        BookingService bookingService = new BookingService();
        boolean isRegistered = bookingService.makeCabStatusAvailable(booking);

        // Generate JavaScript response
        response.setContentType("text/html");
        if (isRegistered) {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Journey is Finished and the Cab Status is Updated!');");
            response.getWriter().println("window.location.href = 'ManageBookings.jsp';");
            response.getWriter().println("</script>");
        } else {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Journey Finishing and Cab Status Updating Failed!');");
            response.getWriter().println("window.location.href = 'ManageBookings.jsp';");
            response.getWriter().println("</script>");
        }
    }
}