<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css" />
    <title>Book Cab</title>
    <style>
  /* Reset styles */
  .form-container1 {
  display: flex;
  justify-content: center; /* Centers horizontally */
  align-items: center; /* Centers vertically */
  margin-top: 200px;
  margin-bottom: 170px;
}

.form-container2 {
  display: flex;
  justify-content: center; /* Centers horizontally */
  align-items: center;
  width: 100%; /* Ensures full width for centering */
}


  .form-container {
    width: 90%;
    max-width: 600px;
    background: #ffffff;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
  }

  .form-header {
    text-align: center;
    font-size: 26px;
    font-weight: bold;
    color: #333;
    margin-bottom: 25px;
  }

  .form-row {
    margin-bottom: 20px;
  }

  .form-label {
    font-size: 14px;
    font-weight: bold;
    color: #555;
    margin-bottom: 8px;
    display: block;
  }

  .form-input, .form-file, .textareaContent {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    transition: border-color 0.3s ease;
    background: #f9f9f9;
  }

  .form-input:focus, .form-file:focus, .textareaContent:focus {
    border-color: #f6d365;
    background: #fff;
  }

  .textareaContent {
    height: 200px;
    resize: vertical;
  }

  .button-group {
    display: flex;
    gap: 15px;
    justify-content: space-between;
  }

  .btn {
    flex: 1;
    padding: 12px;
    font-size: 14px;
    font-weight: bold;
    color: #fff;
    background: linear-gradient(120deg, #fda085, #f6d365);
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
    text-align: center;
  }

  .btn:hover {
    background: linear-gradient(120deg, #f6d365, #fda085);
  }

  .btn-reset {
    background: linear-gradient(120deg, #ee4266, #ff7b54);
  }

  .btn-reset:hover {
    background: linear-gradient(120deg, #ff7b54, #ee4266);
  }

  @media (max-width: 500px) {
    .form-container {
      padding: 20px;
    }
  }
</style>
    
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
          <h1 class="logo">MEGA CITY CABS</h1>
        </div>
        <div class="menu-container">
          <ul class="menu-list">
            <li class="menu-list-item"><menu><a class="link-stylings" href="Home.jsp">HOME</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Cabs.jsp">CABS</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Help.jsp">HELP</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="AboutUs.jsp">ABOUT US</a></menu> </li>
            <form action="" method="GET" class="menu-list-item-search-bar-main">
              <li class="menu-list-item-search-bar-main"> <menu> <input type="text" name="search"  class="menu-list-item-search-bar" placeholder="Search" > </menu> </li>
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
<div class="form-container1">
<div class="form-container2">
<div class="form-container">
  <h1 class="form-header">BOOK CAB</h1>
  <form action="addBooking" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
    <%
    // Get the Cab_ID from the request
    String cabIdParam = request.getParameter("Cab_ID");
    Cab cab = null;

    if (cabIdParam != null && !cabIdParam.isEmpty()) {
        try {
            int cabId = Integer.parseInt(cabIdParam);
            cab = CabService.getCabById(cabId); // Fetch cab details for the selected ID
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>Invalid Cab ID provided.</p>");
        }
    } else {
        out.println("<p style='color:red;'>No Cab ID provided.</p>");
    }
	%>
	<% if (cab != null) { %>
    <img class="plan-image" src="data:image/jpeg;base64,<%= cab.getCabImageBase64() %>" alt="Plan Image" />
    
    <div class="form-row" style="display: none;">
      <label class="form-label" for="CabID">Cab ID</label>
      <input type="text" class="form-input" name="CabID" value="<%= cab.getCab_ID() %>" readonly="readonly" />
    </div>
    
    <div class="form-row" style="display: none;">
      <label class="form-label" for="CustomerID">Customer ID</label>
      <input type="text" class="form-input" name="CustomerID" value="${Customer_ID}" readonly="readonly" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabName">Cab Name</label>
      <input type="text" class="form-input" name="CabName" value="<%= cab.getCab_Name() %>" readonly="readonly" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabBookingPrice">Cab Booking Price</label>
      <input type="number" class="form-input" name="CabBookingPrice" value="<%= cab.getCab_Booking_Price() %>" readonly="readonly" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CustomerCurrentLocation">Your Current Location</label>
      <input type="text" class="form-input" name="CustomerCurrentLocation" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CustomerDestination">Your Destination</label>
      <input type="text" class="form-input" name="CustomerDestination" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="HireCharge">Your Hire Charge</label>
      <input type="text" class="form-input" name="HireCharge" value="It will be Informed Soon" required readonly="readonly"/>
    </div>
    
    <div class="form-row">
      <label class="form-label" for="TotalPayableAmount">Your Total Payable Amount</label>
      <input type="text" class="form-input" name="TotalPayableAmount" value="It will be Informed Soon" required readonly="readonly"/>
    </div>
    
    <div class="button-group">
      <button type="submit" name="submit" class="btn">Confirm Book Cab</button>
      <button type="reset" class="btn btn-reset">Reset</button>
    </div>
    <% } else { %>
    <p style="color:red;">Cab details could not be retrieved.</p>
	<% } %>
  </form>
</div>
</div>
</div>

      <footer class="footer">
        <div class="footer__copy">© 2025 MEGA CITY CABS. All rights reserved.</div>
      </footer>
    </div>
  </body>
</html>