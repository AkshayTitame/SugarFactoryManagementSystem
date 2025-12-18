<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Area</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
        }
        .card {
            margin-top: 60px;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .btn-custom {
            background-color: #2d6a4f;
            color: #fff;
        }
        .btn-custom:hover {
            background-color: #1b4332;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="card w-50">
            <h2 class="text-center mb-4">➕ Add New Area</h2>
            
            <!-- Display error/success messages -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success">${successMsg}</div>
            </c:if>

            <!-- Area Form -->
            <form action="AddAreaServlet" method="post">
                <div class="mb-3">
                    <label for="areaName" class="form-label">Area Name</label>
                    <input type="text" class="form-control" id="areaName" name="areaName" placeholder="Enter Area Name" required>
                </div>
                
                <button type="submit" class="btn btn-custom w-100">Add Area</button>
            </form>
            
            <a href="adminDashboard.jsp" class="btn btn-secondary w-100 mt-3">🏠 Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
