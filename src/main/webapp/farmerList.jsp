<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%> 
<%@page import="com.farmer.Farmer"%> 
<%@page import="java.util.List"%> 

<!DOCTYPE html>
<html lang="mr">
<head>
<meta charset="UTF-8">
<title>Farmer Confirmation</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(to right, #fff9c4, #ffe57f);
    font-family: 'Segoe UI', sans-serif;
    padding: 20px;
}

h1 {
    text-align: center;
    color: #2e7d32;
    margin-bottom: 30px;
}

.table-container {
    overflow-x: auto;
}

.table-custom {
    width: 100%;
    max-width: 1000px;
    margin: auto;
    border-collapse: collapse;
    box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
    border-radius: 12px;
    overflow: hidden;
}

.table-custom th, .table-custom td {
    padding: 16px;
    text-align: left;
    font-size: 18px;
}

.table-custom th {
    background-color: #2e7d32;
    color: #fff;
}

.table-custom tr:nth-child(even) {
    background-color: #f1f5f9;
}

.table-custom tr:hover {
    background-color: #d0f0c0;
    cursor: pointer;
}

.action-btns {
    text-align: center;
    margin-top: 30px;
}

.action-btns .btn {
    margin: 5px;
    padding: 12px 24px;
    font-size: 18px;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-confirm {
    background-color: #4CAF50;
    color: white;
}

.btn-confirm:hover {
    background-color: #45a049;
}

.btn-edit {
    background-color: #f44336;
    color: white;
}

.btn-edit:hover {
    background-color: #d32f2f;
}

.note {
    text-align: center;
    margin-top: 20px;
    font-size: 18px;
    color: #b71c1c;
    font-weight: 500;
}
</style>
</head>
<body>

<%
List<Farmer> p = null;
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("studentObject")==null){
    response.sendRedirect("index.jsp");
}else{
    p = (ArrayList<Farmer>)session.getAttribute("farmerList");
}
%>

<h1>Please Check the Below Information and Confirm</h1>

<div class="table-container">
<table class="table table-custom">
<thead>
<tr>
<th>Farmer ID</th>
<th>Farmer Name</th>
<th>Address</th>
<th>Mobile</th>
</tr>
</thead>
<tbody>
<%
for(Farmer f : p){
%>
<tr>
<td><%= f.getFarmerID() %></td>
<td><%= f.getFarmerName() %></td>
<td><%= f.getAddress() %></td>
<td><%= f.getMobile() %></td>
</tr>
<%
}
%>
</tbody>
</table>
</div>

<div class="action-btns">
    <a href="confirmFarmer.jsp" class="btn btn-confirm"><i class="bi bi-check-circle"></i> Confirm</a>
    <a href="editFarmer.jsp" class="btn btn-edit"><i class="bi bi-pencil-square"></i> Edit</a>
    <a href="index.html" class="btn btn-secondary"><i class="bi bi-house-door"></i> Home</a>
</div>

<p class="note">Please do not refresh this page.</p>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
