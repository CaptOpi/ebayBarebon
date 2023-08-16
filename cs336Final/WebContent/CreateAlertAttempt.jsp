<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Alert Script</title>
</head>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String vehicleType = request.getParameter("type");
    String vehicleMake = request.getParameter("make");
    String vehicleColor = request.getParameter("color");
    String vehicleCondition=request.getParameter("condition");
	
	String sql = "INSERT INTO Alerts (User_ID, Vehicle_Type, Vehicle_Make, Vehicle_Color, Vehicle_Condition, Alerted, Notification)" + "VALUES (?,?,?,?,?,?,?)";
	
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setInt(1, (Integer) session.getAttribute("User_ID"));
	stmt.setString(2,vehicleType);
	stmt.setString(3,vehicleMake);
	stmt.setString(4,vehicleColor);
	stmt.setString(5,vehicleCondition);
	stmt.setBoolean(6, false);
	stmt.setString(7,"Your item is available!");
	stmt.executeUpdate();
	stmt.close();
	con.close();
	response.sendRedirect("ViewAlerts.jsp");
%>
<body>
</body>
</html>