<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Farmer Weight Records</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(to right, #f1f8e9, #ffffff);
    min-height: 100vh;
    padding: 30px;
}

.card-custom {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0px 10px 25px rgba(0,0,0,0.15);
    padding: 25px;
    animation: fadeIn 0.7s ease-in-out;
}

.card-custom h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #2e7d32;
    font-weight: bold;
}

.table {
    font-size: 15px;
}

.table thead th {
    background: #2e7d32;
    color: #fff;
    text-align: center;
}

.table tbody td {
    text-align: center;
    vertical-align: middle;
}

.table tbody tr:hover {
    background: #f1f8f4;
    transition: 0.3s;
}

.table-container {
    max-height: 450px;
    overflow-y: auto;
}

.search-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    flex-wrap: wrap;
    gap: 10px;
}

.search-bar input {
    max-width: 300px;
    border-radius: 8px;
    padding: 10px;
    border: 1px solid #ccc;
}

.action-btns button {
    border-radius: 8px;
    margin-left: 5px;
}

a.btn-home {
    display: inline-block;
    margin-top: 20px;
    background-color: #2e7d32;
    color: #fff;
    padding: 10px 25px;
    border-radius: 8px;
    text-decoration: none;
    transition: all 0.3s ease;
}

a.btn-home:hover {
    background-color: #1b5e20;
    transform: translateY(-2px);
}

@keyframes fadeIn {
    from {opacity: 0; transform: translateY(-20px);}
    to {opacity: 1; transform: translateY(0);}
}
</style>
</head>
<body>

<div class="container">
    <div class="card-custom">
        <h2><i class="bi bi-clipboard-data"></i> Farmer Cane Weight Records</h2>

        <!-- Search + Export -->
        <div class="search-bar">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by Farmer Name, Area...">
            <div class="action-btns">
                <button class="btn btn-success btn-sm" onclick="exportTableToCSV()"><i class="bi bi-file-earmark-excel"></i> Export CSV</button>
                <button class="btn btn-danger btn-sm" onclick="window.print()"><i class="bi bi-printer-fill"></i> Print</button>
            </div>
        </div>

        <!-- Table -->
        <div class="table-container">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Reg No.</th>
                        <th>Farmer Name</th>
                        <th>Uttara Number</th>
                        <th>Area</th>
                        <th>Cane Type</th>
                        <th>Weight (kg)</th>
                    </tr>
                </thead>
                <%-- <tbody id="recordsTable">
                <%
                    List<FarmerWeight> weightList = (List<FarmerWeight>) request.getAttribute("weightList");
                    if(weightList != null && !weightList.isEmpty()){
                        for(FarmerWeight fw : weightList){
                %>
                    <tr>
                        <td><%= fw.getRegistrationNo() %></td>
                        <td><%= fw.getFarmerName() %></td>
                        <td><%= fw.getUttaraNo() %></td>
                        <td><%= fw.getArea() %></td>
                        <td><%= fw.getCaneTypeName() %></td>
                        <td><%= fw.getWeight() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6">🚫 No records available.</td>
                    </tr>
                <%
                    }
                %>
                </tbody> --%>
            </table>
        </div>

        <div class="text-center">
            <a href="farmerDashboard.jsp" class="btn-home"><i class="bi bi-house-fill"></i> Back to Dashboard</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Search & Export -->
<script>
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#recordsTable tr");
    rows.forEach(row => {
        let text = row.textContent.toLowerCase();
        row.style.display = text.includes(filter) ? "" : "none";
    });
});

// Export table as CSV
function exportTableToCSV() {
    let table = document.querySelector("table");
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
    link.download = "Farmer_Weight_Records.csv";
    link.href = window.URL.createObjectURL(csvFile);
    link.click();
}
</script>

</body>
</html>
