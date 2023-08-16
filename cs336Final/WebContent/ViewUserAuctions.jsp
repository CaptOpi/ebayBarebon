<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link href="styles.css" rel="stylesheet" type="text/css" />
    <title>View User Auctions</title>
</head>
<body>
<div class="home-button">
    <a href="HomeScreen.jsp">Go back to Home Screen</a>
</div>
<%
    String username = request.getParameter("searchField");
%>
<div>
    <h1>View User's Auctions</h1>
    <p>Search Query: <%=username%></p>
</div>
<%
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    PreparedStatement checkUser = con.prepareStatement("SELECT * FROM End_Users WHERE Username = ?");
    checkUser.setString(1, username);
    ResultSet userResult = checkUser.executeQuery();

    if (!userResult.next()) {
%>
    <p>No results found</p>
<%
    } else {
        int userId = userResult.getInt("User_ID");
        PreparedStatement userAuctions = con.prepareStatement("SELECT Item_ID, Current_Price FROM Item_Auction WHERE Seller_ID = ?");
        userAuctions.setInt(1, userId);
        ResultSet auctionsResult = userAuctions.executeQuery();
        PreparedStatement userBids = con.prepareStatement("SELECT Bids.Item_ID, Bids.Amount, Item_Auction.Current_Price FROM Bids JOIN Item_Auction ON Bids.Item_ID = Item_Auction.Item_ID WHERE Bids.Buyer_ID = ?");
        userBids.setInt(1, userId);
        ResultSet bidsResult = userBids.executeQuery();
%>
    <table>
        <h2>Selling Auctions</h2>
        <tr>
            <th>Item ID</th>
            <th>Current Price</th>
        </tr>
        <%
        while (auctionsResult.next()) {
            int itemId = auctionsResult.getInt("Item_ID");
            double currentPrice = auctionsResult.getDouble("Current_Price");
            String viewAuctionLink = "ViewAuction.jsp?itemId=" + itemId;
        %>
        <tr>
            <td><%= itemId %></td>
            <td><%= currentPrice %></td>
            <td><a href="<%= viewAuctionLink %>">View Auction</a></td>
        </tr>
        <%
        }
        auctionsResult.close();
        userAuctions.close();
%>
    </table>
    <table>
        <h2>Buying Auctions</h2>
        <tr>
            <th>Item ID</th>
            <th>Bid Amount</th>
            <th>Current Price</th>
        </tr>
        <%
        while (bidsResult.next()) {
            int itemId = bidsResult.getInt("Item_ID");
            double bidAmount = bidsResult.getDouble("Amount");
            double currentPrice = bidsResult.getDouble("Current_Price");
            String viewAuctionLink = "ViewAuction.jsp?itemId=" + itemId;
        %>
        <tr>
            <td><%= itemId %></td>
            <td><%= bidAmount %></td>
            <td><%= currentPrice %></td>
            <td><a href="<%= viewAuctionLink %>">View Auction</a></td>
        </tr>
        <%
        }
        bidsResult.close();
        userBids.close();
%>
    </table>
<%
    }
    userResult.close();
    checkUser.close();
    con.close();
%>
</body>
</html>
