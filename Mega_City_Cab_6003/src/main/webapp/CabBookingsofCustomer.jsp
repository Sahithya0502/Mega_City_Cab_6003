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
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee:ital@0;1&family=Allerta&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Sen:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee:ital@0;1&family=Allan:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="CabStyles2.css" />
    <link rel="stylesheet" href="CabStyles3.css" />
    <title>Cabs</title>
    <script type="text/javascript">
        // Function to confirm logout
        function confirmLogout() {
            // Show confirmation dialog
            var result = confirm("Are you sure you want to log out?");
            
            if (result) {
                // If user confirms, clear the session and reload the page (logout on same page)
                // Send a request to logout
                window.location.href = "LogoutProcess.jsp"; // Or directly handle session invalidation
            } else {
                // If user cancels, do nothing
                alert("You are still logged in.");
            }
        }
    </script>
  </head>
  
  <body>
    <div class="navbar">
      <div class="navbar-container">
        <div class="logo-container">
          <h1 class="logo">MEGA CITY CAB</h1>
        </div>
        <div class="menu-container">
          <ul class="menu-list">
            <li class="menu-list-item"><menu><a class="link-stylings" href="Home.jsp">HOME</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Cabs.jsp">CABS</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Help.jsp">HELP</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="AboutUs.jsp">ABOUT US</a></menu> </li>
            <form action="" method="GET" class="menu-list-item-search-bar-main">
              <li class="menu-list-item-search-bar-main"> <menu> <input type="text" name="search"  class="menu-list-item-search-bar" placeholder="Search" value="${param.search}" required/> </menu> </li>
              <li class="menu-list-item-searching-icon-button"> <button type="submit" class="search-menu-icon-button"> <i class="search-menu-icon fas fa-search"></i> </button> </li>
            </form>
          </ul>
        </div>
      </div>
    </div>

    <%
        // Retrieve session attributes safely
        Integer Customer_ID = (Integer) session.getAttribute("Customer_ID");
        String Customer_Full_Name = (String) session.getAttribute("Customer_Full_Name");
        
    %>

    <c:choose>
      <c:when test="${not empty Customer_Full_Name && not empty Customer_ID}">
        <div class="navbar2">
          <div class="navbar-container2">
            <div class="menu-container2">
              <ul class="menu-list2">
                <li class="menu-list-item2"><menu><a class="link-stylings2" href="CabBookingsofCustomer.jsp"><i class="left-menu-icon-navbar2 fas fa-book"></i><span class="menu-heading">YOUR CAB BOOKINGS</span></a></menu></li>
			  </ul>
            </div>
            <div class="logo-container2">
              <h1 class="logo2">WELCOME ${Customer_Full_Name}</h1>
            </div>
          </div>
        </div>  
        <div class="sidebar">
          <div class="menu-item">
            <a href="javascript:void(0);" onclick="confirmLogout()"><i class="left-menu-icon fas fa-sign-out-alt"></i><span class="submenusidebar">LOGOUT</span></a>
          </div>
        </div>
      </c:when>

      <c:otherwise>
        <div class="sidebar">
          <div class="menu-item">
            <a href="Register.jsp"><i class="left-menu-icon fas fa-users"></i><span class="submenusidebar">REGISTER</span></a>
          </div>
          <div class="menu-item">
            <a href="Login.jsp"><i class="left-menu-icon fas fa-user"></i><span class="submenusidebar">LOGIN</span></a>
          </div>
        </div>
      </c:otherwise>
    </c:choose>

    <div class="container1"> 
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
                List<Booking> allBookings = BookingService.getAllBookingsForCustomer(Customer_ID);
                List<Booking> filteredBookings = allBookings;

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

            <% if (filteredBookings.isEmpty()) { %>
                <tr>
                    <td colspan="17" style="text-align: center; font-weight: bold; font-size: 20px">No results found</td>
                </tr>
            <% } else { %>
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
            <% } %>
        </table>
    </div>

    <footer class="footer">
        <div class="footer__copy">© 2025 MEGA CITY CABS. All rights reserved.</div>
    </footer>
</div>

  </body>
</html>