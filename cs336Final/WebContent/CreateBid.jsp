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
    <title>Create Bid Script</title>
</head>
<body>
    <%
    try {
        double bidAmount = Double.parseDouble(request.getParameter("bidAmount").strip());
        int itemID = Integer.parseInt(request.getParameter("itemId"));
        int buyerID = -1;
		double upperLimit = -1;
        String upperLimitParam = request.getParameter("upperLimit");
        if (upperLimitParam != null && !upperLimitParam.isEmpty()) {
            upperLimit = Double.parseDouble(upperLimitParam.strip());
        }
        if (upperLimit != -1 && upperLimit < bidAmount + 300) {
            response.sendRedirect("HomeScreen.jsp");
            return;
        }
        String findUser = "SELECT User_ID FROM End_Users WHERE Username = ?";
        ApplicationDB dbs = new ApplicationDB();
        Connection connection = dbs.getConnection();
		
        
        PreparedStatement findUsers = connection.prepareStatement(findUser);
        findUsers.setString(1, (String) session.getAttribute("user")); 
        ResultSet result = findUsers.executeQuery();
        if (result.next()) {
        	buyerID = result.getInt("User_ID");
        }
        
        String checkSellerQuery = "SELECT Seller_ID FROM `Item_Auction` WHERE Item_ID = ?";
        PreparedStatement checkSellerStatement = connection.prepareStatement(checkSellerQuery);
        checkSellerStatement.setInt(1, itemID);
        ResultSet sellerResult = checkSellerStatement.executeQuery();
        
        if (sellerResult.next()) {
            int sellerID = sellerResult.getInt("Seller_ID");
            
            if (sellerID == buyerID) {
                response.sendRedirect("HomeScreen.jsp");
                return; 
            }
        }
        
        String checkExistingBidQuery = "SELECT MAX(Amount) AS MaxAmount FROM `Bids` WHERE Item_ID = ?";
        PreparedStatement checkExistingBidStatement = connection.prepareStatement(checkExistingBidQuery);
        checkExistingBidStatement.setInt(1, itemID);
        ResultSet maxBidResult = checkExistingBidStatement.executeQuery();
        if (maxBidResult.next()) {
            double maxBidAmount = maxBidResult.getDouble("MaxAmount");
            
            if (bidAmount <= maxBidAmount) {
                response.sendRedirect("HomeScreen.jsp");
                return;
            }
        }

        String insertQuery = "INSERT INTO `Bids` (Amount, Buyer_ID, Item_ID, Upper_LIMIT) VALUES (?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setDouble(1, bidAmount);
        preparedStatement.setInt(2, buyerID);
        preparedStatement.setInt(3, itemID);
        if(upperLimit != -1) {
        	preparedStatement.setDouble(4,upperLimit);
        } else {
        	preparedStatement.setNull(4,Types.DOUBLE);
        }
        preparedStatement.executeUpdate();
        String checkUpper = "SELECT Buyer_ID, Upper_Limit FROM Bids WHERE Item_ID = ? ORDER BY Upper_Limit DESC LIMIT 1";
        PreparedStatement prepared = connection.prepareStatement(checkUpper);
        prepared.setInt(1,itemID);
        ResultSet resultUpper = prepared.executeQuery();
        if (resultUpper.next()) {
        	 double upperLimits = resultUpper.getDouble("Upper_Limit");
        	 int autoBuyer = resultUpper.getInt("Buyer_ID");
        	 if (upperLimits > bidAmount && buyerID != autoBuyer ) {
             	String autoBid = "INSERT INTO `Bids` (Amount, Buyer_ID, Item_ID) VALUES(?,?,?)";
             	PreparedStatement auto = connection.prepareStatement(autoBid);
             	auto.setDouble(1, bidAmount + 100);
             	auto.setInt(2,autoBuyer);
             	auto.setInt(3,itemID);
             	auto.executeUpdate();
             	auto.close();
             }
        }
        prepared.close();
        resultUpper.close();
        String maxBidQuery = "SELECT MAX(Amount) AS MaxBidAmount FROM Bids WHERE Item_ID = ?";
        PreparedStatement maxBids = connection.prepareStatement(maxBidQuery);
        maxBids.setInt(1, itemID);
        ResultSet maxBid = maxBids.executeQuery();
        double max = 0.0;
        if (maxBid.next()) {
            max = maxBid.getDouble("MaxBidAmount");
        }
        String updateCurrentPrice = "UPDATE Item_Auction SET Current_Price = ? WHERE Item_ID = ?";
        PreparedStatement updateCurrentPrices = connection.prepareStatement(updateCurrentPrice);
        updateCurrentPrices.setDouble(1, max);
        updateCurrentPrices.setInt(2, itemID);
        updateCurrentPrices.executeUpdate();
        
        maxBid.close();
        maxBids.close();
        updateCurrentPrices.close();
        preparedStatement.close();
        checkSellerStatement.close();
        checkExistingBidStatement.close();
        connection.close();
		
        response.sendRedirect("HomeScreen.jsp");
    } catch (Exception e) {
    	out.print(e);
        response.sendRedirect("HomeScreen.jsp");
    }
    %>
</body>
</html>