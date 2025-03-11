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
    <link rel="stylesheet" href="CabStyles2.css" />
    <link rel="stylesheet" href="CabStyles3.css" />
    <title>About Us</title>
    
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
      <h1 style="margin-top: 140px; text-align: center; color: #ff5733; font-size: 40px;">ABOUT US</h1>

      <section class="us_section layout_padding">
        <div class="container">
          <div class="heading_container">
            <h2>
              Why Choose Us
            </h2>
          </div>
        
          <div class="us_container ">
            <div class="row">
              <div class="col-lg-3 col-md-6">
                <div class="box">
                  <div class="img-box">
                    <img src="img/ab1.png" alt="">
                  </div>
                  <div class="detail-box">
                    <h5>
                      1. Reliable & Punctual Service – Always On Time, Every Time
                    </h5>
                    <p>
                      Time is precious, and at MEGA CITY CABS, we respect yours. Our commitment to punctuality ensures that you never have to worry about late arrivals or missed appointments. Whether you are heading to a business meeting, catching a flight, or simply commuting to work, our drivers ensure that you arrive at your destination on time and stress-free.
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-lg-3 col-md-6">
                <div class="box">
                  <div class="img-box">
                    <img src="img/ab2.png" alt="">
                  </div>
                  <div class="detail-box">
                    <h5>
                      2. Affordable & Transparent Pricing – No Hidden Charges
                    </h5>
                    <p>
                      At MEGA CITY CABS, we believe in fair pricing and complete transparency. Our cab fares are designed to be affordable while maintaining high-quality service standards. We understand that unexpected or inflated pricing can be frustrating, so we ensure that our fare structure is clear, competitive, and free from hidden charges.
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-lg-3 col-md-6">
                <div class="box">
                  <div class="img-box">
                    <img src="img/ab3.png" alt="">
                  </div>
                  <div class="detail-box">
                    <h5>
                      3. Safety & Comfort – Your Security is Our Priority
                    </h5>
                    <p>
                      When you travel with MEGA CITY CABS, your safety and comfort are our top priorities. We understand that passengers need a secure and stress-free ride experience, which is why we have implemented strict safety measures to ensure peace of mind for every journey.
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-lg-3 col-md-6">
                <div class="box">
                  <div class="img-box">
                    <img src="img/ab4.png" alt="">
                  </div>
                  <div class="detail-box">
                    <h5>
                      4. Easy & Convenient Booking – Seamless Ride Experience
                    </h5>
                    <p>
                      We know that booking a cab should be simple and hassle-free. That’s why MEGA CITY CABS offers a user-friendly, fast, and efficient cab booking system that allows you to book a ride within seconds! Whether you prefer booking through our website or mobile app, the process is designed to be quick and convenient.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="heathy_section layout_padding">
        <div class="container">

          <div class="row">
            <div class="col-md-12 mx-auto">
              <div class="detail-box">
                <h2>
                  Conclusion: Experience the Best with MEGA CITY CABS!
                </h2>
                <p>
                  t MEGA CITY CABS, we are committed to providing a seamless, reliable, and convenient cab booking experience for all our customers. Whether you need a ride for daily commutes, airport transfers, or special occasions, we ensure a safe, comfortable, and hassle-free journey every time. At MEGA CITY CABS, we are dedicated to providing a superior cab booking experience that prioritizes punctuality, affordability, safety, and convenience. Our commitment to excellence has made us a trusted transportation partner for thousands of customers, and we continue to improve our services every day. 🌟 Choose MEGA CITY CABS for a ride that is reliable, safe, affordable, and hassle-free! 🌟
                </p>
                <div class="btn-box">
                  <a href="">
                    READ MORE
                  </a>
                </div>
              </div>
            </div>
          </div>

        </div>
      </section>

      <footer class="footer">
        <div class="footer__copy">© 2025 MEGA CITY CABS. All rights reserved.</div>
      </footer>
    </div>
  </body>
</html>