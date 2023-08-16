<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<div> 
	<h1>Login To Auctions</h1>
</div>
<br/>
<div> 
	<form method="post" action="LoginAttempt.jsp">
		<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
	</form>
	<br/>
	<% 	String incorrect_password = (String)session.getAttribute("incorrect");
		if(incorrect_password == "true"){
			out.println("Incorrect Username and-or Password");
		}%>

</div>
<div>
	<form method="post" action="CreateAttempt.jsp">
		<input type="submit" value="Create Account"/>
	</form>
</div>
</body>
</html>