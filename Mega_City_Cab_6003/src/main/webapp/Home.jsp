<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Home</title>
    <style type="text/css">
    /* 🚖 Why Choose Us Section */
.why-choose-us {
  text-align: center;
  padding: 50px 20px;
}

.features-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

.feature {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 10px;
  width: 250px;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.feature i {
  font-size: 40px;
  color: #ff9800;
  margin-bottom: 10px;
}

/* 🚖 Popular Cabs Section */
.popular-cabs {
  text-align: center;
  padding: 50px 20px;
}

.cab-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

.cab-card {
  background: #fff;
  padding: 20px;
  border-radius: 10px;
  width: 250px;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.cab-card img {
  width: 100%;
  border-radius: 10px;
}

.cab-card h3 {
  margin-top: 10px;
}

/* 🚖 How It Works Section */
.how-it-works {
  text-align: center;
  padding: 50px 20px;
}

.steps-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

.step {
  background: #f1f1f1;
  padding: 20px;
  border-radius: 10px;
  width: 250px;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.step i {
  font-size: 40px;
  color: #2196F3;
  margin-bottom: 10px;
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
            <form action="Cabs.jsp" method="GET" class="menu-list-item-search-bar-main">
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
      <div class="division1">
        <div class="section__container header__container" id="home">
          <div class="header__image">
            <img src="img/cabshome1.png" alt="header" />
          </div>
          <div class="header__content">
            <h2>BOOK CABS AT YOUR OWN WILL</h2>
            <h1>MEGA CITY CABS<br /><span>IS YOUR JOURNEY</span></h1>
          </div>
        </div>
      </div>
      
      <section class="why-choose-us">
  <h2>Why Choose Mega City Cabs?</h2>
  <div class="features-container">
    <div class="feature">
      <i class="fas fa-clock"></i>
      <h3>24/7 Availability</h3>
      <p>Book a cab anytime, anywhere with our round-the-clock service.</p>
    </div>
    <div class="feature">
      <i class="fas fa-shield-alt"></i>
      <h3>Safe & Secure</h3>
      <p>Our drivers are verified, and safety is our priority.</p>
    </div>
    <div class="feature">
      <i class="fas fa-money-bill-wave"></i>
      <h3>Affordable Pricing</h3>
      <p>Get the best rates for your rides with no hidden charges.</p>
    </div>
  </div>
</section>

<!-- 🚖 Popular Cabs Section -->
<section class="popular-cabs">
  <h2>Popular Cab Services</h2>
  <div class="cab-container">
    <div class="cab-card">
      <img src="img/economycab.png" alt="Economy Cab">
      <h3>Economy Cabs</h3>
      <p>Affordable rides for everyday travel.</p>
    </div>
    <div class="cab-card">
      <img src="img/luxurycab.png" alt="Luxury Cab">
      <h3>Luxury Cabs</h3>
      <p>Travel in style with premium cars.</p>
    </div>
    <div class="cab-card">
      <img src="img/suvcab.png" alt="SUV Cab">
      <h3>SUV Cabs</h3>
      <p>Spacious rides for family and group trips.</p>
    </div>
  </div>
</section>

<!-- 🚖 How It Works Section -->
<section class="how-it-works">
  <h2>How It Works</h2>
  <div class="steps-container">
    <div class="step">
      <i class="fas fa-mobile-alt"></i>
      <h3>1. Book Online</h3>
      <p>Enter your location and destination to book a cab instantly.</p>
    </div>
    <div class="step">
      <i class="fas fa-taxi"></i>
      <h3>2. Choose Your Ride</h3>
      <p>Select from a variety of cars that fit your needs.</p>
    </div>
    <div class="step">
      <i class="fas fa-map-marked-alt"></i>
      <h3>3. Enjoy Your Ride</h3>
      <p>Relax and reach your destination safely.</p>
    </div>
  </div>
</section>

      <footer class="footer">
        <div class="footer__copy">© 2025 MEGA CITY CABS. All rights reserved.</div>
      </footer>
    </div>
  </body>
</html>