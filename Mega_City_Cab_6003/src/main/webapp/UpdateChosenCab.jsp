<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Cab" %>
<%@ page import="Models.Cab" %>
<%@ page import="Services.CabService" %>
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
<title>Update CHosen Cab</title>
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
        	const cabCabPrice = parseFloat(document.getElementById('txtCarCabPrice').value);
        	const hireCharge = parseFloat(document.getElementById('txtHireCharge').value);
        	// Calculate the total amount
        	const totalAmount = cabCabPrice + hireCharge;
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
  <h1 class="form-header">Update Chosen Cab</h1>
  <form action="UpdateCab" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
    
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
    <div class="form-row">
      <label class="form-label" for="CabID">Cab ID</label>
      <input type="text" class="form-input" name="CabID" value="<%= cab.getCab_ID() %>" readonly="readonly"/>
    </div>

    <div class="form-row">
      <label class="form-label" for="CabID">Cab Name</label>
      <input type="text" class="form-input" name="CabName" value="<%= cab.getCab_Name() %>"></input>
    </div>

    <div class="form-row">
      <label class="form-label" for="CabBrand">Cab Brand</label>
      <input type="text" class="form-input" name="CabBrand" value="<%= cab.getCab_Brand() %>" required></input>
    </div>

    <div class="form-row">
      <label class="form-label" for="CabNumberPlate">Cab Number Plate</label>
      <input type="text" class="form-input" name="CabNumberPlate" value="<%= cab.getCab_Number_Plate() %>" required />
    </div>

    <div class="form-row">
      <label class="form-label" for="CabColour">Cab Colour</label>
      <input type="text" class="form-input" name="CabColour" value="<%= cab.getCab_Colour() %>" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabImage">Cab Image</label>
      <input type="file" class="form-file" name="CabImage" value="<%= cab.getCab_Image() %>" />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabBookingPrice">Cab Booking Price</label>
      <input type="number" class="form-input" name="CabBookingPrice" value="<%= cab.getCab_Booking_Price() %>" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="DriverName">Driver Name</label>
      <input type="text" class="form-input" name="DriverName" value="<%= cab.getDriver_Name() %>" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="DriverTelephoneNumber">Driver Telephone Number</label>
      <input type="text" class="form-input" name="DriverTelephoneNumber" value="<%= cab.getDriver_Telephone_Number() %>" required />
    </div>
    
    <div class="button-group">
      <button type="submit" name="submit" class="btn">Update Chosen Cab</button>
      <button type="reset" class="btn btn-reset">Reset</button>
    </div>
    
    <% } else { %>
    <p style="color:red;">Cab details could not be retrieved.</p>
	<% } %>
  </form>
</div>

</body>
</html>