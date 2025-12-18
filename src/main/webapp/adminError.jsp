<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* Base */
body {
    margin: 0;
    padding: 0;
    font-family: 'Roboto', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: linear-gradient(135deg, #ffcccc, #ffe6e6);
}

/* Error Container */
.error-container {
    text-align: center;
    background: #ffffff;
    padding: 50px 40px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    max-width: 500px;
    animation: fadeIn 1s ease-in-out;
    position: relative;
}

/* Error Icon */
.error-container i {
    font-size: 80px;
    color: #ff4d4d;
    margin-bottom: 20px;
    animation: shake 0.8s infinite;
}

/* Error Heading */
.error-container h1 {
    font-size: 32px;
    color: #cc0000;
    margin-bottom: 20px;
}

/* Home Button */
.error-container a {
    text-decoration: none;
    display: inline-block;
    background: #cc0000;
    color: #fff;
    padding: 12px 30px;
    border-radius: 8px;
    font-weight: 700;
    transition: background 0.3s, transform 0.3s;
}

.error-container a:hover {
    background: #ff4d4d;
    transform: scale(1.05);
}

/* Animations */
@keyframes fadeIn {
    0% { opacity: 0; transform: translateY(-30px); }
    100% { opacity: 1; transform: translateY(0); }
}

@keyframes shake {
    0%, 100% { transform: rotate(0deg); }
    25% { transform: rotate(-5deg); }
    50% { transform: rotate(5deg); }
    75% { transform: rotate(-5deg); }
}

/* Responsive */
@media(max-width: 600px) {
    .error-container {
        padding: 40px 20px;
    }

    .error-container h1 {
        font-size: 26px;
    }

    .error-container i {
        font-size: 60px;
    }

    .error-container a {
        padding: 10px 25px;
        font-size: 16px;
    }
}
</style>
</head>
<body>

<div class="error-container">
    <i class="fas fa-exclamation-triangle"></i>
    <h1>Error in Updation!</h1>
    <p>Oops! Something went wrong while updating the data.</p>
    <a href="adminDashboard.jsp">Go to Home Page</a>
</div>

</body>
</html>
