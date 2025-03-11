<%@ page session="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
</head>
<body>
    <%
        // Destroy the session
        session.invalidate();
    %>

    <!-- Optional redirect to the login page or another page -->
    <script type="text/javascript">
        // Redirect to the login page after logging out
        alert("You just logged out.");
        window.location.href = "Home.jsp";
    </script>
</body>
</html>
