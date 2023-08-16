<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View/Create Alerts</title>
</head>
<body>
<div class="home-button">
	<a href="HomeScreen.jsp">Go back to Home Screen</a>
</div>
<div>
	<h1>Alerts Page</h1>
</div>
<a href="CreateAlert.jsp"><button>Create New Alert</button></a>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String sqlFalse = "SELECT Alert_ID, Vehicle_Type, Vehicle_Make, Vehicle_Color, Vehicle_Condition FROM Alerts WHERE User_ID = ? AND Alerted = false";
	PreparedStatement stmtFalse = con.prepareStatement(sqlFalse);
	stmtFalse.setInt(1, (Integer) session.getAttribute("User_ID"));
	ResultSet resultFalse = stmtFalse.executeQuery();
%>
<h2>Current Alerts</h2>
<%
	if (!resultFalse.next()) {
%>
<p>No current alerts.</p>
<%
	} else {
%>
<table>
	<tr>
		<th>Alert ID</th>
		<th>Vehicle Type</th>
		<th>Vehicle Make</th>
		<th>Vehicle Color</th>
		<th>Vehicle Condition</th>
	</tr>
	<%
		do {
			int alertID = resultFalse.getInt("Alert_ID");
			String vehicleType = resultFalse.getString("Vehicle_Type");
			String vehicleMake = resultFalse.getString("Vehicle_Make");
            String vehicleColor = resultFalse.getString("Vehicle_Color");
			String vehicleCondition = resultFalse.getString("Vehicle_Condition");
	%>
	<tr>
        <td><%= alertID %></td>
        <td><%= vehicleType %></td>
        <td><%= vehicleMake %></td>
        <td><%= vehicleColor %></td>
        <td><%= vehicleCondition %></td>
    </tr>
    <%
		} while (resultFalse.next());
		resultFalse.close();
		stmtFalse.close();
	%>
</table>
<%
	}
%>

<%
	String sqlTrue = "SELECT Alert_ID, Vehicle_Type, Vehicle_Make, Vehicle_Color, Vehicle_Condition FROM Alerts WHERE User_ID = ? AND Alerted = true";
	PreparedStatement stmtTrue = con.prepareStatement(sqlTrue);
	stmtTrue.setInt(1, (Integer) session.getAttribute("User_ID"));
	ResultSet resultTrue = stmtTrue.executeQuery();
%>
<h2>Alerts With Auctions Found</h2>
<%
	if (!resultTrue.next()) {
%>
<p>No current alerts.</p>
<%
	} else {
%>
<form method="post">
	<input type="submit" name="clearTrueAlerts" value="Clear Alerts">
</form>
<%
	if (request.getParameter("clearTrueAlerts") != null) {
		String clearSql = "DELETE FROM Alerts WHERE User_ID = ? AND Alerted = true";
		PreparedStatement clearStmt = con.prepareStatement(clearSql);
		clearStmt.setInt(1, (Integer) session.getAttribute("User_ID"));
		clearStmt.executeUpdate();
		clearStmt.close();
		response.sendRedirect("HomeScreen.jsp");
	}
%>
<table>
	<tr>
		<th>Alert ID</th>
		<th>Vehicle Type</th>
		<th>Vehicle Make</th>
		<th>Vehicle Color</th>
		<th>Vehicle Condition</th>
	</tr>
	<%
		do {
			int alertID = resultTrue.getInt("Alert_ID");
			String vehicleType = resultTrue.getString("Vehicle_Type");
			String vehicleMake = resultTrue.getString("Vehicle_Make");
            String vehicleColor = resultTrue.getString("Vehicle_Color");
			String vehicleCondition = resultTrue.getString("Vehicle_Condition");
	%>
	<tr>
        <td><%= alertID %></td>
        <td><%= vehicleType %></td>
        <td><%= vehicleMake %></td>
        <td><%= vehicleColor %></td>
        <td><%= vehicleCondition %></td>
    </tr>
    <%
		} while (resultTrue.next());
		resultTrue.close();
		stmtTrue.close();
		con.close();
	%>
</table>
<%
	}
%>
</body>
</html>