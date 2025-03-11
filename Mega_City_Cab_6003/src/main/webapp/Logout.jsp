<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
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
    <!-- The logout link that triggers the JavaScript confirmation -->
    <div class="menu-item">
        <a href="javascript:void(0);" onclick="confirmLogout()">LOGOUT</a>
    </div>

    <!-- Add your other content here -->

</body>
</html>