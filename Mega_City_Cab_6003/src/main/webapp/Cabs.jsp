<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Cab" %>
<%@ page import="Services.CabService" %>
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
    <link rel="stylesheet" href="CabStyles.css" />
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
      <div class="container2">
        <h2 class="section__header">CABS</h2>
          <c:if test="${not empty param.search}">
    		<p class="search-label">Search results for: "${param.search}"</p>
		  </c:if>

        
        <div class="container3">
          <section class="section__container1" id="menu">
            
                <div class="order__grid">
                <%
              String searchQuery = request.getParameter("search");
              List<Cab> cabs;
              if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                  cabs = CabService.getCabsBySearch(searchQuery.trim());
              } else {
                  cabs = CabService.getAllCabs();
              }
            %><% if (cabs.isEmpty()) { %>
              <p class='no-result-found'>No Cabs Found.</p>
            <% } %>
				<% for (Cab cab : cabs) { %>
                  <div class="order__card">
                    <% if (cab.getCab_Image() != null) { %>
                    <img class="plan-image" src="data:image/jpeg;base64,<%= cab.getCabImageBase64() %>" alt="Plan Image" />
                    <% } %>
                    <h4><%= cab.getCab_Name() %></h4>
                    <h5><%= cab.getCab_Brand() %></h5>
                    <h6><%= cab.getCab_Number_Plate() %></h6>
                    <p class="cabcolour"><%= cab.getCab_Colour() %></p>
                    <p class="cabbookingprice"><%= cab.getCab_Booking_Price() %></p>
                    <p class="drivername"><%= cab.getDriver_Name() %></p>
                    <p class="drivertelephonenumber"><%= cab.getDriver_Telephone_Number() %></p>
                    <p class="cabavailability"><%= cab.getCab_Status() %></p>
                    <c:choose>
    				  <c:when test="${not empty Customer_Full_Name && not empty Customer_ID}">
        				<a href="BookCab.jsp?Cab_ID=<%= cab.getCab_ID() %>">
            			  <button class='read-more-button' style="<%= cab.getCab_Status().equals("Not Available") ? "cursor: not-allowed; opacity: 0.3;" : "" %>" 
                			<%= cab.getCab_Status().equals("Not Available") ? "disabled" : "" %>>Book Cab
            			  </button>
        				</a>
    				  </c:when>
					</c:choose>
                  </div>
                <% } %>
                </div>
              
          </section>
        </div>
      </div>

      <footer class="footer">
        <div class="footer__copy">© 2025 MEGA CITY CABS. All rights reserved.</div>
      </footer>
    </div>
  </body>
</html>