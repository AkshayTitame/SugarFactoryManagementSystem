<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Farmer Dashboard</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
:root {
    --primary: #2e7d32;
    --secondary: #f4511e;
    --danger: #e53935;
    --text: #333;
    --bg-light: #f9fafb;
    --bg-white: #fff;
    --radius: 14px;
    --shadow: 0 6px 20px rgba(0,0,0,0.08);
    --hover-light: rgba(46,125,50,0.02); /* ultra-subtle hover */
}

* {margin:0; padding:0; box-sizing:border-box;}
body {
    font-family: 'Inter', sans-serif;
    background: var(--bg-light);
    color: var(--text);
}

/* Navbar */
.navbar {
    background: var(--primary);
    padding: 14px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.navbar .brand {
    font-weight: 700;
    font-size: 20px;
    color: #fff;
    display: flex;
    align-items: center;
}
.navbar .brand i { margin-right: 6px; }
.navbar .right a {
    color: #fff;
    font-weight: 500;
    text-decoration: none;
    margin-left: 20px;
}
.navbar .right a:hover { opacity: 0.85; }

/* Welcome */
.welcome-msg {
    text-align: center;
    margin: 30px 0 10px;
    font-size: 24px;
    font-weight: 700;
}

/* Dashboard Grid */
.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 25px;
    max-width: 1100px;
    margin: 0 auto 50px;
    padding: 0 15px;
}

/* Dashboard Cards */
.card-btn {
    background: var(--bg-white);
    border-radius: var(--radius);
    padding: 28px 20px;
    text-align: center;
    color: var(--text);
    font-weight: 600;
    font-size: 18px;
    box-shadow: var(--shadow);
    transition: all 0.25s ease-in-out;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}
.card-btn i {
    font-size: 40px;
    margin-bottom: 12px;
    color: var(--primary);
    transition: color 0.25s ease-in-out;
}
.card-btn div { transition: color 0.25s ease-in-out; }

/* Subtle Hover Effect Inspired by Stripe / Notion */
.card-btn::after {
    content: '';
    position: absolute;
    top:0; left:0; right:0; bottom:0;
    background: var(--hover-light);
    opacity: 0;
    transition: opacity 0.25s ease-in-out;
    border-radius: var(--radius);
}
.card-btn:hover::after { opacity: 1; }

/* Hover icon/text color slightly darker */
.card-btn:hover i,
.card-btn:hover div { color: var(--primary); }

/* Secondary / Danger Cards */
.card-btn.secondary i { color: var(--secondary); }
.card-btn.secondary:hover div { color: var(--secondary); }
.card-btn.danger i { color: var(--danger); }
.card-btn.danger:hover div { color: var(--danger); }

</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
  <div class="brand"><i class="bi bi-tree-fill"></i> Farmer Portal</div>
  <div class="right">
    <a href="#"><i class="bi bi-person-circle"></i> Profile</a>
    <a href="index.html"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>
</div>

<!-- Welcome -->
<div class="welcome-msg">Welcome to your Farmer Dashboard 🌱</div>

<!-- Dashboard Grid -->
<div class="dashboard-grid">
    <div class="card-btn" onclick="window.location.href='caneRegistration.jsp';">
        <i class="bi bi-pencil-square"></i>
        <div>Register Cane Farm</div>
    </div>

    <div class="card-btn secondary" onclick="window.location.href='candidateApproval.jsp';">
        <i class="bi bi-award"></i>
        <div>Get Certificate</div>
    </div>

    <div class="card-btn" onclick="window.location.href='farmerViewWeight.jsp';">
        <i class="bi bi-speedometer2"></i>
        <div>Check Weight</div>
    </div>

    <div class="card-btn danger" onclick="window.location.href='help.jsp';">
        <i class="bi bi-life-preserver"></i>
        <div>Support</div>
    </div>
</div>

</body>
</html>
