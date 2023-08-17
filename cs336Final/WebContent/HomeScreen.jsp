<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Home Page</title>
</head>
<body>
<div> 
	<h1>Welcome Back</h1>
	<p>
	<%
		if((String) session.getAttribute("user") == "null") {
			response.sendRedirect("LoginScreen.jsp");
		} else {
			out.println("Username:" + " " + session.getAttribute("user"));
		}
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	String expiredItem = "SELECT * FROM Item_Auction WHERE Close_Date < CURDATE() OR (Close_Date = CURDATE() AND Close_Time < CURTIME())";
	PreparedStatement expiredItems = con.prepareStatement(expiredItem);
	ResultSet expiredItemsResult = expiredItems.executeQuery();
	while(expiredItemsResult.next()) {
		int itemID = expiredItemsResult.getInt("Item_ID");
		double reserve = expiredItemsResult.getDouble("Secret_Min");
		double currentPrice = expiredItemsResult.getDouble("Current_Price");
		double soldPrice = expiredItemsResult.getDouble("Sold_Price");
		int sellerID = expiredItemsResult.getInt("Seller_ID");
		if(currentPrice >= reserve && currentPrice != soldPrice){
			String findBuyer = "SELECT Buyer_ID, Amount FROM Bids WHERE Item_ID = ? ORDER BY Amount DESC LIMIT 1";
			PreparedStatement findBuyers = con.prepareStatement(findBuyer);
			findBuyers.setInt(1,itemID);
			ResultSet findResult = findBuyers.executeQuery();
			int buyerID = -1;
			while(findResult.next()) {
				buyerID = findResult.getInt("Buyer_ID");
			}
			findBuyers.close();
			findResult.close();
			String updatePrice = "UPDATE Item_Auction SET Sold_Price = ? WHERE Item_ID = ?";
			PreparedStatement updatedPrice = con.prepareStatement(updatePrice);
			updatedPrice.setDouble(1,currentPrice);
			updatedPrice.setDouble(2,itemID);
			updatedPrice.executeUpdate();
			updatedPrice.close();
			
			String insertBuyer = "INSERT INTO Buyers (User_ID, Item_ID, Sold_Price) VALUES (?,?,?)";
			PreparedStatement insert = con.prepareStatement(insertBuyer);
			insert.setInt(1,buyerID);
			insert.setInt(2,itemID);
			insert.setDouble(3,currentPrice);
			insert.executeUpdate();
			insert.close();
			
			String updateEarnings = "UPDATE End_Users SET Total_Earnings = Total_Earnings + ? WHERE User_ID = ?";
			PreparedStatement update = con.prepareStatement(updateEarnings);
			update.setDouble(1,currentPrice);
			update.setInt(2,sellerID);
			update.executeUpdate();
			update.close();
		}
	}
	expiredItems.close();
	expiredItemsResult.close();
	%>
	<p/>
</div>
<div>
	<form method="post" action="ViewSelfAuctions.jsp">
		<input type="submit" value="View Auctions"/>
	</form>
</div>
<div>
	<form method="post" action="CreateAuctionScreen.jsp">
		<input type="submit" value="Create Auction"/>
	</form>
</div>
<div>
	<form method="post" action="ViewAlerts.jsp">
		<input type="submit" value= "View Alerts"/>
	</form>
</div>
<div>
    <form method="post" action="ModifyAccount.jsp">
    	<input type="hidden" value=<%=session.getAttribute("user") %> name="Username">
        <input type="submit" value="Modify Account"/>
    </form>
</div>
<div>
	<form method="post" action="LogoutAttempt.jsp">
		<input type="submit" value="Logout"/>
	</form>
</div>
<div>
	<h2>View User Auctions</h2>
	<form method="post" action="ViewUserAuctions.jsp">
			<input type="text" name="searchField" value="View User" 
				onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="submit" name="searchButton" value="Enter"/>
	</form>
</div>
<div>
	<h2>Search Vehicles</h1>
	<form method="get" action="SearchAttempt.jsp">
		Type:<select name="type">
			<option value=""></option>
			<option value="suv">suv</option>
			<option value="truck">truck</option>
			<option value="compact">compact</option>
			<option value="minivan">minivan</option>
			<option value="sports">sports</option>
		</select>
		Make: <select name="make">
			<option value=""></option>
			<option value="toyota">toyota</option>
			<option value="hyundai">hyundai</option>
			<option value="audi">audi</option>
			<option value="ford">ford</option>
			<option value="honda">honda</option>			
		</select>
		Color: <select name="color">
			<option value=""></option>
			<option value="red">red</option>
			<option value="blue">blue</option>
			<option value="black">black</option>
			<option value="grey">grey</option>
			<option value="white">white</option>
		</select>
		<br>
		Condition: <select name ="condition">
			<option value=""></option>
			<option value="excellent">excellent</option>
			<option value="very-good">very-good</option>
			<option value="good">good</option>
			<option value="fair">fair</option>
		</select>
		Mileage: <select name="mileage">
			<option value=""></option>
			<option value="50000"><50000</option>
			<option value="100000"><100000</option>
			<option value="150000"><150000</option>
			<option value="200000"><200000</option>
		</select>
		<br>
		Year: <input type="text" name="year">
		MPG: <input type="text" name="mpg">
		<br>
		<input type="submit" name="submit" value="Enter"/>
	</form>
</div>
<div>
	<h3>View Your Questions Home page</h3>
    <form method="post" action="QuestionScreen.jsp">
    	<input type="hidden" value=<%=session.getAttribute("user")%> name="Username">
        <input type="submit" value="Go To Questions">
    </form>
</div>
</body>
</html>