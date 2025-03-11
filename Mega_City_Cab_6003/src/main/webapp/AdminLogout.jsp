<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession != null) {
        adminSession.invalidate(); // Destroy session
    }
%>

<script type="text/javascript">
    alert("You just logged out.");  // Show the alert first
    window.location.href = "Home.jsp"; // Redirect after clicking "OK"
</script>