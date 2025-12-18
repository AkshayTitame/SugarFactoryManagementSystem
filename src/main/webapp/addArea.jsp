<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Area</title>
<script>
function showAlert(message){
    alert(message);
}
</script>
<style>
body {
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #a1c4fd, #c2e9fb);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
.card {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}
input[type=text] {
    padding: 10px;
    width: 100%;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
}
input[type=submit] {
    padding: 10px 20px;
    background-color: #008080;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
input[type=submit]:hover {
    background-color: #006666;
}
</style>
</head>
<body>
<div class="card">
    <h2>Add New Area</h2>
    <form action="AddArea" method="post">
        <input type="text" name="areaName" placeholder="Enter Area Name" required>
        <input type="submit" value="Add Area">
    </form>

    <%-- Show popup messages --%>
    <%
        String msg = request.getParameter("msg");
        if(msg != null){
    %>
        <script>
            showAlert("<%=msg%>");
        </script>
    <%
        }
    %>
</div>
</body>
</html>
