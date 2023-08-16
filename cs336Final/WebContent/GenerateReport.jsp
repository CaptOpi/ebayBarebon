<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Generate Sales Report</title>
</head>
<body>
<div class="home-button">
        <a href="AdminScreen.jsp">Go back to Admin Screen</a>
    </div>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	boolean itemSold = false;
	
	//Find Total Earnings
	String str = "SELECT SUM(Sold_Price) AS Total_Price FROM Item_Auction WHERE Sold_Price > 0";
	PreparedStatement ps = con.prepareStatement(str);
	ResultSet price = ps.executeQuery();
	double TotalEarnings = 0;
	while(price.next()){
		TotalEarnings = Double.parseDouble(price.getString("Total_Price"));
		session.setAttribute("Total Earnings", price.getString("Total_Price"));
	}
	price.close();
	
	
	
	
%>
	<div>
		<h1>Summary Sales Report</h1>
		<br></br>
		<h2>Total Earnings: <%=TotalEarnings%></h2>
	</div>
	<br></br>
	<h2>Earnings Per Item: </h2>
	<div class="search-results-container">
		<table>
            <tr>
                <th>Item ID</th>
                <th>Seller ID</th>
                <th>Sold Price</th>
            </tr>
            <%
    		String str2 = "SELECT Item_ID, Seller_ID, Sold_Price FROM Item_Auction WHERE Sold_Price > 0";
    		PreparedStatement ps2 = con.prepareStatement(str2);
    		ResultSet items = ps2.executeQuery();
    	
    		while(items.next()){
    			itemSold = true;
    			int ItemID = items.getInt("Item_ID");
    			int SellerID = items.getInt("Seller_ID");
    			Float SoldPrice = items.getFloat("Sold_Price");
    		%>
    		 <tr>
                <td><%=ItemID %></td>
                <td><%=SellerID%></td>
                <td><%=SoldPrice %></td>
            </tr>
            <%
    		 	}
                items.close(); // Close the current ResultSet
            if (!itemSold) {
            %>
            <tr>
                <td>No Sold Items Found</td>
            </tr>
            <%
            }
            %>
            </table>
	
	</div>
	
	<h3>Best Selling Users:</h3>
	<div class="search-results-container">
		<table>
            <tr>
                <th>User ID</th>
                <th>Items Sold</th>
            </tr>
		
		<%
		//Find best selling users
		String user = "SELECT Seller_ID, COUNT(*) AS Success FROM Item_Auction WHERE Sold_Price > 0 GROUP BY Seller_ID HAVING Count(*) > 0 ORDER BY COUNT(*) DESC";
		PreparedStatement ps3 = con.prepareStatement(user);
		ResultSet users = ps3.executeQuery();
		boolean bestSeller = false;
		while(users.next()){
			bestSeller = true;
			int UserID = users.getInt("Seller_ID");
			int Success = users.getInt("Success");
		%>
    		 <tr>
                <td><%=UserID %></td>
                <td><%=Success%></td>
            </tr>
            <%
    		 }
                users.close(); // Close the current ResultSet
            if (!bestSeller) {
            %>
            <tr>
                <td>No Best Selling Users Found</td>
            </tr>
            <%
            }
            %>
           </table>
	</div>
	<br></br>
	<div class="search-results-container">
	<h3>Best Selling Item Types:</h3>
		<table>
            <tr>
                <th>Item Type</th>
                <th>Number Sold</th>
            </tr>
            <%
         	 //Find best selling item types
    		String str4 = "SELECT Vehicle_Type, COUNT(*) AS Success FROM Item_Auction WHERE Sold_Price > 0 GROUP BY Vehicle_Type HAVING Count(*) > 0 ORDER BY COUNT(*) DESC";
    		PreparedStatement ps4 = con.prepareStatement(str4);
    		ResultSet types = ps4.executeQuery();
    		boolean bestType = false;
    		while(types.next()){
    			bestType = true;
    			String type = types.getString("Vehicle_Type");
    			int Success = types.getInt("Success");
            %>

    		 <tr>
                <td><%=type %></td>
                <td><%=Success%></td>
            </tr>
            <%
    		 }
                types.close(); // Close the current ResultSet
            if (!bestType) {
            %>
            <tr>
                <td>No Best Selling Users Found</td>
            </tr>
            <%
            }
            %>
           </table>
	</div>
	
	<br></br>
		<h3>Search Earnings Per:</h3>
		<form method="post" action="Earnings.jsp">
			<input type="text" name="searchItem" value="Search By User ID"
				onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="submit" value="Search" name="Item">
		</form>
		<br></br>
		<form method="get" action="EarningsPerType.jsp">
			<input type="hidden" name="Type" value="spec">
			Type:<select name="specification">
			<option value=""></option>
			<option value="suv">suv</option>
			<option value="truck">truck</option>
			<option value="compact">compact</option>
			<option value="minivan">minivan</option>
			<option value="sports">sports</option>
			</select>
			<input type="submit" name="submit" value="Enter"/>
		</form>
		
	</div>	
	
	
</body>
</html>