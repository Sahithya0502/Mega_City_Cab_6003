<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Booking" %>
<%@ page import="Models.Cab" %>
<%@ page import="Models.Customer" %>
<%@ page import="Services.BookingService" %>
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
<title>Hire Charge Entering List</title>
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
  <h1 class="header1">Cab Booking List to Enter Hire Charge</h1>

  <div class='menu-box'>
    <table border="1">
      <%
        // Fetch cab details from the service
        List<Booking> bookings = BookingService.getAllHireChargeEnteringCabs();

        // Debugging: Check if data is retrieved
        if (bookings == null || bookings.isEmpty()) {
          %>
            <script>
                alert("No Hires Found to Enter Hire Charges.");
                window.location.href = "ManageBookings.jsp";
            </script>
          <%
        } else {
      %>
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
        <th>Action</th>
      </tr>

      <% for (Booking booking : bookings) { %>
      <tr>
        <td><%= booking.getBooking_ID() %></td>
        <td><%= booking.getCab_ID() %></td>
        <td><%= booking.getCab().getCab_Name() %></td>
        <td><%= booking.getCab().getCab_Number_Plate() %></td>
        <td><%= booking.getCab().getCab_Booking_Price() %></td>
        <% if (booking.getCab().getCab_Image() != null) { %>
          <td><img src="data:image/jpeg;base64,<%= booking.getCab().getCabImageBase64() %>" alt="Plan Image" /></td>
        <% } %>
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
        <td><a href="ConfirmHireCharge.jsp?Booking_ID=<%= booking.getBooking_ID() %>"><button class='read-more-button'>Enter Hire Charge</button></a></td>
      </tr>
      <% } %>
      <% } // End else block %>
    </table>
  </div>

</body>

</html>