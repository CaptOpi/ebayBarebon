<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Home</title>
</head>
<body>
<div> 
	<h1>Welcome Back Customer Representative:</h1>
	<br/>
	<%
		out.println(session.getAttribute("user"));
	%>
</div>

<div>
	<form method="post" action="SearchAttempt.jsp">
		<input type="text" name="searchField" value="Search Items" 
			onfocus="this.value==this.defaultValue?this.value='':null"/>
		<input type="submit" name="searchButton" value="Enter"/>
	</form>
</div>

<div>
	<form method="post" action="LogoutAttempt.jsp">
		<input type="submit" value="Logout Here"/>
	</form>
	
</div>
<div>
	<h2>Modify User Accounts:</h2>
	<form method="post" action="SearchUsers.jsp">
			<input type="text" name="searchField" value="Search User" 
				onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="submit" name="searchButton" value="Enter"/>
	</form>
</div>
<div>
	<h2>Answer Active User Questions:</h2>
	<form method="post" action="DisplayQuestions.jsp">
		<input type="hidden" name="Mode" value="Staff">
		<input type="text" name="searchQuestions" value="Search By User">
		<input type="submit" name="searchButton" value="Search Questions"/>
	</form>
		
</div>

</body>
</html>