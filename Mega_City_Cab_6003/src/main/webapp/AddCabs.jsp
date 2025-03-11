<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Add Cab</title>
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
</head>
<body>

<div class="form-container">
  <h1 class="form-header">Add Cab</h1>
  <form action="addCab" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
    
    <div class="form-row">
      <label class="form-label" for="CabName">Cab Name</label>
      <input type="text" class="form-input" name="CabName" required />
    </div>

    <div class="form-row">
      <label class="form-label" for="CabBrand">Cab Brand</label>
      <input type="text" class="form-input" name="CabBrand" required></input>
    </div>

    <div class="form-row">
      <label class="form-label" for="CabNumberPlate">Cab Number Plate</label>
      <input type="text" class="form-input" name="CabNumberPlate" required />
    </div>

    <div class="form-row">
      <label class="form-label" for="CabColour">Cab Colour</label>
      <input type="text" class="form-input" name="CabColour" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabImage">Cab Image</label>
      <input type="file" class="form-file" name="CabImage" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="CabBookingPrice">Cab Booking Price</label>
      <input type="number" class="form-input" name="CabBookingPrice" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="DriverName">Driver Name</label>
      <input type="text" class="form-input" name="DriverName" required />
    </div>
    
    <div class="form-row">
      <label class="form-label" for="DriverTelephoneNumber">Driver Telephone Number</label>
      <input type="text" class="form-input" name="DriverTelephoneNumber" required />
    </div>
    
    <div class="button-group">
      <button type="submit" name="submit" class="btn">Add Cab</button>
      <button type="reset" class="btn btn-reset">Reset</button>
    </div>
    
  </form>
</div>

</body>
</html>