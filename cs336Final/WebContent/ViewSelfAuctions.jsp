<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Seller Auctions</title>
</head>
<body>
	<div class="search-results-container">
		<h1>User Auctions</h1>
		<table>
            <tr>
            	<th>Vehicle Type</th>
            	<th>Vehicle Make</th>
            	<th>Vehicle Color</th>
            	<th>Year</th>
            	<th>Vehicle Condition</th>
                <th>Initial Price</th>
                <th>Current Price</th>
                <th>Secret Minimum</th>
            </tr>
            <%
            	ApplicationDB db = new ApplicationDB();	
        		Connection con = db.getConnection();
        		boolean auctionfound = false;
            	String str2 = "SELECT i.Vehicle_Make, i.Vehicle_Color, i.Vehicle_Year, i.Vehicle_Condition, i.Initial_Price, i.Current_Price, i.Secret_Min, i.Vehicle_Type FROM Item_Auction i WHERE i.Seller_ID=?";
            	PreparedStatement ps2 = con.prepareStatement(str2);
            	ps2.setInt(1, (Integer) session.getAttribute("User_ID"));
            	ResultSet auctions = ps2.executeQuery();
            
            	while(auctions.next()){
            		auctionfound = true;
            		Float InitialPrice = auctions.getFloat("Initial_Price");
            		Float CurrentPrice = auctions.getFloat("Initial_Price");
            		Float SecretMin = auctions.getFloat("Secret_Min");
            		String type = auctions.getString("Vehicle_Type");
            		String color = auctions.getString("Vehicle_Color");
            		String make = auctions.getString("Vehicle_Make");
            		String year = auctions.getString("Vehicle_Year");
            		String condition = auctions.getString("Vehicle_Condition");
            %>
            <tr>
            	<td><%= type %></td>
            	<td><%= color %></td>
            	<td><%= make %></td>
            	<td><%= year %></td>
            	<td><%= condition %></td>
                <td><%= InitialPrice %></td>
                <td><%= CurrentPrice %></td>
                <td><%= SecretMin %></td>
            </tr>
            <%
    		 	}
                auctions.close(); // Close the current ResultSet
            if (!auctionfound) {
            %>
            <tr>
                <td>No Auctions Found For User</td>
            </tr>
            <%
            }
                ps2.close();
                con.close();
            %>
		</table>
	</div>
	
	<div class="search-results-container">
		<h1>Won Auctions</h1>
		<table>
            <tr>
            	<th>Item_ID</th>
            	<th>Bought Amount</th>
            	
                 <%
            	ApplicationDB db2 = new ApplicationDB();	
        		Connection con2 = db2.getConnection();
        		boolean auctionfound2 = false;
            	String str3 = "SELECT Item_ID, Sold_Price FROM Buyers WHERE User_ID=?";
            	PreparedStatement ps3 = con2.prepareStatement(str3);
            	ps3.setInt(1, (Integer) session.getAttribute("User_ID"));
            	ResultSet auctions2 = ps3.executeQuery();
            
            	while(auctions2.next()){
            		auctionfound2 = true;
            		Double amount = auctions2.getDouble("Sold_Price");
            		Integer ItemID = auctions2.getInt("Item_ID");
            %>
            <tr>
            	<td><%=amount %></td>
            	<td><%=ItemID%></td>
            </tr>
            <%
    		 	}
                auctions2.close(); // Close the current ResultSet
            if (!auctionfound2) {
            %>
            <tr>
                <td>No Won Auctions Found For User</td>
            </tr>
            <%
            }
                ps3.close();
                con2.close();
            %>
		</table>
	</div>
	
	<div class="search-results-container">
		<h1>Auctions Participated In / Bidded On</h1>
		<table>
            <tr>
                <th>Bid Amount</th>
            	<th>Item_ID</th>
            	<th>Vehicle Type</th>
            	<th>Vehicle Make</th>
            	<th>Vehicle Color</th>
            	<th>Year</th>
            	<th>Vehicle Condition</th>
            	
                 <%
            	ApplicationDB db3 = new ApplicationDB();	
        		Connection con3 = db3.getConnection();
        		boolean auctionfound3 = false;
            	String str4 = "SELECT Bids.Bid_ID, Bids.Amount, Item_Auction.Vehicle_Type, Item_Auction.Vehicle_Make, Item_Auction.Vehicle_Color, Item_Auction.Vehicle_Year, Item_Auction.Vehicle_Condition FROM Bids INNER JOIN Item_Auction ON Bids.Item_ID=Item_Auction.Item_ID WHERE Bids.Buyer_ID=?";
            	PreparedStatement ps4 = con3.prepareStatement(str4);
            	ps4.setInt(1, (Integer) session.getAttribute("User_ID"));
            	ResultSet auctions3 = ps4.executeQuery();
            
            	while(auctions3.next()){
            		auctionfound3 = true;
            		Double amount = auctions3.getDouble("Amount");
            		Integer ItemID = auctions3.getInt("Bid_ID");
            		String type = auctions3.getString("Vehicle_Type");
            		String color = auctions3.getString("Vehicle_Color");
            		String make = auctions3.getString("Vehicle_Make");
            		String year = auctions3.getString("Vehicle_Year");
            		String condition = auctions3.getString("Vehicle_Condition");
            %>
            <tr>
            <tr>
                <td><%=amount %></td>
            	<td><%=ItemID %></td>
            	<td><%= type %></td>
            	<td><%= color %></td>
            	<td><%= make %></td>
            	<td><%= year %></td>
            	<td><%= condition %></td>

            </tr>
            <%
    		 	}
                auctions3.close(); // Close the current ResultSet
            if (!auctionfound3) {
            %>
            <tr>
                <td>No Auctions Participated In</td>
            </tr>
            <%
            }
                ps4.close();
                con3.close();
            %>
		</table>
	</div>
            
</body>
</html>