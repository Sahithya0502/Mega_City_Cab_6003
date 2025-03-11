package Servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Models.Cab;
import Services.CabService;

@WebServlet("/addCab")
@MultipartConfig // Enables handling file uploads
public class addCab extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    public addCab() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Check if the admin session is still valid
        HttpSession session = request.getSession(false); // false means don't create a new session if it doesn't exist
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("Login.jsp"); // Redirect to login if session is missing
            return;
        }

        // Create a Cab object
        Cab cab = new Cab();
        cab.setCab_Name(request.getParameter("CabName"));
        cab.setCab_Brand(request.getParameter("CabBrand"));
        cab.setCab_Number_Plate(request.getParameter("CabNumberPlate"));
        cab.setCab_Colour(request.getParameter("CabColour"));
        cab.setCab_Booking_Price(Double.parseDouble(request.getParameter("CabBookingPrice")));
        cab.setDriver_Name(request.getParameter("DriverName"));
        cab.setDriver_Telephone_Number(request.getParameter("DriverTelephoneNumber"));

        // Handle file upload for the cab image
        Part filePart = request.getPart("CabImage");
        byte[] cabImage = null;

        // Check if a file was uploaded
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                cabImage = inputStream.readAllBytes();
            }
        }

        // Set the image as a byte array in the Cab object
        cab.setCab_Image(cabImage);

        // Pass the Cab object to the service layer
        CabService cabService = new CabService();
        
        boolean isCabNumberPlateDuplicate = cabService.isCabNumberPlateDuplicate(cab.getCab_Number_Plate());

        response.setContentType("text/html");
        if (isCabNumberPlateDuplicate) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Please Enter a Different Number Plate Value!');");
            response.getWriter().println("history.back();"); // Go back to the previous page without redirecting
            response.getWriter().println("</script>");
        } else {
            // Proceed with registration if no duplicates found
            boolean isRegistered = cabService.registerCab(cab); // Assume this method returns true/false

            if (isRegistered) {
            	response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Cab Addition is Successful');");
                response.getWriter().println("window.location.href = 'ManageCabs.jsp';");
                response.getWriter().println("</script>");
            } else {
            	response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Cab Addition Failed');");
                response.getWriter().println("window.location.href = 'ManageCabs.jsp';");
                response.getWriter().println("</script>");
            }
        }
    }

}