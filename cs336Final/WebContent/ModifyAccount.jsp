<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modify Account</title>
</head>
<body>
	<h1>Change Your Account Settings Here</h1>
	
	<div>
		<p>Delete Account</p>
		<form method="post" action="DeleteAttempt.jsp">
			<input type="submit" value="Delete Account" onclick="return confirm('Are you sure you want to continue?')" />
		</form>
		<br/>
	</div>
	
	<div>
		<p>Change Password</p>
		<form method="post" action="ChangePassword.jsp">
		<input type="text" name="changePassword" value="New Password" 
			onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="submit" value="Change Password" onclick="return confirm('Are you sure you want to continue?')"/>
		</form>
	
	</div>
	
</body>
</html>