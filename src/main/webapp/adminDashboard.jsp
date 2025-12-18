<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Admin Dashboard</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* Base */
body {
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    background: #ffffff;
    color: #333;
    text-align: center;
}

/* Heading */
h2 {
    margin: 40px 0;
    font-size: 36px;
    color: #004d4d;
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* Dashboard container */
.dashboard {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 35px;
    max-width: 1200px;
    margin: 0 auto 60px auto;
}

/* Card */
.card {
    background: #ffffff;
    border-radius: 15px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    width: 250px;
    padding: 30px 20px;
    transition: transform 0.4s, box-shadow 0.4s, background 0.4s;
    cursor: pointer;
    text-align: center;
    position: relative;
    overflow: hidden;
}

/* Card hover animation: very light color */
.card:hover {
    transform: translateY(-5px) scale(1.02);
    box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    background: rgba(0, 128, 128, 0.01); /* very subtle tint */
}

/* Icon gradient animation */
.card i {
    font-size: 55px;
    display: inline-block;
    background: linear-gradient(45deg, #00fff0, #008080, #004d4d, #00fff0);
    background-size: 300% 300%;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: gradientflow 5s ease infinite;
    transition: transform 0.4s;
}

.card:hover i {
    transform: rotate(5deg) scale(1.15);
}

/* Card text */
.card span {
    display: block;
    margin-top: 15px;
    font-size: 20px;
    font-weight: 700;
    color: #004d4d;
    transition: color 0.4s;
}

.card:hover span {
    color: #008080;
}

/* Animations */
@keyframes gradientflow {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Responsive */
@media (max-width: 768px) {
    .dashboard {
        flex-direction: column;
        gap: 20px;
        align-items: center;
    }
}
</style>
</head>
<body>

<h2>Admin Dashboard</h2>

<div class="dashboard">
    <div class="card" onclick="window.location.href='gatOfficerApproval.jsp'">
        <i class="fas fa-user-check"></i>
        <span>Gat Officer Approval</span>
    </div>

    <div class="card" onclick="window.location.href='farmerApproval.jsp'">
        <i class="fas fa-users"></i>
        <span>Farmer Approval</span>
    </div>

    <div class="card" onclick="window.location.href='caneTypeRegistration.jsp'">
        <i class="fas fa-seedling"></i>
        <span>Cane Type Registration</span>
    </div>

    <div class="card" onclick="window.location.href='adminCaneRegApproval.jsp'">
        <i class="fas fa-check-circle"></i>
        <span>Approve Cane Registration</span>
    </div>

    <div class="card" onclick="window.location.href='addArea.jsp'">
        <i class="fas fa-map-marked-alt"></i>
        <span>Create Region</span>
    </div>

    <div class="card" onclick="window.location.href='caneAppListArea.jsp'">
        <i class="fas fa-upload"></i>
        <span>Upload Weight</span>
    </div>

    <div class="card" onclick="window.location.href='gatFarmerList.jsp'">
        <i class="fas fa-list"></i>
        <span>View Farmer List</span>
    </div>

    <div class="card" onclick="window.location.href='adminLogout.jsp'">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
    </div>
</div>

</body>
</html>
