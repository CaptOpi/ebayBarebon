<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>User Earnings</title>
</head>
<body>
<div class="home-button">
        <a href="GenerateReport.jsp">Go back to Report Screen</a>
    </div>
<h1>Earnings For User: <%=request.getParameter("searchItem")%></h1>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String str = "SELECT SUM(Sold_Price) AS Total_Earnings FROM Item_Auction WHERE Seller_ID=? AND Sold_Price > 0";
	String str2 = "SELECT Item_ID, Sold_Price FROM Item_Auction WHERE Seller_ID=? AND Sold_Price > 0";
	double earnings = 0;
	PreparedStatement ps = con.prepareStatement(str);
	String searched = (String)request.getParameter("searchItem");
	Integer userID = -1;
	if(searched != null){
		userID = Integer.parseInt(searched);
		ps.setInt(1, userID);
		ResultSet result = ps.executeQuery();
		
		while(result.next()){
			earnings = result.getInt("Total_Earnings");
		}
	}
	

%>
<h2>Total: $<%=earnings%></h2>
<div class="search-results-container">
	<h2>All Sold Items:</h2>
	<table>
            <tr>
                <th>Item ID</th>
                <th>Sold Price</th>
            </tr>
            <%
            boolean itemSold = false;
    		PreparedStatement ps2 = con.prepareStatement(str2);
    		ps2.setInt(1, userID);
    		ResultSet items = ps2.executeQuery();
    	
    		while(items.next()){
    			itemSold = true;
    			int ItemID = items.getInt("Item_ID");
    			Float SoldPrice = items.getFloat("Sold_Price");
    		%>
    		 <tr>
                <td><%=ItemID %></td>
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

</body>
</html>