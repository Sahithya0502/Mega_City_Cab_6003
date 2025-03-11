<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("Login.jsp"); // Redirect if session is missing
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Bookings</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

  /* Global Styles */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
  }
  body {
    display: flex;
    min-height: 100vh;
    background: #eef2f7;
    color: #333;
  }

  /* Sidebar Styles */
  .sidebar {
    width: 300px;
    background-color: #2a3f54;
    color: #ffffff;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 30px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  }
  .sidebar h2 {
    font-size: 1.8rem;
    font-weight: 600;
    margin-bottom: 30px;
    color: #f9a825;
    text-align: left;
    padding-left: 30px;
    padding-right: 30px;
  }
  .menu-item {
    width: 80%;
    padding: 12px 20px;
    margin: 10px 0;
    text-align: center;
    font-size: 1rem;
    font-weight: 500;
    color: #ffffff;
    background: #4caf50;
    border-radius: 5px;
    text-decoration: none;
    transition: background 0.3s ease, transform 0.2s ease;
  }
  .menu-item:hover {
    background: #388e3c;
    transform: translateY(-2px);
  }
  .menu-item.logout {
    background: #e53935;
  }
  .menu-item.logout:hover {
    background: #c62828;
  }

  /* Main Content Styles */
  .content {
    flex: 1;
    padding: 50px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
  .content h1 {
    font-size: 2.5rem;
    font-weight: 600;
    color: #2a3f54;
    margin-bottom: 20px;
  }
  .content p {
    font-size: 1.2rem;
    color: #555;
    margin-bottom: 40px;
    max-width: 600px;
    line-height: 1.6;
  }

  /* Button Grid Styles */
  .button-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    width: 100%;
    max-width: 800px;
  }
  .button-grid a {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    font-size: 1.2rem;
    font-weight: 500;
    color: #ffffff;
    text-decoration: none;
    border-radius: 8px;
    background: #4a90e2;
    transition: background 0.3s ease, transform 0.2s ease;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  .button-grid a:hover {
    background: #357ab8;
    transform: translateY(-3px);
  }
</style>
<script>
  function confirmLogout() {
    const isConfirmed = confirm("Are you sure you want to logout?");
    if (isConfirmed) {
      window.location.href = "AdminLogout.jsp"; // Call the logout script
    }
  }
</script>
</head>

<body>
  <aside class="sidebar">
    <h2>Manage Blogs</h2>
    <a href="AdminDashboard.jsp" class="menu-item">Dashboard</a>
    <a href="EnterHireCharge.jsp" class="menu-item">Enter Hire Charge</a>
    <a href="FinishJourney.jsp" class="menu-item">Finish Journey</a>
    <a href="ViewCabBookings.jsp" class="menu-item">View Cab Bookings</a>
    <div class="menu-item logout" onclick="confirmLogout()">Logout</div>
  </aside>

  <main class="content">
    <h1>Manage Your Bookings</h1>
    
    <div class="button-grid">
      <a href="EnterHireCharge.jsp">Enter Hire Charge</a>
      <a href="FinishJourney.jsp">Finish Journey</a>
      <a href="ViewCabBookings.jsp">View Cab Bookings</a>
    </div>
  </main>
</body>
</html>