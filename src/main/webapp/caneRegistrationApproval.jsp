<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.connection.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Cane Registration Approval</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<!-- DataTables CSS -->
<link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(to right, #ccfff2, #e6f7ff);
    font-family: 'Segoe UI', sans-serif;
}
.card {
    border-radius: 15px;
    box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
    margin-top: 50px;
    padding: 20px;
}
.table thead th {
    background-color: #008080;
    color: white;
}
.table-hover tbody tr:hover {
    background-color: #cce5ff;
}
.btn-approve {
    background-color: #28a745;
}
.btn-approve:hover {
    background-color: #218838;
}
.btn-cancel {
    background-color: #dc3545;
}
.btn-cancel:hover {
    background-color: #c82333;
}
</style>
</head>
<body>

<div class="container">
    <div class="card">
        <h2 class="text-center text-success mb-4"><i class="bi bi-check2-square"></i> Cane Registrations Pending Approval</h2>

        <div class="mb-3 text-end">
            <button id="approveBtn" class="btn btn-approve"><i class="bi bi-check-circle"></i> Approve Selected</button>
            <a href="admindashboard.jsp" class="btn btn-cancel"><i class="bi bi-x-circle"></i> Cancel</a>
        </div>

        <table id="approvalTable" class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>Registration No</th>
                    <th>Farmer ID</th>
                    <th>Uttara No</th>
                    <th>Cane Type ID</th>
                </tr>
            </thead>
            <tbody id="tableBody">
            <%
                try(Connection con =  DBConnection.getConnection();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM caneregistration WHERE gatOfficerStatus=1 AND adminStatus=0");) {

                    while(rs.next()) {
            %>
                <tr>
                    <td><input type="checkbox" class="regCheck" value="<%=rs.getString("registrationNo")%>"></td>
                    <td><%=rs.getString("registrationNo")%></td>
                    <td><%=rs.getString("farmerID")%></td>
                    <td><%=rs.getString("uttaraNo")%></td>
                    <td><%=rs.getString("caneTypeID")%></td>
                </tr>
            <%
                    }
                } catch(Exception e){
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    var table = $('#approvalTable').DataTable({
        "pageLength": 10,
        "lengthMenu": [5, 10, 25, 50],
        "columnDefs": [{ "orderable": false, "targets": 0 }]
    });

    // Select/Deselect All Checkboxes
    $('#selectAll').click(function(){
        $('.regCheck').prop('checked', this.checked);
    });

    // Approve Selected Registrations using AJAX
    $('#approveBtn').click(function(){
        var selected = [];
        $('.regCheck:checked').each(function(){
            selected.push($(this).val());
        });

        if(selected.length === 0){
            alert("Please select at least one registration to approve.");
            return;
        }

        if(confirm("Are you sure you want to approve selected registrations?")){
            $.ajax({
                url: 'GatCaneRegApproval', // your Servlet
                type: 'POST',
                data: { registrationNo: selected },
                traditional: true, // send array properly
                success: function(response){
                    alert("Selected registrations approved successfully!");
                    // Remove approved rows from table
                    $('.regCheck:checked').closest('tr').fadeOut(800, function(){
                        table.row($(this)).remove().draw();
                    });
                },
                error: function(){
                    alert("Error approving registrations. Please try again.");
                }
            });
        }
    });
});
</script>

</body>
</html>
