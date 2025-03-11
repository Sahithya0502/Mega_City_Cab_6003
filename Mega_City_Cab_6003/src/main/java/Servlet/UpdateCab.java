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

@WebServlet("/UpdateCab")
@MultipartConfig // Enables handling file uploads
public class UpdateCab extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateCab() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	HttpSession session = request.getSession(false); // false means don't create a new session if it doesn't exist
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("Login.jsp"); // Redirect to login if session is missing
            return;
        }
        // Create a Cab object
        Cab cab = new Cab();
        cab.setCab_ID(Integer.parseInt(request.getParameter("CabID")));
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
            cab.setCab_Image(cabImage);
        } else {
            // Retain existing image if no new image is uploaded
            CabService cabService = new CabService();
            byte[] existingImage = cabService.getCabImage(cab.getCab_ID());

            if (existingImage != null) {
                cab.setCab_Image(existingImage);
            } else {
                cab.setCab_Image(null); // Handle case where no image exists in DB
            }
        }

        // Pass the Cab object to the service layer
        CabService cabService = new CabService();
        
        boolean isCabNumberPlateDuplicate = cabService.isCabNumberPlateDuplicate(cab.getCab_Number_Plate());

        response.setContentType("text/html");
        if (isCabNumberPlateDuplicate) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('You are Duplicating a Cab Number Plate Value!');");
            response.getWriter().println("history.back();"); // Go back to the previous page without redirecting
            response.getWriter().println("</script>");
        } else {
            // Proceed with registration if no duplicates found
            boolean isRegistered = cabService.updateCab(cab); // Assume this method returns true/false

            if (isRegistered) {
            	response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Dear Admin, Your Cab is Updated Successfully');");
                response.getWriter().println("window.location.href = 'UpdateCabs.jsp';");
                response.getWriter().println("</script>");
            } else {
            	response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Dear Admin, Your Cab Update Failed');");
                response.getWriter().println("window.location.href = 'UpdateCabs.jsp';");
                response.getWriter().println("</script>");
            }
        }
    }
}