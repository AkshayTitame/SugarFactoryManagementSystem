<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Cane Type Registration</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(to right, #e6f7ff, #ccfff2);
    font-family: 'Segoe UI', sans-serif;
}
.card {
    border-radius: 15px;
    box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
    margin-top: 50px;
    padding: 30px;
}
.btn-submit {
    background-color: #28a745;
    color: white;
    font-weight: 600;
}
.btn-submit:hover {
    background-color: #218838;
    color: white;
}
#message {
    margin-top: 15px;
}
</style>
</head>
<body>

<div class="container">
    <div class="card mx-auto col-md-6">
        <h2 class="text-center text-success mb-4"><i class="bi bi-plus-circle"></i> Add Cane Type</h2>

        <form id="caneTypeForm">
            <div class="mb-3">
                <label for="caneName" class="form-label fw-bold">Cane Name</label>
                <input type="text" class="form-control" id="caneName" name="caneName" placeholder="Enter Cane Name" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-submit"><i class="bi bi-check-circle"></i> Submit</button>
            </div>
        </form>

        <div id="message" class="text-center"></div>
    </div>
</div>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
$(document).ready(function() {
    $('#caneTypeForm').submit(function(e) {
        e.preventDefault(); // prevent default form submission
        var caneName = $('#caneName').val().trim();

        if(caneName === '') {
            $('#message').html('<div class="alert alert-danger">Please enter Cane Name.</div>');
            return;
        }

        $.ajax({
            url: 'AddCaneType', // your Servlet
            type: 'POST',
            data: { caneName: caneName },
            success: function(response) {
                // Assuming servlet returns "success" or "error" as plain text
                if(response.trim() === 'success'){
                    $('#message').html('<div class="alert alert-success">Cane Type added successfully!</div>');
                    $('#caneTypeForm')[0].reset(); // clear form
                } else {
                    $('#message').html('<div class="alert alert-danger">Failed to add Cane Type. Please try again.</div>');
                }
            },
            error: function() {
                $('#message').html('<div class="alert alert-danger">Server error! Try again later.</div>');
            }
        });
    });
});
</script>

</body>
</html>
