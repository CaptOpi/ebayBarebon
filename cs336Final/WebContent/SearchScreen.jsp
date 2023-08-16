<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link href="styles.css" rel="stylesheet" type="text/css" />
    <title>Search Results</title>
</head>
<body>
	<div class="home-button">
        <a href="HomeScreen.jsp">Go back to Home Screen</a>
    </div>
    <%
    // Retrieve search criteria from form submission
    String type = (String) session.getAttribute("type");
    String make = (String) session.getAttribute("make");
    String color = (String) session.getAttribute("color");
    Integer yearInteger = (Integer) session.getAttribute("year");
    String year = (yearInteger != null) ? yearInteger.toString() : "";
    String condition = (String) session.getAttribute("condition");
    Integer mileageInteger = (Integer) session.getAttribute("mileage");
    String mileage = (mileageInteger != null) ? mileageInteger.toString() : "";
    Integer mpgInteger = (Integer) session.getAttribute("mpg");
    String mpg = (mpgInteger != null) ? mpgInteger.toString() : "";
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();

    String querySearch = "SELECT * FROM Item_Auction WHERE Sold_Price = 0";

    // Create an ArrayList to store conditions
    ArrayList<String> conditions = new ArrayList<>();

    if (type != null && !type.trim().isEmpty()) {
        conditions.add("Vehicle_Type LIKE '%" + type + "%'");
    }
    if (make != null && !make.trim().isEmpty()) {
        conditions.add("Vehicle_Make LIKE '%" + make + "%'");
    }
    if (color != null && !color.trim().isEmpty()) {
        conditions.add("Vehicle_Color LIKE '%" + color + "%'");
    }
    if (year != null && !year.trim().isEmpty()) {
        conditions.add("Vehicle_Year LIKE '%" + year + "%'");
    }
    if (condition != null && !condition.trim().isEmpty()) {
        conditions.add("Vehicle_Condition LIKE '%" + condition + "%'");
    }
    if (mileage != null && !mileage.trim().isEmpty()) {
        int mileageValue = Integer.parseInt(mileage);
        conditions.add("Vehicle_Mileage <= " + mileageValue);
    }
    if (mpg != null && !mpg.trim().isEmpty()) {
        conditions.add("Vehicle_MPG LIKE '%" + mpg + "%'");
    }
    if (!conditions.isEmpty()) {
    	querySearch += " AND (" + String.join(" AND ", conditions) + ")";
	}
    ResultSet result = stmt.executeQuery(querySearch);
    %>
    <div class="search-results-container">
        <h1>Search Results</h1>
        <table>
            <tr>
                <th>Type</th>
                <th>Make</th>
                <th>Color</th>
                <th>Year</th>
                <th>Condition</th>
                <th>Mileage</th>
                <th>MPG</th>
                <th>Initial Price</th>
                <th>Current Price</th>
                <th>Close Date</th>
                <th>Close Time</th>
            </tr>
            <%
            boolean results = false;
            while (result.next()) {
            	results = true;
                String resultType = result.getString("Vehicle_Type");
                String resultMake = result.getString("Vehicle_Make");
                String resultColor = result.getString("Vehicle_Color");
                int resultYear = result.getInt("Vehicle_Year");
                String resultCondition = result.getString("Vehicle_Condition");
                int resultMileage = result.getInt("Vehicle_Mileage");
                int resultMPG = result.getInt("Vehicle_MPG");
                double resultInitialPrice = result.getDouble("Initial_Price");
                double resultCurrentPrice = result.getDouble("Current_Price");
                Date resultCloseDate = result.getDate("Close_Date");
                Time resultCloseTime = result.getTime("Close_Time");
            %>
            <tr>
                <td><%= resultType %></td>
                <td><%= resultMake %></td>
                <td><%= resultColor %></td>
                <td><%= resultYear %></td>
                <td><%= resultCondition %></td>
                <td><%= resultMileage %></td>
                <td><%= resultMPG %></td>
                <td><%= resultInitialPrice %></td>
    			<td><%= resultCurrentPrice %></td>
    			<td><%= resultCloseDate %></td>
    			<td><%= resultCloseTime %></td>
    			<td>
                    <form action="ViewAuction.jsp" method="get">
                        <input type="hidden" name="itemId" value="<%= result.getInt("Item_ID") %>">
                        <button type="submit">View Auction</button>
                    </form>
                </td>
            </tr>
            <%
            }
            result.close();
            stmt.close();
            con.close();
            %>
            <%
			session.setAttribute("type", null);
			session.setAttribute("make", null);
			session.setAttribute("color", null);
			session.setAttribute("year", null);
			session.setAttribute("condition", null);
			session.setAttribute("mileage", null);
			session.setAttribute("mpg", null);
			%>
        </table>
        <%
			if (!results) {
				%>
				<table><tr>No Results Found</tr></table>
				<%
			}
			%>
    </div>
</body>
</html>