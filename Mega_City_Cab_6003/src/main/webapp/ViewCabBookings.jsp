<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Booking" %>
<%@ page import="Models.Cab" %>
<%@ page import="Models.Customer" %>
<%@ page import="Services.BookingService" %>

<%@ page import="java.util.stream.Collectors" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("Login.jsp"); // Redirect if session is missing
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>View Journey Finished Cab Bookings</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }

  body {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #1a1a1a; /* Black background */
    color: #ffffff; /* White text color */
    padding: 20px;
  }

  .menu-box {
    background-color: #ffffff; /* White background for table container */
    padding: 20px;
    border-radius: 12px;
    width: 100%;
    max-width: 100%;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow-x: auto;
    margin-top: 20px;
  }

  .header1 {
    font-size: 28px;
    font-weight: 600;
    color: #ffa500; /* Orange header */
    margin-bottom: 20px;
    text-align: center;
  }

  .search-bar {
    margin: 20px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
  }

  .search-container {
    display: flex;
    align-items: center;
    gap: 10px; /* Adds a 10px gap between the input field and the button */
    width: 100%;
    justify-content: center;
  }

  .search-container input[type="text"] {
    padding: 10px 15px;
    width: 600px;
    border: 2px solid #ffa500; /* Orange border */
    border-radius: 5px;
    font-size: 16px;
    background-color: #1a1a1a; /* Black background */
    color: #ffffff; /* White text */
  }

  .search-container button {
    padding: 10px 20px;
    background-color: #ffa500; /* Orange button */
    color: #ffffff;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .search-container button:hover {
    background-color: #cc8400; /* Darker orange hover effect */
  }

  .search-label {
    margin-top: 10px;
    font-size: 18px;
    font-weight: 500;
    color: #ffa500; /* Orange label */
  }

  .menu-box table {
    width: 100%;
    border-collapse: collapse;
  }

  .menu-box th {
    background-color: #ffa500; /* Orange table header */
    color: #ffffff; /* White text */
    font-weight: 500;
    text-transform: uppercase;
    padding: 15px;
    font-size: 14px;
    border-top: 1px solid #d0d7de;
    text-align: left;
  }

  .menu-box td {
    padding: 12px 15px;
    font-size: 15px;
    color: #333; /* Dark text for table cells */
    background-color: #f9f9f9; /* Light gray background */
  }

  .menu-box tr:nth-child(even) td {
    background-color: #ffffff; /* Alternate row color */
  }

  .menu-box tr:hover td {
    background-color: #ffd8a6; /* Light orange hover effect */
  }

  .menu-box img {
    width: 100px;
    height: auto;
    box-shadow: 
    1px 1px 3px #1a1a1a,  /* Slight offset for the first shadow */
    -1px -1px 3px #333,   /* Opposite offset for top-left lighting */
    inset 1px 1px 2px rgba(0, 0, 0, 0.3); /* Inner shadow for depth */
    border-radius: 5px;
  }
  
  .read-more-button {
  margin-top: 20px;
  width: 100%;
  padding: 6px;
  font-size: 18px;
  background-color: #ff5733;
  border: none;
  border-radius: 50px;
  color: #fff;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.read-more-button:hover {
  background-color: #c84f2b; /* Slightly darker orange */
}

  @media (max-width: 768px) {
    .menu-box {
      padding: 15px;
    }

    .menu-box th, .menu-box td {
      padding: 10px;
      font-size: 13px;
    }

    .header1 {
      font-size: 24px;
    }
  }
