<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%> 
        <%@page import="com.farmer.Farmer"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirmation</title>
<style type="text/css">
body{
background-color:#F3F16A;
}

#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 1000px;
  
  margin-left:auto; 
    margin-right:auto;
}

#customers td, #customers th {
  border: 0px solid #ddd;
  padding: 8px;
}


#customers tr:hover {background-color: #ddd;}


#customers td {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color:white;
  color: black;
  width:150px;
  font-size:30px;
}




#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: white;
  color: brown;
    width:150px;
      font-size:30px;
    
  
}

h1{
text-align:center;
color:green;
}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 10px 16px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  margin: 4px 2px;
  cursor: pointer;
}

.button1 {
  border: none;
  color: white;
  padding: 10px 16px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  margin: 4px 2px;
  cursor: pointer;
}

.button2 {background-color: #008CBA;} /* Blue */
.button3 {background-color: #f44336;} /* Red */ 
.button4 {background-color: voilet; } /* Gray */ 
.button5 {background-color: #555555;} /* Black */
.button6 {background-color: #4A235A;} /* voilet */

</style>
</head>
<body>

<h1>Please Check the Below Information and Confirm-</h1>

<%


Farmer p=null;
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("studentObject")==null){
    response.sendRedirect("index.jsp");
}else{
	p=(Farmer)session.getAttribute("studentObject");
//student=(Student) request.getAttribute("studentObject");

}
%>
<table id="customers">
   

<tr>
<th>Farmer Name :</th>
<td><%=p.getFarmerName()%></td>
</tr>


<tr>
<th>Farmer Mobile :</th>
<td><%=p.getMobile()%></td>
</tr>




<tr>
<td>
<form action="DeleteRegistration" method="post">
<input type="hidden" value=<%=p.getMobile()%> name="mobile">

<input type="submit" class="button1 button3" value="Delete">
</form>
</td>
<td>
<form action="ConfirmRegistration" method="post">
<input type="hidden" value=<%=p.getMobile()%> name="mobile">
<input type="submit" class="button1 button2" value="Register">
</form>
</td>


</tr>
</table>





<h1>Please Do not Refresh this Page.</h1>


</body>
</html>