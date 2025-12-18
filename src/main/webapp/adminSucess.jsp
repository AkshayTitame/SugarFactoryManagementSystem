<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Success</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .success-box {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        .success-icon {
            font-size: 70px;
            color: #28a745;
            margin-bottom: 15px;
            animation: bounce 1.2s infinite;
        }
        .success-box h2 {
            color: #28a745;
            margin-bottom: 10px;
        }
        .success-box p {
            font-size: 16px;
            margin-bottom: 20px;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-20px);}
            to {opacity: 1; transform: translateY(0);}
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>

<%
    HttpSession session2 = request.getSession(false);
    String role = null;
    if (session2 != null) {
        role = (String) session2.getAttribute("role");  // Assume "role" is set at login
    }

    String redirectPage = "index.html"; // Default
    if ("ADMIN".equalsIgnoreCase(role)) {
        redirectPage = "adminDashboard.jsp";
    } else if ("USER".equalsIgnoreCase(role)) {
        redirectPage = "userDashboard.jsp";
    }
%>

<div class="success-box">
    <i class="bi bi-check-circle-fill success-icon"></i>
    <h2>✅ Changes Saved Successfully!</h2>
    <p>Your updates have been applied successfully.</p>
    <p>Redirecting to your dashboard in <span id="countdown">5</span> seconds...</p>

    <div class="d-flex justify-content-center gap-3 mt-3">
        <a href="<%= redirectPage %>" class="btn btn-primary">🏠 Go to Dashboard</a>
        <a href="addChanges.jsp" class="btn btn-success">➕ Add More</a>
        <a href="logout.jsp" class="btn btn-danger">🚪 Logout</a>
    </div>
</div>

<script>
    // Countdown for auto-redirect
    let seconds = 5;
    let countdown = document.getElementById("countdown");
    let interval = setInterval(() => {
        seconds--;
        countdown.textContent = seconds;
        if (seconds <= 0) {
            clearInterval(interval);
            window.location.href = "<%= redirectPage %>";
        }
    }, 1000);
</script>

</body>
</html>
