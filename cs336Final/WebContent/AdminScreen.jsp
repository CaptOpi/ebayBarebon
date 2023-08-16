<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrator Home</title>
</head>
<body>
<div> 
	<h1>Welcome Back Administrator:</h1>
	<br/>
	<%
		out.println(session.getAttribute("user"));
	%>
</div>

<div>
<h3>Create Customer Representative Accounts</h3>
<form method="post" action="CreateRepAccount.jsp"> 
	<input type="text" name="Username" value="New Username" 
			onfocus="this.value==this.defaultValue?this.value='':null">
	<input type="text" name="Password" value="New Password" 
			onfocus="this.value==this.defaultValue?this.value='':null">
	<input type="submit" name="createButton" value="Create" onclick="return confirm('Are you sure you want to continue?')"/>
</form>

</div>

<div>
<h3>Generate Summary Sales Report</h3>
<form method="post" action="GenerateReport.jsp"> 
	<input type="submit" name="salesButton" value="Generate"/>
</form>
</div>
<div>
	<form method="post" action="LogoutAttempt.jsp">
		<input type="submit" value="Logout"/>
	</form>
</div>
</body>
</html>