<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Account</title>
</head>
<body>
	<%
			String Username = request.getParameter("Username");
			if (Username == null || Username.isEmpty()) {
	   	    	Username = (String) session.getAttribute("user");
			}
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Finds the User_ID
			String Find_User_ID = "SELECT u.User_ID FROM End_Users u WHERE u.Username=?";
			PreparedStatement ps_ID = con.prepareStatement(Find_User_ID);
			ps_ID.setString(1, Username);
			ResultSet user = ps_ID.executeQuery();
			int User_ID = -1;
			while(user.next()){
				User_ID = user.getInt("User_ID");
			}
			//Find the AuctionItem IDs to delete
			String Find_Item_ID = "SELECT i.Item_ID FROM Item_Auction i WHERE i.Seller_ID=?";
			PreparedStatement ps_ID2 = con.prepareStatement(Find_Item_ID);
			ps_ID2.setInt(1, User_ID);
			ResultSet auction = ps_ID2.executeQuery();
			
			//Runs search on all user auctions to find all bids associated
			 while (auction.next()) {
				int Auction_ID = (int) auction.getInt("Item_ID");
				String Find_Bid_ID = "SELECT b.Bid_ID FROM Bids b WHERE b.Item_ID=?";
				PreparedStatement ps_ID3 = con.prepareStatement(Find_Bid_ID);
				ps_ID3.setInt(1, Auction_ID);
				ResultSet bid = ps_ID3.executeQuery();
				//Deletes all bids associated with soon-to-be deleted auction
				while(bid.next()) {
					int Bid_ID = bid.getInt("Bid_ID");
					String Delete_Bid_ID = "DELETE FROM Bids b WHERE b.Bid_ID=?";
					PreparedStatement ps_ID5 = con.prepareStatement(Delete_Bid_ID);
					ps_ID5.setInt(1, Bid_ID);
					int result_bid = ps_ID5.executeUpdate();
					
					
				}
				//All associated bids have been deleted, delete the auction
				String str_auc = "DELETE FROM Item_Auction i WHERE i.Item_ID=?";
				PreparedStatement ps_ID4 = con.prepareStatement(str_auc);
				ps_ID4.setInt(1, Auction_ID);
				int result_auc = ps_ID4.executeUpdate();
			 }
			
			

			
			//Deletes all Bids/Auctions/Questions/Etc associated with user
			String str2 = "DELETE FROM Bids b WHERE b.Buyer_ID=?";
			String str3 = "DELETE FROM Question q WHERE q.User_ID=?";
			String str4 = "DELETE FROM Modified m WHERE m.User_ID=?";
			String str5 = "DELETE FROM Buyers b WHERE b.User_ID=?";
			String str6 = "DELETE FROM Sellers s WHERE s.User_ID=?";
			String str7 = "DELETE FROM Alerts a WHERE a.User_ID=?";
			String str8 = "DELETE FROM Places p WHERE p.Buyer_ID=?";
			String str9 = "DELETE FROM Opens o WHERE o.Seller_ID=?";
			String str10 = "DELETE FROM Searches s WHERE s.User_ID=?";
			
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(str2);
			PreparedStatement ps3 = con.prepareStatement(str3);
			PreparedStatement ps4 = con.prepareStatement(str4);
			PreparedStatement ps5 = con.prepareStatement(str5);
			PreparedStatement ps6 = con.prepareStatement(str6);
			PreparedStatement ps7 = con.prepareStatement(str7);
			PreparedStatement ps8 = con.prepareStatement(str8);
			PreparedStatement ps9 = con.prepareStatement(str9);
			PreparedStatement ps10 = con.prepareStatement(str10);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setInt(1, User_ID);
			ps3.setInt(1, User_ID);
			ps4.setInt(1, User_ID);
			ps5.setInt(1, User_ID);
			ps6.setInt(1, User_ID);
			ps7.setInt(1, User_ID);
			ps8.setInt(1, User_ID);
			ps9.setInt(1, User_ID);
			ps10.setInt(1, User_ID);
			
			//Deletes all matching IDs
			int result2 = ps2.executeUpdate();
			int result3 = ps3.executeUpdate();
			int result4 = ps4.executeUpdate();
			int result5 = ps5.executeUpdate();
			int result6 = ps6.executeUpdate();
			int result7 = ps7.executeUpdate();
			int result8 = ps8.executeUpdate();
			int result9 = ps9.executeUpdate();
			int result10 = ps10.executeUpdate(); 
			
			//Finally deletes the account
			String Delete_Account = "";
			Delete_Account = "DELETE FROM End_Users u WHERE u.User_ID=?";
			PreparedStatement ps11 = con.prepareStatement(Delete_Account);
			ps11.setInt(1, User_ID);
			int result11 = ps11.executeUpdate();
			//Account is successfully deleted, change the session user variable to null and redirect to login screen
			session.setAttribute("user", null);
			session.setAttribute("User_ID", -1);
			response.sendRedirect("LoginScreen.jsp");
			con.close();
	%>
</body>
</html>