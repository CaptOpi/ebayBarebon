<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Account Overview</title>
</head>
<body>
	<%
		int UserID = -1;
		String Username = "";
		String Password = "";
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		if(request.getParameter("UserID") == null){
			UserID = (int)session.getAttribute("ModifyUserID");
		}
		else{
			UserID = Integer.parseInt(request.getParameter("UserID"));
			session.setAttribute("ModifyUserID", UserID);
		}
		
		String string = "SELECT Username, User_Password FROM End_Users WHERE User_ID=?";
		PreparedStatement pss = con.prepareStatement(string);
		pss.setInt(1, UserID);
		ResultSet users = pss.executeQuery();
		while(users.next()){
			Username = users.getString("Username");
			Password = users.getString("User_Password");
		}
		
	%>
	
	<div>
		<h1>General Information</h1>
		<h2>User ID: <%=UserID%></h2>
		<h2>Username: <%=Username%></h2>
		<h2>Password: <%=Password%></h2>
	</div>
	
	<div>
		<h3>Delete Account?</h3>
		
		<form method="post" action="DeleteAttempt.jsp">
			<input type="hidden" name="DeletionMode" value="Staff">
			<input type="hidden" name="Username" value=<%=request.getParameter("Username")%>>
            <input type="submit" value="Delete Account" name="Delete" onclick="return confirm('Are you sure you want to continue?')">
        </form>
	</div>
	
	<%

    	boolean bidfound = false;
    	boolean auctionfound = false;
    	%>
		<div class="search-results-container">
        	<h1>User Bids</h1>
        	<form method="post" action="DeleteBid.jsp">
                		
                		<input type="hidden" name="DeletionType" value="Bid" >
                		<input type="text" name="ItemID2" value="Enter Bid_ID Here"
                			onfocus="this.value==this.defaultValue?this.value='':null"/>
                		<input type="submit" name="Bid" value="Delete Bid" onclick="return confirm('Are you sure you want to continue?')">
            		</form>
        	<table>
            <tr>
                <th>Bid ID</th>
                <th>Item ID</th>
                <th>Bid Amount in USD</th>
            </tr>
            <%
    		
    		String str = "SELECT b.Bid_ID, b.Item_ID, b.Amount FROM Bids b WHERE b.Buyer_ID=?";
    		PreparedStatement ps = con.prepareStatement(str);
    		ps.setInt(1, UserID);
    		ResultSet bids = ps.executeQuery();
    	
    		while(bids.next()){
    			bidfound = true;
    			int BidID = bids.getInt("Bid_ID");
    			int ItemID = bids.getInt("Item_ID");
    			Float Amount = bids.getFloat("Amount");
    		%>
    		 <tr>
                <td><%= BidID %></td>
                <td><%= ItemID %></td>
                <td><%= Amount %></td>
            </tr>
            <%
    		 	}
                bids.close(); // Close the current ResultSet
            if (!bidfound) {
            %>
            <tr>
                <td>No Bids Found For User</td>
            </tr>
            <%
            }
            %>
		</table>
	</div>
	
	<div class="search-results-container">
		<h1>User Auctions</h1>
		<form method="post" action="DeleteItem.jsp">
						
                		<input type="hidden" name="DeletionType" value="Item">
                		<input type="text" name="ItemID2" value="Enter Auction ID Here"
                			onfocus="this.value==this.defaultValue?this.value='':null"/>
                		<input type="submit" value="Delete Auction" name="Item" onclick="return confirm('Are you sure you want to continue?')">
        </form>
		<table>
            <tr>
                <th>Item ID</th>
                <th>Initial Price</th>
                <th>Current Price</th>
                <th>Secret Minimum</th>
                <th>Vehicle Description</th>
            </tr>
            <%
            
            	String str2 = "SELECT i.Item_ID, i.Initial_Price, i.Current_Price, i.Secret_Min, i.Vehicle_Type FROM Item_Auction i WHERE i.Seller_ID=?";
            	PreparedStatement ps2 = con.prepareStatement(str2);
            	ps2.setInt(1, UserID);
            	ResultSet auctions = ps2.executeQuery();
            
            	while(auctions.next()){
            		int ItemID2 = auctions.getInt("Item_ID");
            		Float InitialPrice = auctions.getFloat("Initial_Price");
            		Float CurrentPrice = auctions.getFloat("Initial_Price");
            		Float SecretMin = auctions.getFloat("Secret_Min");
            		String Description = auctions.getString("Vehicle_Type");
 
            %>
            <tr>
                <td><%= ItemID2 %></td>
                <td><%= InitialPrice %></td>
                <td><%= CurrentPrice %></td>
                <td><%= SecretMin %></td>
                <td><%= Description %></td>
               
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
            %>
		</table>
	</div>
	
</body>
</html>