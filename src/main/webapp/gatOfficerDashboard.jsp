<!DOCTYPE html>
<html lang="mr">
<head>
<meta charset="utf-8" />
<title>Admin Home Page</title>

<style>

body{
text-align:center;
background-color:pink;
}


.button {
  display: inline-block;
  border-radius: 4px;
  background-color: #f4511e;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 28px;
  padding: 20px;
  width: 400px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
  }  

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}
.column1{
float:left;
width:49%;
}

.column2{
float:right;
width:49%;
}


</style>
</head>
<body>


<%
String student=null;
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("studentObject")==null){
    response.sendRedirect("loginPage.html");
}else{
student=(String)session.getAttribute("studentObject");
//student=(Student) request.getAttribute("studentObject");
System.out.println("Customer ID is:- "+student);
}
%>


<h2>Gat Officer Dashboard</h2>
<div class="column1">
<button class="button" style="vertical-align:middle" onclick="window.location.href='gatFarmerApproval.jsp';"><span>Approve Farmer Registration</span></button>
<br><br>
<button class="button" style="vertical-align:middle" onclick="window.location.href='gatFarmerList.jsp';"><span>View Farmer List</span></button>
<br><br>   
<button class="button" style="vertical-align:middle" onclick="window.location.href='gatCaneApproval.jsp';"><span>Approve Farmer Cane Registration</span></button>
<br><br>  
<button class="button" style="vertical-align:middle" onclick="window.location.href='index.html';"><span>Logout</span></button>
<br><br>  

</div>






</body>
</html>
