<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.connection.DBConnection" %>

<%
String student = null;
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

if(session.getAttribute("studentObject") == null){
    response.sendRedirect("loginPage.html");
}else{
    student = (String)session.getAttribute("studentObject");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Gat Officer Approval</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(to right, #e0f7fa, #ffffff);
    margin: 0;
    padding: 20px;
}

/* Card Container */
.container-custom {
    max-width: 1200px;
    margin: auto;
    background: #fff;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    animation: fadeIn 0.6s ease-in-out;
}

/* Title */
h2 {
    text-align: center;
    color: #00796b;
    font-weight: bold;
    margin-bottom: 25px;
}

/* Search Bar */
.search-box {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    flex-wrap: wrap;
    gap: 10px;
}

.search-box input {
    border-radius: 10px;
    padding: 10px 15px;
    border: 1px solid #ccc;
    width: 280px;
    transition: 0.3s;
}

.search-box input:focus {
    border-color: #00796b;
    box-shadow: 0px 0px 8px rgba(0,121,107,0.3);
}

/* Table Styles */
.table-container {
    max-height: 450px;
    overflow-y: auto;
    border-radius: 12px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead th {
    background: #00796b;
    color: white;
    text-align: center;
    position: sticky;
    top: 0;
    z-index: 1;
    padding: 12px;
}

tbody td {
    text-align: center;
    padding: 12px;
    vertical-align: middle;
}

tbody tr:nth-child(even) {
    background-color: #f1f8f6;
}

tbody tr:hover {
    background-color: #e0f2f1;
    transition: 0.3s;
}

/* Buttons */
.action-buttons {
    margin-top: 20px;
    text-align: center;
}

.btn-approve {
    background-color: #00796b;
    color: white;
    border-radius: 10px;
    padding: 10px 20px;
    transition: 0.3s;
}

.btn-approve:hover {
    background-color: #004d40;
}

.btn-cancel {
    background-color: #b71c1c;
    color: white;
    border-radius: 10px;
    padding: 10px 20px;
    margin-left: 10px;
    transition: 0.3s;
}

.btn-cancel:hover {
    background-color: #7f0000;
}

/* Badge Style */
.badge-cane {
    background: #00796b;
    color: #fff;
    padding: 5px 10px;
    border-radius: 12px;
    font-size: 13px;
}

/* Animation */
@keyframes fadeIn {
    from {opacity: 0; transform: translateY(-20px);}
    to {opacity: 1; transform: translateY(0);}
}

/* Responsive */
@media (max-width: 768px){
    .search-box {
        flex-direction: column;
        align-items: stretch;
    }
    .search-box input {
        width: 100%;
    }
}
</style>

<!-- <script>
// Select/Deselect All
function toggleSelectAll(source) {
    let checkboxes = document.getElementsByName('registrationNo');
    for(let i=0; i<checkboxes.length;i++) {
        checkboxes[i].checked = source.checked;
    }
}

// Search/Filter Table
function searchTable() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toUpperCase();
    let table = document.getElementById("caneTable");
    let tr = table.getElementsByTagName("tr");

    for (let i = 1; i < tr.length; i++) {
        let tdArr = tr[i].getElementsByTagName("td");
        let txtValue = "";
        for(let td of tdArr){
            txtValue += td.textContent || td.innerText;
        }
        tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
    }
}

// Export Table to CSV
function exportTableToCSV() {
    let table = document.querySelector("#caneTable");
    let rows = table.querySelectorAll("tr");
    let csv = [];
    rows.forEach(row => {
        let cols = row.querySelectorAll("td, th");
        let data = [];
        cols.forEach(col => data.push(col.innerText));
        csv.push(data.join(","));
    });
    let csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
    let link = document.createElement("a");
    link.download = "Pending_Cane_Registrations.csv";
    link.href = window.URL.createObjectURL(csvFile);
    link.click();
}
</script> -->
</head>
<body>
<div class="container-custom">
    <h2><i class="bi bi-list-check"></i> Cane Registrations Pending Approval</h2>

    <div class="search-box">
        <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="🔍 Search farmer, uttara, cane type...">
        <button class="btn btn-success btn-sm" onclick="exportTableToCSV()"><i class="bi bi-file-earmark-excel"></i> Export CSV</button>
        <button class="btn btn-secondary btn-sm" onclick="window.print()"><i class="bi bi-printer"></i> Print</button>
    </div>

    <form action="GatCaneRegApproval" method="post">
        <div class="table-container">
            <table id="caneTable" class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
                        <th>Registration No</th>
                        <th>Farmer Name</th>
                        <th>Uttara Number</th>
                        <th>Cane Type</th>
                        <th>Registration Date</th>
                    </tr>
                </thead>
                <tbody>
                <%-- 
                ResultSet resultSet = null;
                try{
                    resultSet = DBConnection.getPendingCaneRegistrations(student);
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    while(resultSet.next()){
                %>
                <tr>
                    <td><input type="checkbox" name="registrationNo" value="<%=resultSet.getString("registrationNo")%>"></td>
                    <td><%=resultSet.getString("registrationNo")%></td>
                    <td><%=resultSet.getString("farmerName")%></td>
                    <td><%=resultSet.getString("uttaraNo")%></td>
                    <td><span class="badge-cane"><%=resultSet.getString("caneTypeName")%></span></td>
                    <td><%=sdf.format(resultSet.getDate("caneRegDate"))%></td>
                </tr>
                <%
                    }
                } catch(Exception e){
                    e.printStackTrace();
                }
                %>
                --%>
                </tbody>
            </table>
        </div>

        <div class="action-buttons">
            <input type="submit" class="btn-approve" value="Approve">
            <button class="btn-cancel" formaction="gatOfficerDashboard.jsp">Cancel</button>
        </div>
    </form>
</div>
</body>
</html>
