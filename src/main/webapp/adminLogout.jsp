<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Logout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap for modern styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .logout-box {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        .logout-box h2 {
            color: #007bff;
            margin-bottom: 15px;
        }
        .logout-box p {
            font-size: 16px;
            margin-bottom: 10px;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-20px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>

<%
    // Prevent cache (security best practice after logout)
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma","no-cache"); 
    response.setDateHeader ("Expires", 0);

    HttpSession session2 = request.getSession(false);
    if (session2 != null) {
        session2.invalidate();
    }
%>

<div class="logout-box">
    <h2>👋 You have logged out successfully!</h2>
    <p>Redirecting to homepage in <span id="countdown">5</span> seconds...</p>
    <a href="index.html" class="btn btn-primary mt-3">Go to Homepage Now</a>
</div>

<script>
    // Countdown auto redirect
    let seconds = 5;
    let countdown = document.getElementById("countdown");
    let interval = setInterval(() => {
        seconds--;
        countdown.textContent = seconds;
        if (seconds <= 0) {
            clearInterval(interval);
            window.location.href = "index.html";
        }
    }, 1000);
</script>

</body>
</html>
