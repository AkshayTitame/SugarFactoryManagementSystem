<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
    <%@page import="com.connection.DBConnection"%>
<%@page import="java.text.*"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea, number {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
}


input[type=password]{
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
}


input[type=date]{
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
}

input[type=submit] {
    background-color: #4CAF50;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=submit]:hover {
    background-color: #45a049;
}

.container {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}
</style>
</head>
<body>

<h3>Gat Officer Registration Form</h3>

<div class="container">
  <form action="GatOfficerRegistration" method="post">
  
   <label for="username">Gat Officer Name</label>
    <input type="text" id="lname" name="gatOfficerName" placeholder="Gat Officer Name" required>
  
     <label for="enroll">Mobile Number</label>
    <input type="text" id="lname" name="mobile" placeholder="Mobile Number" required>
  
   <label for="empID">Employee Number</label><br><br>
    <input type="number" id="lname" name="empID" placeholder="Employee Number" required>
  
    <br>
     <br>
       <label for="dob">Area</label>
    <select name="areaID">
    
    
    <%
//String id = request.getParameter("userid");

ResultSet resultSet = null;

try{
	 Connection con=null;
     Statement st=null;
     DBConnection dbCon = new DBConnection();
     con = dbCon.geConnection();
		try {
			st=con.createStatement();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	
String sql ="select * from area";
resultSet = st.executeQuery(sql);
while(resultSet.next()){
	
%>
<option value=<%=resultSet.getInt("areaID") %>><%=resultSet.getString("areaName") %></option>


<%
}

con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>
    
    
    </select>
    
    
    
<label for="password">Password</label>
    <input type="password" id="lname" name="password" placeholder="Password" required>
  

   
    <input type="submit" value="Submit">
  </form>
</div>

</body>
</html>
