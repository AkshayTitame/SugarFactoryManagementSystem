<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnection" %>

<%
    // AJAX request for villages
    String gatId = request.getParameter("gat_id");
    if(gatId != null && !gatId.isEmpty()) {
        response.setContentType("text/html;charset=UTF-8");
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT village_id, village_name FROM village WHERE gat_office_id=?")) {
            ps.setInt(1, Integer.parseInt(gatId));
            ResultSet rs = ps.executeQuery();
            boolean found = false;
            while(rs.next()){
                found = true;
                out.println("<option value='" + rs.getInt("village_id") + "'>" + rs.getString("village_name") + "</option>");
            }
            if(!found){
                out.println("<option value=''>No villages found</option>");
            }
        } catch(Exception e) {
            out.println("<option value=''>Error loading villages</option>");
        }
        return; // stop further rendering
    }

    // Load dropdown data
    Connection con = DBConnection.getConnection();
    PreparedStatement psSoil = con.prepareStatement("SELECT soil_type_id, soil_type_name FROM soil_type");
    ResultSet rsSoil = psSoil.executeQuery();

    PreparedStatement psCane = con.prepareStatement("SELECT cane_type_id, cane_type_name FROM cane_type");
    ResultSet rsCane = psCane.executeQuery();

    PreparedStatement psIrr = con.prepareStatement("SELECT irrigation_type_id, irrigation_type_name FROM irrigation_type");
    ResultSet rsIrr = psIrr.executeQuery();

    PreparedStatement psGat = con.prepareStatement("SELECT gat_office_id, gat_office_name FROM gat_office");
    ResultSet rsGat = psGat.executeQuery();

    Boolean success = (Boolean) request.getAttribute("success");
    String message = request.getAttribute("message") != null ? request.getAttribute("message").toString() : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sugarcane Farm Registration</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body { background: linear-gradient(to right, #f4f7f8, #e6f0ff); }
.card { border-radius: 12px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
.card-header { background-color: #4CAF50; color: #fff; font-weight: 600; font-size: 1.3rem; border-top-left-radius: 12px; border-top-right-radius: 12px; }
.form-control:focus, .form-select:focus { box-shadow: 0 0 5px rgba(76,175,80,0.3); }
.btn-submit { background-color: #4CAF50; color: #fff; font-weight: 600; transition: 0.3s; }
.btn-submit:hover { background-color: #45a049; }
.section-title { border-left: 4px solid #4CAF50; padding-left: 10px; margin-bottom: 15px; font-weight: 600; }
.group-label { font-weight: 600; margin-top: 10px; }
.error-msg { color: red; font-size: 0.85rem; }
.success-msg { color: green; font-size: 1rem; font-weight: 600; text-align: center; margin-bottom: 10px; }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function validateField(id, condition, message) {
    const el = document.getElementById(id);
    const errorEl = document.getElementById(id + 'Error');
    if(condition(el.value)){
        el.classList.remove('border-danger');
        el.classList.add('border-success');
        errorEl.textContent = '';
        return true;
    } else {
        el.classList.remove('border-success');
        el.classList.add('border-danger');
        errorEl.textContent = message;
        return false;
    }
}

function validateNameField(id, label) {
    return validateField(id, val => /^[A-Za-z\s]+$/.test(val) && val.trim() !== '', `Enter valid ${label}`);
}

$(document).ready(function(){
    // Dynamic village loading
    $("#gatName").change(function() {
        var gatId = $(this).val();
        if(gatId !== "") {
            $.ajax({
                url: "",
                type: "GET",
                data: { gat_id: gatId },
                success: function(response) {
                    $("#village").html('<option value="">--Select Village--</option>' + response);
                },
                error: function(xhr, status, error) {
                    alert("Error loading villages: " + error);
                }
            });
        } else {
            $("#village").html('<option value="">--Select Village--</option>');
        }
    });

    const nameFields = [
        ['firstName','Farmer First Name'],
        ['middleName','Farmer Middle Name'],
        ['lastName','Farmer Last Name'],
        ['fatherFirstName','Father First Name'],
        ['fatherMiddleName','Father Middle Name'],
        ['fatherLastName','Father Last Name']
    ];
    nameFields.forEach(f => { $("#" + f[0]).on('input', function(){ validateNameField(f[0], f[1]); }); });

    ['address','uttraNo','area','caneTypeID','regdate','gatName','village'].forEach(id => {
        $("#" + id).on('input change', function(){ validateField(id, val=>val.trim()!=='','This field is required'); });
    });

    $("#mobile").on('input', function(){ validateField('mobile', val => /^\d{10}$/.test(val), 'Enter valid 10-digit number'); });
    $("#aadhaarNo").on('input', function(){ validateField('aadhaarNo', val => val === '' || /^\d{12}$/.test(val), 'Enter valid 12-digit Aadhaar number'); });
    $("#area").on('input', function(){ validateField('area', val => val > 0, 'Enter valid area'); });
});

function validateForm() {
    let valid = true;
    ['firstName','middleName','lastName','fatherFirstName','fatherMiddleName','fatherLastName'].forEach(id=>{ valid &= validateNameField(id, id); });
    ['address','uttraNo','area','caneTypeID','regdate','gatName','village'].forEach(id=>{ valid &= validateField(id, val=>val.trim()!=='','This field is required'); });
    valid &= validateField('mobile', val => /^\d{10}$/.test(val), 'Enter valid 10-digit number');
    valid &= validateField('aadhaarNo', val => val === '' || /^\d{12}$/.test(val), 'Enter valid 12-digit Aadhaar number');
    valid &= validateField('area', val => val > 0, 'Enter valid area');
    return !!valid;
}
</script>
</head>
<body>
<div class="container my-5">
    <div class="card p-4">
        <div class="card-header text-center">Sugarcane Farm Registration</div>
        <div class="card-body">

            <!-- Display duplicate or general message -->
            <% if(!message.isEmpty()){ %>
                <div class="alert <%= success != null && success ? "alert-success" : "alert-danger" %> text-center">
                    <%= message %>
                </div>
            <% } %>

            <form action="CaneRegistration" method="post" onsubmit="return validateForm()">

                <!-- Farmer Information -->
                <div class="mb-4">
                    <div class="section-title">Farmer Information</div>
                    <div class="row g-3">
                        <!-- Farmer Name -->
                        <div class="col-12">
                            <label class="group-label">Farmer Name</label>
                            <div class="row g-2 mt-1">
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>">
                                    <div id="firstNameError" class="error-msg"></div>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="middleName" name="middleName" placeholder="Middle Name" value="<%= request.getAttribute("middleName") != null ? request.getAttribute("middleName") : "" %>">
                                    <div id="middleNameError" class="error-msg"></div>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>">
                                    <div id="lastNameError" class="error-msg"></div>
                                </div>
                            </div>
                        </div>

                        <!-- Father/Husband Name -->
                        <div class="col-12">
                            <label class="group-label">Father / Husband Name</label>
                            <div class="row g-2 mt-1">
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="fatherFirstName" name="fatherFirstName" placeholder="First Name" value="<%= request.getAttribute("fatherFirstName") != null ? request.getAttribute("fatherFirstName") : "" %>">
                                    <div id="fatherFirstNameError" class="error-msg"></div>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="fatherMiddleName" name="fatherMiddleName" placeholder="Middle Name" value="<%= request.getAttribute("fatherMiddleName") != null ? request.getAttribute("fatherMiddleName") : "" %>">
                                    <div id="fatherMiddleNameError" class="error-msg"></div>
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="fatherLastName" name="fatherLastName" placeholder="Last Name" value="<%= request.getAttribute("fatherLastName") != null ? request.getAttribute("fatherLastName") : "" %>">
                                    <div id="fatherLastNameError" class="error-msg"></div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact -->
                        <div class="col-md-6">
                            <label for="mobile" class="form-label">Mobile Number</label>
                            <input type="text" class="form-control" id="mobile" name="mobile" placeholder="10-digit mobile" value="<%= request.getAttribute("mobile") != null ? request.getAttribute("mobile") : "" %>">
                            <div id="mobileError" class="error-msg"></div>
                        </div>
                        <div class="col-md-6">
                            <label for="aadhaarNo" class="form-label">Aadhaar Number</label>
                            <input type="text" class="form-control" id="aadhaarNo" name="aadhaarNo" placeholder="12-digit Aadhaar" value="<%= request.getAttribute("aadhaarNo") != null ? request.getAttribute("aadhaarNo") : "" %>">
                            <div id="aadhaarNoError" class="error-msg"></div>
                        </div>

                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Full address" value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>">
                            <div id="addressError" class="error-msg"></div>
                        </div>

                        <div class="col-12">
                            <label for="uttraNo" class="form-label">Survey / Uttara No.</label>
                            <input type="text" class="form-control" id="uttraNo" name="uttraNo" placeholder="Gat/Uttara No." value="<%= request.getAttribute("uttraNo") != null ? request.getAttribute("uttraNo") : "" %>">
                            <div id="uttraNoError" class="error-msg"></div>
                            <%-- Duplicate message specific under field --%>
                            <% if(message.equals("The Survey / Uttara No. is duplicate!")) { %>
                                <div class="error-msg"><%= message %></div>
                            <% } %>
                        </div>

                    </div>
                </div>

                <!-- Farm / Land Details -->
                <div class="mb-4">
                    <div class="section-title">Farm / Land Details</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="area" class="form-label">Total Area (in Guntha)</label>
                            <input type="number" class="form-control" id="area" name="area" step="0.01" value="<%= request.getAttribute("area") != null ? request.getAttribute("area") : "" %>">
                            <div id="areaError" class="error-msg"></div>
                        </div>
                        <div class="col-md-4">
                            <label for="soilType" class="form-label">Soil Type</label>
                            <select class="form-select" id="soilType" name="soilType">
                                <option value="">--Select Soil Type--</option>
                                <% while(rsSoil.next()){ %>
                                    <option value="<%=rsSoil.getInt("soil_type_id")%>" <%= request.getAttribute("soilType") != null && request.getAttribute("soilType").toString().equals(String.valueOf(rsSoil.getInt("soil_type_id"))) ? "selected" : "" %>>
                                        <%=rsSoil.getString("soil_type_name")%>
                                    </option>
                                <% } rsSoil.close(); psSoil.close(); %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="gatName" class="form-label">Gat Name</label>
                            <select class="form-select" id="gatName" name="gatName">
                                <option value="">--Select Gat Name--</option>
                                <% while(rsGat.next()){ %>
                                    <option value="<%=rsGat.getInt("gat_office_id")%>" <%= request.getAttribute("gatName") != null && request.getAttribute("gatName").toString().equals(String.valueOf(rsGat.getInt("gat_office_id"))) ? "selected" : "" %>>
                                        <%=rsGat.getString("gat_office_name")%>
                                    </option>
                                <% } rsGat.close(); psGat.close(); %>
                            </select>
                            <div id="gatNameError" class="error-msg"></div>
                        </div>
                        <div class="col-md-4">
                            <label for="village" class="form-label">Village</label>
                            <select class="form-select" id="village" name="village">
                                <option value="">--Select Village--</option>
                                <% if(request.getAttribute("village") != null) { %>
                                    <option value="<%=request.getAttribute("village")%>" selected>Selected Village</option>
                                <% } %>
                            </select>
                            <div id="villageError" class="error-msg"></div>
                        </div>
                    </div>
                </div>

                <!-- Sugarcane Details -->
                <div class="mb-4">
                    <div class="section-title">Sugarcane Details</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="caneTypeID" class="form-label">Sugarcane Type</label>
                            <select class="form-select" id="caneTypeID" name="caneTypeID">
                                <option value="">--Select Cane Type--</option>
                                <% while(rsCane.next()){ %>
                                    <option value="<%=rsCane.getInt("cane_type_id")%>" <%= request.getAttribute("caneTypeID") != null && request.getAttribute("caneTypeID").toString().equals(String.valueOf(rsCane.getInt("cane_type_id"))) ? "selected" : "" %>>
                                        <%=rsCane.getString("cane_type_name")%>
                                    </option>
                                <% } rsCane.close(); psCane.close(); %>
                            </select>
                            <div id="caneTypeIDError" class="error-msg"></div>
                        </div>
                        <div class="col-md-4">
                            <label for="regdate" class="form-label">Date of Registration</label>
                            <input type="date" class="form-control" id="regdate" name="regdate" value="<%= request.getAttribute("regdate") != null ? request.getAttribute("regdate") : "" %>">
                            <div id="regdateError" class="error-msg"></div>
                        </div>
                        <div class="col-md-4">
                            <label for="expectedHarvest" class="form-label">Expected Harvest Date</label>
                            <input type="date" class="form-control" id="expectedHarvest" name="expectedHarvest" value="<%= request.getAttribute("expectedHarvest") != null ? request.getAttribute("expectedHarvest") : "" %>">
                        </div>
                        <div class="col-md-6">
                            <label for="irrigationType" class="form-label">Irrigation Method</label>
                            <select class="form-select" id="irrigationType" name="irrigationType">
                                <option value="">--Select Irrigation--</option>
                                <% while(rsIrr.next()){ %>
                                    <option value="<%=rsIrr.getInt("irrigation_type_id")%>" <%= request.getAttribute("irrigationType") != null && request.getAttribute("irrigationType").toString().equals(String.valueOf(rsIrr.getInt("irrigation_type_id"))) ? "selected" : "" %>>
                                        <%=rsIrr.getString("irrigation_type_name")%>
                                    </option>
                                <% } rsIrr.close(); psIrr.close(); con.close(); %>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-submit btn-lg">Register Cane Farm <i class="fa fa-check-circle"></i></button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
