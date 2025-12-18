<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Farmer Approval</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
#message {
    margin-top: 15px;
}
</style>
</head>
<body>

<div class="container">
    <div class="card">
        <h2 class="text-center text-success mb-4"><i class="bi bi-check2-square"></i> Farmer Pending Approval</h2>

        <div class="mb-3 text-end">
            <button id="approveBtn" class="btn btn-approve"><i class="bi bi-check-circle"></i> Approve Selected</button>
            <a href="adminDashboard.jsp" class="btn btn-cancel"><i class="bi bi-x-circle"></i> Cancel</a>
        </div>

        <table id="farmerTable" class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>Farmer Name</th>
                    <th>Address</th>
                    <th>Mobile Number</th>
                    <th>Adhar Number</th>
                </tr>
            </thead>
            <tbody>
                <%-- Table rows will be populated by your Servlet --%>
            </tbody>
        </table>

        <div id="message" class="text-center"></div>
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
    // Initialize DataTable
    var table = $('#farmerTable').DataTable({
        "pageLength": 10,
        "lengthMenu": [5, 10, 25, 50],
        "columnDefs": [{ "orderable": false, "targets": 0 }]
    });

    // Select/Deselect All Checkboxes
    $('#selectAll').click(function(){
        $('input.farmerCheck').prop('checked', this.checked);
    });

    // Approve Selected Farmers using AJAX
    $('#approveBtn').click(function(){
        var selected = [];
        $('input.farmerCheck:checked').each(function(){
            selected.push($(this).val());
        });

        if(selected.length === 0){
            $('#message').html('<div class="alert alert-danger">Please select at least one farmer to approve.</div>');
            return;
        }

        if(confirm("Are you sure you want to approve selected farmers?")){
            $.ajax({
                url: 'FarmerApproval', // your Servlet
                type: 'POST',
                data: { farmerID: selected },
                traditional: true, // send array properly
                success: function(response){
                    $('#message').html('<div class="alert alert-success">Selected farmers approved successfully!</div>');
                    // Remove approved rows from table
                    $('input.farmerCheck:checked').closest('tr').fadeOut(800, function(){
                        table.row($(this)).remove().draw();
                    });
                },
                error: function(){
                    $('#message').html('<div class="alert alert-danger">Error approving farmers. Please try again.</div>');
                }
            });
        }
    });
});
</script>

</body>
</html>
