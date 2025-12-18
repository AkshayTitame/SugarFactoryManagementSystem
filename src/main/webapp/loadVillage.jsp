<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnection" %>
<%
    // Handle AJAX request for villages
    String gatId = request.getParameter("gat_id");
    if(gatId != null && !gatId.isEmpty()) {
        response.setContentType("text/html;charset=UTF-8");
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT village_id, village_name FROM village WHERE gat_office_id = ?"
            );
            ps.setInt(1, Integer.parseInt(gatId));
            ResultSet rs = ps.executeQuery();

            boolean found = false;
            while(rs.next()) {
                found = true;
                out.println("<option value='" + rs.getInt("village_id") + "'>" + rs.getString("village_name") + "</option>");
            }
            if(!found){
                out.println("<option value=''>No villages found</option>");
            }

            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            
            out.println("<option value=''>Error loading villages</option>");
        }
        return; // stop normal HTML rendering for AJAX
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Gat → Village Demo</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>Gat Office → Village Dynamic Loading</h2>

<label>Gat Office:</label>
<select id="gat_office_id">
    <option value="">--Select Gat--</option>
    <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement psGat = con.prepareStatement("SELECT * FROM gat_office");
            ResultSet rsGat = psGat.executeQuery();
            while(rsGat.next()) {
    %>
        <option value="<%=rsGat.getInt("gat_office_id")%>"><%=rsGat.getString("gat_office_name")%></option>
    <%
            }
            rsGat.close();
            psGat.close();
            con.close();
        } catch(Exception e) {
          
        }
    %>
</select>

<br><br>

<label>Village:</label>
<select id="village_id">
    <option value="">--Select Village--</option>
</select>

<script>
$(document).ready(function() {
    $("#gat_office_id").change(function() {
        var gatId = $(this).val();
        if(gatId !== "") {
            $.ajax({
                url: "", // same file
                type: "GET",
                data: { gat_id: gatId },
                success: function(response) {
                    $("#village_id").html('<option value="">--Select Village--</option>' + response);
                },
                error: function(xhr, status, error) {
                    alert("Error loading villages: " + error);
                }
            });
        } else {
            $("#village_id").html('<option value="">--Select Village--</option>');
        }
    });
});
</script>

</body>
</html>
