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
    <title>View Auction</title>
</head>
<body>
    <div class="home-button">
        <a href="HomeScreen.jsp">Go back to Home Screen</a>
    </div>
    <%
    int itemId = Integer.parseInt(request.getParameter("itemId"));
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();

    String query = "SELECT * FROM Item_Auction WHERE Item_ID = " + itemId;
    ResultSet result = stmt.executeQuery(query);
    if (result.next()) {
        String resultType = result.getString("Vehicle_Type");
        String resultMake = result.getString("Vehicle_Make");
        String resultColor = result.getString("Vehicle_Color");
        int resultYear = result.getInt("Vehicle_Year");
        String resultCondition = result.getString("Vehicle_Condition");
        int resultMileage = result.getInt("Vehicle_Mileage");
        int resultMPG = result.getInt("Vehicle_MPG");
        double resultInitialPrice = result.getDouble("Initial_Price");
        double resultCurrentPrice = result.getDouble("Current_Price");
        java.util.Date resultCloseDate = result.getDate("Close_Date");
        Time resultCloseTime = result.getTime("Close_Time");
        
        
        
        String similarAuctionsQuery = "SELECT * FROM Item_Auction " +
                "WHERE Sold_Price = 0 AND " +
                "Vehicle_Type = ? AND Vehicle_Make = ? AND Item_ID <> ?";

		PreparedStatement similarAuctionsStatement = con.prepareStatement(similarAuctionsQuery);
		similarAuctionsStatement.setString(1, resultType);
		similarAuctionsStatement.setString(2, resultMake);;
		similarAuctionsStatement.setInt(3, itemId);
		
		ResultSet similarAuctionsResult = similarAuctionsStatement.executeQuery();

		if (similarAuctionsResult.next()) {
			%>
			<div class="similar-auctions-container">
				<h2>Similar Auctions</h2>
				<ul>
			<%
			do {
				int similarItemId = similarAuctionsResult.getInt("Item_ID");
				String similarItemMake = similarAuctionsResult.getString("Vehicle_Make");
				String similarItemType = similarAuctionsResult.getString("Vehicle_Type");
			%>
				<li><a href="ViewAuction.jsp?itemId=<%= similarItemId %>"><%= similarItemMake %> <%= similarItemType %></a></li>
			<%
			} while (similarAuctionsResult.next());
			%>
			</ul>
			</div>
			<%
		}
		similarAuctionsResult.close();
		similarAuctionsStatement.close();
        %>
        <div class="vehicle-auction-container">
            <h1>Auction Details</h1>
            <table>
                <tr><th>Type</th><td><%= resultType %></td></tr>
                <tr><th>Make</th><td><%= resultMake %></td></tr>
                <tr><th>Color</th><td><%= resultColor %></td></tr>
                <tr><th>Year</th><td><%= resultYear %></td></tr>
                <tr><th>Condition</th><td><%= resultCondition %></td></tr>
                <tr><th>Mileage</th><td><%= resultMileage %></td></tr>
                <tr><th>MPG</th><td><%= resultMPG %></td></tr>
                <tr><th>Initial Price</th><td><%= resultInitialPrice %></td></tr>
                <tr><th>Current Price</th><td><%= resultCurrentPrice %></td></tr>
                <tr><th>Close Date</th><td><%= resultCloseDate %></td></tr>
                <tr><th>Close Time</th><td><%= resultCloseTime %></td></tr>
            </table>
        </div>
        <%
    } else {
        %>
        <div>No details available for this vehicle.</div>
        <%
    }
    result.close();
    stmt.close();
    con.close();
    %>
    <form action="CreateBid.jsp" method="post">
    	<input type="hidden" name="itemId" value="<%= itemId %>">
    	<label for="bidAmount">Enter bid amount:</label>
    	<input type="number" id="bidAmount" name="bidAmount" step="0.01" required>
    	<button type="submit">Place Bid</button>
    	<label for="upperLimit">Upper Limit:</label>
    	<input type="number" id="upperLimit" name="upperLimit" step="0.01">
	</form>
    <div class="bids-history-container">
        <h2>Bids History</h2>
        <table>
            <tr>
                <th>Amount</th>
                <th>Buyer Username</th>
            </tr>
            <%
            ApplicationDB dbs = new ApplicationDB();
            Connection cons = dbs.getConnection();
            Statement stmts = cons.createStatement();

            int itemIds = Integer.parseInt(request.getParameter("itemId"));
            String bidsQuery = "SELECT Bids.Amount, End_Users.Username " +
                               "FROM Bids " +
                               "JOIN End_Users ON Bids.Buyer_ID = End_Users.User_ID " +
                               "WHERE Bids.Item_ID = " + itemIds +
                               " ORDER BY Bids.Amount DESC";
            ResultSet bidsResult = stmts.executeQuery(bidsQuery);

            while (bidsResult.next()) {
                double bidAmount = bidsResult.getDouble("Amount");
                String buyerUsername = bidsResult.getString("Username");
            %>
            <tr>
                <td><%= bidAmount %></td>
                <td><%= buyerUsername %></td>
            </tr>
            <%
            }

            bidsResult.close();
            stmts.close();
            cons.close();
            %>
        </table>
    </div>
</body>
</html>