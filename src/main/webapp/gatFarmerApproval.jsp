<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Farmer Approval</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f0f9f9;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        max-width: 1100px;
        margin: 50px auto;
        padding: 25px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #008080;
        margin-bottom: 25px;
    }

    /* Search Box */
    .search-box {
        text-align: right;
        margin-bottom: 20px;
    }
    .search-box input {
        padding: 10px 15px;
        width: 280px;
        border-radius: 8px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
    }
    th, td {
        padding: 12px 15px;
        text-align: left;
    }
    th {
        background: #008080;
        color: #fff;
    }
    tr:nth-child(even) {
        background: #e0f7f7;
    }
    tr:hover {
        background: #c0f0f0;
    }
    td input[type="checkbox"] {
        transform: scale(1.2);
    }

    /* Buttons */
    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
    }
    .btn-approve {
        background-color: #008080;
        color: #fff;
    }
    .btn-approve:hover {
        background-color: #006666;
        transform: translateY(-2px);
    }
    .btn-cancel {
        background-color: #b22222;
        color: #fff;
        margin-left: 15px;
    }
    .btn-cancel:hover {
        background-color: #8b1a1a;
        transform: translateY(-2px);
    }

    /* Responsive Table */
    @media (max-width: 768px) {
        table, thead, tbody, th, td, tr { display: block; }
        tr {
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
        }
        td {
            text-align: right;
            position: relative;
            padding-left: 50%;
        }
        td::before {
            content: attr(data-label);
            position: absolute;
            left: 15px;
            font-weight: 600;
            color: #555;
        }
        th { display: none; }
    }
</style>

<script>
    // Select/Deselect all checkboxes
    function toggleSelectAll(source) {
        let checkboxes = document.getElementsByName('farmerID');
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }

    // Search/filter table
    function searchTable() {
        let input = document.getElementById("searchInput");
        let filter = input.value.toUpperCase();
        let table = document.getElementById("farmerTable");
        let tr = table.getElementsByTagName("tr");

        for (let i = 1; i < tr.length; i++) {
            let tdArr = tr[i].getElementsByTagName("td");
            let txtValue = "";
            for (let td of tdArr) { txtValue += td.textContent || td.innerText; }
            tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }
    }
</script>
</head>
<body>
<div class="container">
<h2>List of Farmers Pending Approval</h2>

<div class="search-box">
    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search farmers...">
</div>

<form action="GatOfficerApproval" method="post">
<table id="farmerTable">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
            <th>Farmer Name</th>
            <th>Address</th>
            <th>Mobile Number</th>
            <th>Aadhar Number</th>
        </tr>
    </thead>
    <tbody>
    <%
        String student = null;
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader ("Expires", 0);

        if(session.getAttribute("studentObject")==null){
            response.sendRedirect("loginPage.html");
        } else { student=(String)session.getAttribute("studentObject"); }

        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String database = "sugarFactory";
        String userid = "root";
        String password = "123456";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(connectionUrl+database, userid, password);
            Statement statement = con.createStatement();
            String sql ="select f.farmerID,f.farmerName,f.address,f.mobile,f.adharNo " +
                        "from farmer f,gatofficer g " +
                        "where f.areaID=g.areaID and f.status=1 and f.gatOfficerStatus=0 " +
                        "and g.gatofficerID='"+student+"'";
            ResultSet resultSet = statement.executeQuery(sql);

            while(resultSet.next()){
    %>
        <tr>
            <td data-label="Select"><input type="checkbox" value="<%=resultSet.getString("farmerID")%>" name="farmerID"></td>
            <td data-label="Farmer Name"><%=resultSet.getString("farmerName")%></td>
            <td data-label="Address"><%=resultSet.getString("address")%></td>
            <td data-label="Mobile"><%=resultSet.getString("mobile")%></td>
            <td data-label="Aadhar"><%=resultSet.getString("adharNo")%></td>
        </tr>
    <%
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    %>
    </tbody>
</table>

<div style="text-align:center;">
    <input type="submit" value="Approve Farmers" class="btn btn-approve">
    <button class="btn btn-cancel" formaction="gatOfficerDashboard.jsp">Cancel</button>
</div>
</form>
</div>
</body>
</html>
