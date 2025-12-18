<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cane Registration Approval</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(to right, #ccfff2, #e6f7ff);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
h2 {
    margin-top: 30px;
    color: #006666;
}
thead th {
    background-color: #008080;
    color: white;
    text-align: center;
}
tbody td {
    text-align: center;
}
input[type=submit], .btn-cancel {
    width: 150px;
    font-weight: bold;
}
.btn-cancel {
    background-color: #800000;
    color: white;
}
.btn-cancel:hover {
    background-color: #aa0000;
}
.form-check-input {
    transform: scale(1.2);
}
.table-responsive {
    margin-top: 20px;
}
</style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Cane Registration Pending Approval</h2>

    <form action="AdminCaneRegApproval" method="post">
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" class="form-check-input">
                            <label for="selectAll">Select All</label>
                        </th>
                        <th>Registration No</th>
                        <th>Farmer Name</th>
                        <th>Uttara No</th>
                        <th>Cane Type</th>
                        <th>Registration Date</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    // Assume servlet sets attribute "pendingRegistrations" as a List of JavaBeans or Maps
                    java.util.List<?> list = (java.util.List<?>) request.getAttribute("pendingRegistrations");
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");

                    if (list != null && !list.isEmpty()) {
                        for (Object obj : list) {
                            // Assuming obj is a Map<String,Object>
                            java.util.Map<String,Object> row = (java.util.Map<String,Object>) obj;
                %>
                    <tr>
                        <td>
                            <input class="form-check-input row-checkbox" type="checkbox" name="registrationNo" value="<%=row.get("registrationNo")%>">
                        </td>
                        <td><%= row.get("registrationNo") %></td>
                        <td><%= row.get("farmerName") %></td>
                        <td><%= row.get("uttaraNo") %></td>
                        <td><%= row.get("caneTypeName") %></td>
                        <td><%= sdf.format(row.get("caneRegDate")) %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="text-center text-danger">No pending registrations found!</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="text-center my-3">
            <input type="submit" value="Approve" class="btn btn-success">
            <a href="adminDashboard.jsp" class="btn btn-cancel">Cancel</a>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Select All functionality
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.row-checkbox');
    checkboxes.forEach(cb => cb.checked = this.checked);
});
</script>

</body>
</html>
