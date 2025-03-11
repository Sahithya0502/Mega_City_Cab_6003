<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Booking" %>
<%@ page import="Models.Cab" %>
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
<title>Finalize Hire Charge</title>
<style>
  /* Reset styles */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(120deg, #f6d365, #fda085);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    min-height: 100vh;
    overflow-y: auto; /* Enable scrolling for the body */
    padding: 20px; /* Add padding for smaller screens */
    color: #444;
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
<script>
    	function calculateTotal() {
        	// Get the product price and preferred quantity by using ClientID
        	const cabBookingPrice = parseFloat(document.getElementById('txtCarBookingPrice').value);
        	const hireCharge = parseFloat(document.getElementById('txtHireCharge').value);
        	// Calculate the total amount
        	const totalAmount = cabBookingPrice + hireCharge;
        	// Set the total amount in the total payable amount input field
        	document.getElementById('txtTotalPayableAmount').value = totalAmount;

        	if (isNaN(hireCharge) || hireCharge < 1) {
            	hireCharge = 1;
            	document.getElementById('txtHireCharge').value = hireCharge;
        	}
    	}
    	window.onload = function () {
        	// Initialize the total calculation on page load
        	const quantityInput = document.getElementById('txtHireCharge');
        	quantityInput.value = 1;
        	calculateTotal();
        	// Get the quantity input field and attach both 'input' and 'change' event listeners
        	quantityInput.addEventListener('input', calculateTotal);
        	quantityInput.addEventListener('change', calculateTotal);
    	};
	</script>
</head>
<body>

<div class="form-container">
  <h1 class="form-header">Finalize Hire Charge</h1>
  <form action="updateHCandTPA" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
    
    <%
    // Get the Cab_ID from the request
    String bookingIdParam = request.getParameter("Booking_ID");
    Booking booking = null;

    if (bookingIdParam != null && !bookingIdParam.isEmpty()) {
        try {
            int bookingId = Integer.parseInt(bookingIdParam);
            booking = BookingService.getBookingById(bookingId); // Fetch cab details for the selected ID
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>Invalid Booking ID provided.</p>");
        }
    } else {
        out.println("<p style='color:red;'>No Booking ID provided.</p>");
    }
	%>
	<% if (booking != null) { %>
    <div class="form-row">
      <label class="form-label" for="BookingID">Booking ID</label>
      <input type="text" class="form-input" name="BookingID" value="<%= booking.getBooking_ID() %>" />
    </div>

    <div class="form-row">
      <label class="form-label" for="CabID">Cab ID</label>
      <input type="text" class="form-input" name="CabID" value="<%= booking.getCab_ID() %>"></input>
    </div>

    <div class="form-row">
      <label class="form-label" for="CustomerID">Customer ID</label>
      <input type="text" class="form-input" name="CustomerID" value="<%= booking.getCustomer_ID() %>" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CustomerCurrentLocation">Customer Current Location</label>
      <input type="text" class="form-input" name="CustomerCurrentLocation" value="<%= booking.getCustomer_Current_Location() %>" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CustomerDestination">Customer Destination</label>
      <input type="text" class="form-input" name="CustomerDestination" value="<%= booking.getCustomer_Destination() %>" />
    </div>

    <div class="form-row">
      <label class="form-label" for="BookedDate">Booked Date</label>
      <input type="text" class="form-input" name="BookedDate" value="<%= booking.getBooked_Date() %>" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="BookedTime">Booked Time</label>
      <input type="text" class="form-input" name="BookedTime" value="<%= booking.getBooked_Time() %>" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabBookingPrice">Cab Booking Price</label>
      <input type="number" class="form-input" name="CabBookingPrice" id="txtCarBookingPrice" value="<%= booking.getCab().getCab_Booking_Price() %>" readonly="readonly" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="HireCharge">Enter Hire Charge</label>
      <input type="number" class="form-input" name="HireCharge" id="txtHireCharge" onchange="calculateTotal()" min="1" required/>
    </div>
    
    <div class="form-row">
      <label class="form-label" for="TotalPayableAmount">Total Payable Amount is</label>
      <input type="number" class="form-input" name="TotalPayableAmount" id="txtTotalPayableAmount" required readonly="readonly"/>
    </div>
    
    <div class="button-group">
      <button type="submit" name="submit" class="btn">Finalize Hire Charge</button>
      <button type="reset" class="btn btn-reset">Reset</button>
    </div>
    <% } else { %>
    <p style="color:red;">Booking details could not be retrieved.</p>
	<% } %>
  </form>
</div>

</body>
</html>