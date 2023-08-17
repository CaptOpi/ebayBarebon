<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Change Password</title>
</head>
<body>
 <%
 	String Username = request.getParameter("Username");
 	String newPassword = request.getParameter("Password");
	if (Username == null || Username.isEmpty()) {
    	Username = (String) session.getAttribute("user");
	}
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String str = "UPDATE End_Users SET User_Password=? WHERE Username=?";
	PreparedStatement ps = con.prepareStatement(str);
	ps.setString(1, newPassword);
	ps.setString(2, Username);
	ps.executeUpdate();
	response.sendRedirect("AccountOverview.jsp");
	con.close();
			
 %>
</body>
</html>