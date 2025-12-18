<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Successful</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
:root {
    --brand-primary: #2e7d32;
    --brand-accent: #81c784;
}

body {
    font-family: 'Segoe UI', 'Roboto', sans-serif;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
    background: linear-gradient(135deg, #f5f7fa, #e4e9f0); /* modern neutral background */
}

.card-success {
    background: #ffffff;
    padding: 40px;
    border-radius: 20px;
    width: 100%;
    max-width: 480px;
    box-shadow: 0 12px 25px rgba(0,0,0,0.15);
    text-align: center;
    animation: fadeIn 0.7s ease-in-out;
}

.card-success i {
    font-size: 70px;
    color: var(--brand-primary);
    margin-bottom: 20px;
}

.card-success h2 {
    font-weight: 600;
    margin-bottom: 15px;
    color: var(--brand-primary);
}

.card-success p {
    font-size: 16px;
    margin-bottom: 25px;
    color: #555;
}

.btn-home {
    background: var(--brand-primary);
    color: #fff;
    font-weight: 500;
    padding: 8px 16px;      /* smaller padding */
    font-size: 14px;        /* smaller font */
    border-radius: 8px;     /* slightly smaller radius */
    border: none;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 4px;               /* smaller gap between icon & text */
    transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
}

.btn-home:hover {
    background: #388e3c;
    transform: scale(1.05); /* subtle hover scale */
    box-shadow: 0 3px 8px rgba(0,0,0,0.15); /* lighter shadow */
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-15px); }
    to { opacity: 1; transform: translateY(0); }
}

@media (max-width: 576px) {
    .card-success { padding: 25px; margin: 15px; }
    .card-success i { font-size: 60px; }
    .card-success p { font-size: 15px; }
}
</style>
</head>
<body>

<div class="card-success">
    <i class="bi bi-check-circle-fill"></i>
    <h2>Registration Successful!</h2>
    <p>Congratulations 🎉 Your Farmer account has been created successfully.</p>
    <a href="login.jsp" class="btn-home" role="button">
        <i class="bi bi-box-arrow-in-right"></i> Go to Login
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
