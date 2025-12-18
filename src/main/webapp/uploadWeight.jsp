<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.DBConnection"%>
<%@page import="java.text.*"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
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

<h3>Upload Cane Weight</h3>

<div class="container">
  <form action="CaneWeightRegistration" method="post">
  
       <label for="dob">Select Area</label>
    
     <select name="area">
    
    
    <%
//String id = request.getParameter("userid");

ResultSet resultSet1 = null;

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
resultSet1 = st.executeQuery(sql);
while(resultSet1.next()){
	
%>
<option value=<%=resultSet1.getInt("areaID") %>><%=resultSet1.getString("areaName") %></option>


<%
}

con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>
        </select>
  
  
  
  
  
  
  <label for="dob">Select Farmer</label>
    
     <select name="area">
    
    
    <%
//String id = request.getParameter("userid");

ResultSet resultSet2 = null;

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
	
String sql ="select * from farmer";
resultSet2 = st.executeQuery(sql);
while(resultSet1.next()){
	
%>
<option value=<%=resultSet2.getInt("farmerID") %>><%=resultSet2.getString("farmerName") %></option>


<%
}

con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>
    
    
    </select>
  
  
  
  
  
  <label for="enroll">Sugarcane Type</label>
   <br>    
     <select name="sugarCaneType">
    
    
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
	
String sql ="select * from caneType";
resultSet = st.executeQuery(sql);
while(resultSet.next()){
	
%>
<option value=<%=resultSet.getInt("caneTypeID") %>><%=resultSet.getString("caneTypeName") %></option>


<%
}

con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>
    
    </select>
    
    
    
  
  <label for="enroll">Select Registered Cane</label>
   <br>    
     <select name="sugarCaneType">
    
    
    <%
//String id = request.getParameter("userid");

ResultSet resultSet3 = null;

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
	
String sql ="select * from caneregistration";
resultSet3 = st.executeQuery(sql);
while(resultSet.next()){
	
%>
<option value=<%=resultSet3.getInt("registrationNo") %>><%=resultSet3.getString("registrationNo") %>-<%=resultSet3.getString("uttaraNo") %></option>


<%
}

con.close();
} catch (Exception e) {
e.printStackTrace();
}

%>
    
    </select>
    
    
    
      <label for="enroll">Enter Weight</label>
    <input type="text" id="lname" name="caneweight" placeholder="Cane Weight" required>
 
     
    <input type="submit" value="Submit">
  </form>
</div>

</body>
</html>
