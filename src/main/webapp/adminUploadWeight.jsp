<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gat Officer Approval</title>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
body{
background-color: #ccfff2
;
}



.links{
text-align:center;
color:red;
}

.user{
text-align:right;
color:red;
}


input[type=submit] {
  background-color:  #008080;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100px;
}

button {
  background-color:  #800000;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 8%;
}

</style>
</head>
<body>


<%


String p=null;
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("farmerList")==null){
    response.sendRedirect("adminDashboard.jsp");
}else{
	p=(String)session.getAttribute("farmerList");
//student=(Student) request.getAttribute("studentObject");

}
%>


<h2 align="center">List of Cane Registration Pending for Approval</h2>
<table>
<thead>
<td><h4>Reg No.</h4></td>
<td><h4>Farmer Name</h4></td>
<td><h4>Uttara Number</h4></td>
<td><h4>Area</h4></td>

<td><h4>Cane Type ID</h4></td>
<td><h4>Weight</h4></td>
<td><h4>Click to Upload</h4></td>

</thead>
<%
//String id = request.getParameter("userid");

Statement statement = null;
ResultSet resultSet = null;
%>

<%
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "sugarFactory";
String userid = "root";
String password = "123456";
try{
	Connection con=null;
	Statement st=null;
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(connectionUrl+database, userid, password);
	statement=con.createStatement();
	
	//String sql ="select c. from caneregistration c where gatOfficerStatus=1 and adminStatus=1 and areaID='"+p+"' and weight>0";
	
	String sql ="select c.registrationNo,c.uttaraNo,c.area,f.farmerName,t.caneTypeName from caneregistration c,farmer f, canetype t  where c.farmerID=f.farmerID and c.caneTypeID=t.caneTypeId and c.gatOfficerStatus=1 and c.adminStatus=1 and c.areaID='"+p+"' and c.weight=0";

	System.out.println("QUERY:-"+sql);
	
	resultSet = statement.executeQuery(sql);


while(resultSet.next()){
%>
<form action="CaneWeightRegistration" method="post">
<tr>
<input type="hidden" value=<%=p%> name="areaID">
<input type="hidden" value=<%=resultSet.getString("registrationNo")%> name="registrationNo">

<td><%=resultSet.getString("registrationNo")%></td>
<td><%=resultSet.getString("farmerName")%></td>
<td><%=resultSet.getString("uttaraNo")%></td>
<td><%=resultSet.getString("area")%></td>

<td><%=resultSet.getString("caneTypeName")%></td>
<td><input type="text" name="caneweight"></td>
<td><input type="submit" value="Upload"></td>

</tr>
</form>

<%
}



con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>

</table>
<a href="adminDashboard.jsp">Home Page</a>

</p>


</div>

</body>
</html>