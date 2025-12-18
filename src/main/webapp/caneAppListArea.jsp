<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.connection.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Farmer List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-20px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>

<div class="card p-4 col-md-6 bg-white">
    <h3 class="text-center text-primary mb-4"><i class="bi bi-people-fill"></i> Farmer List</h3>

    <form action="CaneRegList" method="post">
        <div class="mb-3">
            <label for="areaID" class="form-label fw-bold">Select Area</label>
            <select name="areaID" id="areaID" class="form-select" required>
                <option value="">-- Select Area --</option>
                <%
                    try (Connection con = DBConnection.getConnection();
                         PreparedStatement ps = con.prepareStatement("SELECT areaID, areaName FROM area");
                         ResultSet rs = ps.executeQuery()) {

                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                %>
                            <option value="<%= rs.getInt("areaID") %>"><%= rs.getString("areaName") %></option>
                <%
                        }
                        if (!hasData) {
                %>
                            <option disabled>No Areas Found</option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                        <option disabled>Error Loading Areas</option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check2-circle"></i> Submit
            </button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
