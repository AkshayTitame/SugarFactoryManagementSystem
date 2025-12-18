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
  width: 8%;
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


<h2 align="center">List of Gat Officer Pending for Approval</h2>
<form action="ApproveGatOfficer" method="post">
<table>
<thead>
<td><h4>Select</h4></td>
<td><h4>Gat Officer Name</h4></td>
<td><h4>Gat Officer Employee ID</h4></td>
<td><h4>Mobile Number</h4></td>

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
statement=con.createStatement();
String sql ="select * from gatofficer where status=0";
resultSet = statement.executeQuery(sql);


while(resultSet.next()){
%>
<tr>
<td><input type="checkbox" value= <%=resultSet.getString("gatofficerID")%> name="gatofficerID"></td>
<td><%=resultSet.getString("gatOfficerName")%></td>
<td><%=resultSet.getString("empID")%></td>
<td><%=resultSet.getString("mobile")%></td>

</tr>
<%
}



con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>

</table>

<p align="center"><input type="submit" value="ApproveGatOfficer">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button formaction="adminDashboard.jsp">Cancel</button>
</p>

</form>

</div>

</body>
</html>