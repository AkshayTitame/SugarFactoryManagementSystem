<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Error - Update Failed</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/4b5f6a5b7b.js" crossorigin="anonymous"></script>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #ff4e50, #f9d423);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #333;
    }

    .error-container {
        background: #fff;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        text-align: center;
        max-width: 500px;
        animation: fadeIn 1s ease-in-out;
    }

    .error-icon {
        font-size: 80px;
        color: #ff4e50;
        margin-bottom: 20px;
        animation: bounce 1.5s infinite;
    }

    h1 {
        font-size: 28px;
        color: #444;
        margin-bottom: 10px;
    }

    p {
        font-size: 16px;
        color: #666;
        margin-bottom: 25px;
    }

    .btn {
        display: inline-block;
        padding: 12px 24px;
        background: #ff4e50;
        color: #fff;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn:hover {
        background: #e03e3e;
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-8px); }
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
    }
</style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-times-circle error-icon"></i>
        <h1>Oops! Update Failed</h1>
        <p>Something went wrong while updating your request.<br>
        Please try again or contact support if the problem persists.</p>
        <a href="gatOfficerDashboard.jsp" class="btn"><i class="fas fa-home"></i> Go to Home</a>
    </div>
</body>
</html>
