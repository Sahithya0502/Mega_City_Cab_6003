package Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Cab;
import Services.CabService;

@WebServlet("/GetCabDetails")
public class GetCabDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Get all cars from the service layer
            List<Cab> allCars = CabService.getAllCabs();

            // Check if cars are null or empty (for debugging)
            if (allCars == null || allCars.isEmpty()) {
                System.out.println("No cars found in the database.");
            }

            // Set the cars list as a request attribute
            request.setAttribute("GetCarDetails", allCars);

            // Forward to Cars.jsp
            RequestDispatcher dis = request.getRequestDispatcher("Cabs.jsp");
            dis.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Log the error
            // Return an error response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Unable to fetch car details.");
        }
    }
}