<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Farmer Registration</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
 body {
  background: linear-gradient(to right, #f4f7f8, #e6f0ff);
}

.card {
  border-radius: 12px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.card-header {
  background-color: #4CAF50;
  color: #fff;
  font-weight: 600;
  font-size: 1.3rem;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
}

.form-control,
.form-select,
textarea {
  border-radius: 8px;
  transition: all 0.3s;
}

/* Blue focus before validation */
.form-control:focus,
.form-select:focus,
textarea:focus {
  border-color: #80bdff;
  box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

/* Green border after valid input */
.form-control.border-success,
.form-select.border-success,
textarea.border-success {
  border-color: #28a745 !important;
  box-shadow: 0 0 5px rgba(40, 167, 69, 0.3) !important;
}

/* Red border after invalid input */
.form-control.border-danger,
.form-select.border-danger,
textarea.border-danger {
  border-color: #dc3545 !important;
  box-shadow: 0 0 5px rgba(220, 53, 69, 0.3) !important;
}

.section-title {
  border-left: 4px solid #4CAF50;
  padding-left: 10px;
  margin-bottom: 15px;
  font-weight: 600;
}

.error-msg {
  color: red;
  font-size: 0.85rem;
}

.success-msg {
  color: green;
  font-size: 1rem;
  font-weight: 600;
  text-align: center;
  margin-top: 15px;
}
  </style>

  <script>
    let locationData = [];

    // Load JSON file
    async function loadLocationData() {
      try {
        const response = await fetch("data/location.json");
        locationData = await response.json();
        populateStates();
      } catch (err) {
        console.error("Error loading JSON:", err);
      }
    }

    function populateStates() {
      const stateSelect = document.getElementById("state");
      stateSelect.innerHTML = "<option value=''>--Select State--</option>";
      locationData.forEach(s => {
        const opt = document.createElement("option");
        opt.value = s.state;
        opt.text = s.state;
        stateSelect.appendChild(opt);
      });
    }

    function populateDistricts() {
      const stateName = document.getElementById("state").value;
      const districtSelect = document.getElementById("district");
      const talukaSelect = document.getElementById("taluka");
      const villageSelect = document.getElementById("village");
      districtSelect.innerHTML = "<option value=''>--Select District--</option>";
      talukaSelect.innerHTML = "<option value=''>--Select Taluka--</option>";
      villageSelect.innerHTML = "<option value=''>--Select Village--</option>";

      const state = locationData.find(s => s.state === stateName);
      if (state) {
        state.districts.forEach(d => {
          const opt = document.createElement("option");
          opt.value = d.district;
          opt.text = d.district;
          districtSelect.appendChild(opt);
        });
      }
    }

    function populateTalukas() {
      const stateName = document.getElementById("state").value;
      const districtName = document.getElementById("district").value;
      const talukaSelect = document.getElementById("taluka");
      const villageSelect = document.getElementById("village");
      talukaSelect.innerHTML = "<option value=''>--Select Taluka--</option>";
      villageSelect.innerHTML = "<option value=''>--Select Village--</option>";

      const state = locationData.find(s => s.state === stateName);
      const district = state?.districts.find(d => d.district === districtName);
      if (district) {
        district.talukas.forEach(t => {
          const opt = document.createElement("option");
          opt.value = t.taluka;
          opt.text = t.taluka;
          talukaSelect.appendChild(opt);
        });
      }
    }

    function populateVillages() {
      const stateName = document.getElementById("state").value;
      const districtName = document.getElementById("district").value;
      const talukaName = document.getElementById("taluka").value;
      const villageSelect = document.getElementById("village");
      villageSelect.innerHTML = "<option value=''>--Select Village--</option>";

      const state = locationData.find(s => s.state === stateName);
      const district = state?.districts.find(d => d.district === districtName);
      const taluka = district?.talukas.find(t => t.taluka === talukaName);
      if (taluka) {
        taluka.villages.forEach(v => {
          const opt = document.createElement("option");
          opt.value = v;
          opt.text = v;
          villageSelect.appendChild(opt);
        });
      }
    }

    // Validation
    $(document).ready(function () {
      // Real-time validation helpers
      function validateField(id, msg) {
        let val = $("#" + id).val().trim();
        if (val === '') { $("#" + id + "Error").text(msg); return false; }
        else { $("#" + id + "Error").text(''); return true; }
      }
      function validateName(id, msg) {
        let val = $("#" + id).val().trim();
        if (val === '' || !/^[A-Za-z\s]+$/.test(val)) { $("#" + id + "Error").text(msg); return false; }
        else { $("#" + id + "Error").text(''); return true; }
      }
      function validateMobile(id) {
        let val = $("#" + id).val().trim();
        if (!/^\d{10}$/.test(val)) { $("#" + id + "Error").text("Enter valid 10-digit number"); return false; }
        else { $("#" + id + "Error").text(''); return true; }
      }
      function validateAadhaar(id) {
        let val = $("#" + id).val().trim();
        if (val !== '' && !/^\d{12}$/.test(val)) { $("#" + id + "Error").text("Enter valid 12-digit Aadhaar"); return false; }
        else { $("#" + id + "Error").text(''); return true; }
      }

      // Real-time checks
      ["firstName","middleName","lastName"].forEach(id => { $("#" + id).on('input', function(){ validateName(id,"Enter valid name"); }); });
      $("#mobile").on('input', function(){ validateMobile("mobile"); });
      $("#aadhaar").on('input', function(){ validateAadhaar("aadhaar"); });
      ["password","confirmPassword","state","district","taluka","village","address"].forEach(id => {
        $("#" + id).on('input change', function(){ validateField(id,"Required"); });
      });

      // Form submission validation
      $("#farmerForm").submit(function(){
        let valid = true;
        ["firstName","middleName","lastName"].forEach(id => { if(!validateName(id,"Enter valid name")) valid=false; });
        if(!validateMobile("mobile")) valid=false;
        if(!validateAadhaar("aadhaar")) valid=false;
        ["password","confirmPassword","state","district","taluka","village","address"].forEach(id => { if(!validateField(id,"Required")) valid=false; });
        if($("#password").val() !== $("#confirmPassword").val()){
          $("#confirmPasswordError").text("Password does not match"); valid=false;
        }
        return valid;
      });
    });

    window.onload = loadLocationData;
  </script>
</head>

<body>
  <div class="container my-5">
    <div class="card p-4">
      <div class="card-header text-center">Farmer Registration</div>
      <div class="card-body">
        <form id="farmerForm" action="FarmerRegisterServlet" method="post">

          <!-- Personal Information -->
          <div class="mb-4">
            <div class="section-title">Personal Information</div>
            <div class="row g-3">
              <div class="col-md-4">
                <label>First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter First Name">
                <div id="firstNameError" class="error-msg"></div>
              </div>
              <div class="col-md-4">
                <label>Middle Name</label>
                <input type="text" class="form-control" id="middleName" name="middleName" placeholder="Enter Middle Name">
                <div id="middleNameError" class="error-msg"></div>
              </div>
              <div class="col-md-4">
                <label>Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name">
                <div id="lastNameError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Mobile</label>
                <input type="text" class="form-control" id="mobile" name="mobile" placeholder="Enter Mobile">
                <div id="mobileError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Aadhaar</label>
                <input type="text" class="form-control" id="aadhaar" name="aadhaar" placeholder="Enter Aadhaar">
                <div id="aadhaarError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                <div id="passwordError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password">
                <div id="confirmPasswordError" class="error-msg"></div>
              </div>
            </div>
          </div>

          <!-- Address -->
          <div class="mb-4">
            <div class="section-title">Address</div>
            <div class="row g-3">
              <div class="col-md-6">
                <label>State</label>
                <select class="form-select" id="state" name="state" onchange="populateDistricts()">
                  <option value="">--Select State--</option>
                </select>
                <div id="stateError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>District</label>
                <select class="form-select" id="district" name="district" onchange="populateTalukas()">
                  <option value="">--Select District--</option>
                </select>
                <div id="districtError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Taluka / Tehsil</label>
                <select class="form-select" id="taluka" name="taluka" onchange="populateVillages()">
                  <option value="">--Select Taluka--</option>
                </select>
                <div id="talukaError" class="error-msg"></div>
              </div>
              <div class="col-md-6">
                <label>Village</label>
                <select class="form-select" id="village" name="village">
                  <option value="">--Select Village--</option>
                </select>
                <div id="villageError" class="error-msg"></div>
              </div>
              <div class="col-12">
                <label>Full Address</label>
                <textarea class="form-control" id="address" name="address" placeholder="Enter full Address"></textarea>
              </div>
            </div>
          </div>

          <!-- Buttons -->
          <div class="d-flex justify-content-between align-items-center mt-4">
            <a href="login.jsp" class="text-decoration-none fw-semibold" style="color: #1E90FF; border-bottom: 2px solid #1E90FF; padding-bottom: 2px;" 
               onmouseover="this.style.color='#104E8B'; this.style.borderBottom='2px solid #104E8B';" 
               onmouseout="this.style.color='#1E90FF'; this.style.borderBottom='2px solid #1E90FF';">
               Back to Login
            </a>
            <button type="submit" class="btn btn-lg fw-bold" style="background: linear-gradient(90deg, #28a745 0%, #218838 100%); color: #fff; border-radius: 8px; padding: 12px 30px;">
              Register
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnection" %> use your actual package name
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Farmer Registration</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
    body {
      background: linear-gradient(to right, #e6f0ff, #f4f7f8);
      font-family: 'Poppins', sans-serif;
    }
    .container {
      max-width: 900px;
      margin-top: 40px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
      padding: 30px;
    }
    .section-title {
      font-weight: bold;
      font-size: 18px;
      color: #007BFF;
      border-left: 4px solid #007BFF;
      padding-left: 10px;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<div class="container">
  <h3 class="text-center mb-4" style="color:#007BFF;">Farmer Registration</h3>
  <form action="FarmerRegisterServlet" method="post" id="farmerForm">

    <div class="section-title">Personal Details</div>
    <div class="row g-3">
      <div class="col-md-4">
        <label>First Name</label>
        <input type="text" name="firstName" id="firstName" class="form-control">
      </div>
      <div class="col-md-4">
        <label>Middle Name</label>
        <input type="text" name="middleName" id="middleName" class="form-control">
      </div>
      <div class="col-md-4">
        <label>Last Name</label>
        <input type="text" name="lastName" id="lastName" class="form-control">
      </div>
    </div>

    <div class="row g-3 mt-3">
      <div class="col-md-6">
        <label>Mobile</label>
        <input type="text" name="mobile" id="mobile" class="form-control">
      </div>
      <div class="col-md-6">
        <label>Aadhaar</label>
        <input type="text" name="aadhaar" id="aadhaar" class="form-control">
      </div>
    </div>

    <div class="row g-3 mt-3">
      <div class="col-md-6">
        <label>Password</label>
        <input type="password" name="password" id="password" class="form-control">
      </div>
      <div class="col-md-6">
        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" id="confirmPassword" class="form-control">
      </div>
    </div>

    <div class="section-title mt-4">Address Details</div>
    <div class="row g-3">
      <!-- ✅ State Dropdown -->
      <div class="col-md-6">
        <label>State</label>
        <select name="state" id="state" class="form-select">
          <option value="">--Select State--</option>
          <%
            try {
              Connection con = DBConnection.getConnection();
              Statement st = con.createStatement();
              ResultSet rs = st.executeQuery("SELECT state_id, state_name FROM state");
              while (rs.next()) {
          %>
                <option value="<%= rs.getInt("state_id") %>"><%= rs.getString("state_name") %></option>
          <%
              }
              rs.close(); st.close(); con.close();
            } catch (Exception e) { out.print("<option>Error loading states</option>"); }
          %>
        </select>
      </div>

      <div class="col-md-6">
        <label>District</label>
        <select name="district" id="district" class="form-select">
          <option value="">--Select District--</option>
        </select>
      </div>

      <div class="col-md-6">
        <label>Taluka / Tehsil</label>
        <select name="taluka" id="taluka" class="form-select">
          <option value="">--Select Taluka--</option>
        </select>
      </div>

      <div class="col-md-6">
        <label>Village</label>
        <select name="village" id="village" class="form-select">
          <option value="">--Select Village--</option>
        </select>
      </div>

      <div class="col-12">
        <label>Full Address</label>
        <textarea name="address" id="address" class="form-control" placeholder="Enter your full address"></textarea>
      </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-4">
      <a href="login.jsp" class="text-decoration-none fw-semibold" style="color:#1E90FF;">Back to Login</a>
      <button type="submit" class="btn btn-success px-4">Register</button>
    </div>
  </form>
</div>

<script>
$(document).ready(function() {
  // When State changes → load Districts
  $("#state").change(function() {
    var stateId = $(this).val();
    $("#district, #taluka, #village").html("<option value=''>--Select--</option>");
    if (stateId === "") return;

    $.ajax({
      url: "farmerRegistration.jsp",
      type: "GET",
      data: { action: "district", stateId: stateId },
      success: function(data) {
        $("#district").html(data);
      }
    });
  });

  // When District changes → load Talukas
  $("#district").change(function() {
    var districtId = $(this).val();
    $("#taluka, #village").html("<option value=''>--Select--</option>");
    if (districtId === "") return;

    $.ajax({
      url: "farmerRegistration.jsp",
      type: "GET",
      data: { action: "taluka", districtId: districtId },
      success: function(data) {
        $("#taluka").html(data);
      }
    });
  });

  // When Taluka changes → load Villages
  $("#taluka").change(function() {
    var talukaId = $(this).val();
    $("#village").html("<option value=''>--Select--</option>");
    if (talukaId === "") return;

    $.ajax({
      url: "farmerRegistration.jsp",
      type: "GET",
      data: { action: "village", talukaId: talukaId },
      success: function(data) {
        $("#village").html(data);
      }
    });
  });
});
</script>

<%
  // ✅ Handle AJAX requests directly inside same JSP
  String action = request.getParameter("action");
  if (action != null) {
      Connection con = null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      try {
          con = DBConnection.getConnection();
          if ("district".equals(action)) {
              String stateId = request.getParameter("stateId");
              ps = con.prepareStatement("SELECT district_id, district_name FROM district WHERE state_id=?");
              ps.setInt(1, Integer.parseInt(stateId));
              rs = ps.executeQuery();
              while (rs.next()) {
                  out.print("<option value='" + rs.getInt("district_id") + "'>" + rs.getString("district_name") + "</option>");
              }
          } else if ("taluka".equals(action)) {
              String districtId = request.getParameter("districtId");
              ps = con.prepareStatement("SELECT taluka_id, taluka_name FROM taluka WHERE district_id=?");
              ps.setInt(1, Integer.parseInt(districtId));
              rs = ps.executeQuery();
              while (rs.next()) {
                  out.print("<option value='" + rs.getInt("taluka_id") + "'>" + rs.getString("taluka_name") + "</option>");
              }
          } else if ("village".equals(action)) {
              String talukaId = request.getParameter("talukaId");
              ps = con.prepareStatement("SELECT village_id, village_name FROM village WHERE taluka_id=?");
              ps.setInt(1, Integer.parseInt(talukaId));
              rs = ps.executeQuery();
              while (rs.next()) {
                  out.print("<option value='" + rs.getInt("village_id") + "'>" + rs.getString("village_name") + "</option>");
              }
          }
      } catch (Exception e) {
          out.print("<option>Error loading data</option>");
      } finally {
          if (rs != null) rs.close();
          if (ps != null) ps.close();
          if (con != null) con.close();
      }
      return; // prevent rest of page from reloading
  }
%>

</body>
</html>
 --%>