</style>
</head>
<body>
    <h1 class="header1">Journey Finished Cab Bookings</h1>

    <!-- Search Bar -->
    <div class="search-bar">
        <form method="GET" action="">
            <div class="search-container">
                <input type="text" name="search" placeholder="Search by any Column Below" 
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit">Search</button>
            </div>
        </form>

        <% 
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) { 
        %>
            <p class="search-label">Search results for: "<%= searchQuery %>"</p>
        <% } %>
    </div>

    <!-- Bookings Table -->
    <div class="menu-box">
        <table border="1">
            <!-- Table Header -->
            <tr>
                <th>Booking ID</th>
                <th>Cab ID</th>
                <th>Cab Name</th>
                <th>Cab Number Plate</th>
                <th>Cab Booking Price</th>
                <th>Cab Image</th>
                <th>Customer ID</th>
                <th>Customer Full Name</th>
                <th>Customer Address</th>
                <th>Customer Telephone Number</th>
                <th>Customer Current Location</th>
                <th>Customer Destination</th>
                <th>Booked Date</th>
                <th>Booked Time</th>
                <th>Hire Charge</th>
                <th>Total Payable Amount</th>
                <th>Journey Status</th>
            </tr>

            <%
                // Fetch all bookings
                List<Booking> allBookings = BookingService.getAllBookingsForAdmin();
                List<Booking> filteredBookings = allBookings;

                // Apply search filter if query is provided
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String lowerSearchQuery = searchQuery.toLowerCase();

                    filteredBookings = allBookings.stream()
                        .filter(booking -> 
                            String.valueOf(booking.getBooking_ID()).contains(lowerSearchQuery) ||
                            String.valueOf(booking.getCab_ID()).contains(lowerSearchQuery) ||
                            booking.getCab().getCab_Name().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getCab().getCab_Number_Plate().toLowerCase().contains(lowerSearchQuery) ||
                            String.valueOf(booking.getCab().getCab_Booking_Price()).contains(lowerSearchQuery) ||
                            String.valueOf(booking.getCustomer_ID()).contains(lowerSearchQuery) ||
                            booking.getCustomer().getCustomer_Full_Name().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getCustomer().getCustomer_Address().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getCustomer().getCustomer_Telephone_Number().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getCustomer_Current_Location().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getCustomer_Destination().toLowerCase().contains(lowerSearchQuery) ||
                            String.valueOf(booking.getBooked_Date()).contains(lowerSearchQuery) ||
                            String.valueOf(booking.getBooked_Time()).contains(lowerSearchQuery) ||
                            booking.getHire_Charge().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getTotal_Payable_Amount().toLowerCase().contains(lowerSearchQuery) ||
                            booking.getJourney_Status().toLowerCase().contains(lowerSearchQuery)
                        )
                        .collect(Collectors.toList());
                }
            %>

            <!-- If no results are found -->
            <% if (filteredBookings.isEmpty()) { %>
                <tr>
                    <td colspan="17" style="text-align: center; font-weight: bold; font-size: 20px">No results found</td>
                </tr>
            <% } else { %>
                <!-- Display booking data -->
                <% for (Booking booking : filteredBookings) { %>
                <tr>
                    <td><%= booking.getBooking_ID() %></td>
                    <td><%= booking.getCab_ID() %></td>
                    <td><%= booking.getCab().getCab_Name() %></td>
                    <td><%= booking.getCab().getCab_Number_Plate() %></td>
                    <td><%= booking.getCab().getCab_Booking_Price() %></td>
                    <td>
                        <% if (booking.getCab().getCab_Image() != null) { %>
                            <img src="data:image/jpeg;base64,<%= Base64.encodeBase64String(booking.getCab().getCab_Image()) %>" alt="Cab Image" />
                        <% } %>
                    </td>
                    <td><%= booking.getCustomer_ID() %></td>
                    <td><%= booking.getCustomer().getCustomer_Full_Name() %></td>
                    <td><%= booking.getCustomer().getCustomer_Address() %></td>
                    <td><%= booking.getCustomer().getCustomer_Telephone_Number() %></td>
                    <td><%= booking.getCustomer_Current_Location() %></td>
                    <td><%= booking.getCustomer_Destination() %></td>
                    <td><%= booking.getBooked_Date() %></td>
                    <td><%= booking.getBooked_Time() %></td>
                    <td><%= booking.getHire_Charge() %></td>
                    <td><%= booking.getTotal_Payable_Amount() %></td>
                    <td><%= booking.getJourney_Status() %></td>
                </tr>
                <% } %>
            <% } // End else block %>
        </table>
    </div>

</body>

</html>