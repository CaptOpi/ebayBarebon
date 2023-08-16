<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Account Creation</title>
</head>
<body>
	<%
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	try{
		String username = (String)request.getParameter("Username");
		String password = (String)request.getParameter("Password");
		
		
		String str = "INSERT INTO Staff (Username, Staff_Password) VALUES (?, ?)";
		PreparedStatement ps = con.prepareStatement(str);
		ps.setString(1, username);
		ps.setString(2, password);
		ps.executeUpdate();
		String str2 = "SELECT Staff_ID FROM Staff WHERE Username=? AND Staff_Password=?";
		PreparedStatement ps2 = con.prepareStatement(str2);
		ps2.setString(1, username);
		ps2.setString(2, password);
		ResultSet staff = ps2.executeQuery();
		while(staff.next()){
			String str3 = "INSERT INTO Customer_Representatives VALUES (?)";
			PreparedStatement ps3 = con.prepareStatement(str3);
			ps3.setInt(1, staff.getInt("Staff_ID"));
			ps3.executeUpdate();
		}
		
		response.sendRedirect("AdminScreen.jsp");
		
		con.close();
	}catch (SQLException e) {
        out.println("Failed to create account");
        con.close();
        
    }
	
	
	%>
</body>
</html>