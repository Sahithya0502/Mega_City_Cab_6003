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
<title>Admin Dashboard</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Roboto', sans-serif;
  }
  body {
    height: 100vh;
    display: flex;
    background: #f5f7fa;
    color: #333;
  }
  .sidebar {
    width: 250px;
    background-color: #344955;
    color: #fff;
    display: flex;
    flex-direction: column;
    padding: 20px 15px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
  }
  .sidebar h2 {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    text-align: center;
    color: #f9aa33;
  }
  .menu-item {
    font-size: 16px;
    color: #ffffff;
    padding: 12px 15px;
    margin-bottom: 12px;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
  }
  .menu-item:hover {
    background-color: #f9aa33;
  }
  .logout-btn {
    font-size: 16px;
    margin-top: auto;
    padding: 12px 15px;
    background-color: #f44336;
    color: #fff;
    text-align: center;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    cursor: pointer;
  }
  .logout-btn:hover {
    background-color: #d32f2f;
  }
  .content {
    flex: 1;
    padding: 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
  }
  .content h1 {
    font-size: 36px;
    font-weight: 700;
    margin-bottom: 15px;
    color: #344955;
  }
  .content p {
    font-size: 18px;
    color: #666;
    max-width: 600px;
    line-height: 1.6;
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
    <h2>Admin Dashboard</h2>
    <a href="ManageCabs.jsp" class="menu-item">Manage Cabs</a>
    <a href="ManageBookings.jsp" class="menu-item">Manage Bookings</a>
    <div class="logout-btn" onclick="confirmLogout()">Logout</div>
  </aside>

  <main class="content">
    <h1>Welcome, Admin!</h1>
    <p>To easily handle the important areas of your admin dashboard, utilise the sidebar. To guarantee that your consumers have a seamless expertise, maintain the whole thing organised.</p>
  </main>
</body>
</html>