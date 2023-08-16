<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earnings</title>
</head>
<body>
<div class="home-button">
        <a href="GenerateReport.jsp">Go back to Report Screen</a>
    </div>
<h1>Earnings Per Type: <%=request.getParameter("specification") %></h1>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	boolean itemSold = false;
	boolean itemSold2 = false;

	String str = "SELECT SUM(Sold_Price) AS Total_Price FROM Item_Auction WHERE Sold_Price > 0 AND Vehicle_Type=?";
	PreparedStatement ps = con.prepareStatement(str);
	ps.setString(1, (String)request.getParameter("specification"));
	ResultSet price = ps.executeQuery();
	double TotalEarnings = 0;
	while(price.next()){
		
		if(price.getString("Total_Price") != null){
			itemSold2 = true;
			TotalEarnings = Double.parseDouble(price.getString("Total_Price"));
			session.setAttribute("Total Earnings Type", price.getString("Total_Price"));
		}
		
	}
	if(itemSold2== false){
		session.setAttribute("Total Earnings Type", 0);
	}
	price.close();

%>
<h2>Total Earnings: <%=session.getAttribute("Total Earnings Type") %></h2>

<div class="search-results-container">
		<table>
            <tr>
                <th>Item ID</th>
                <th>Item Type</th>
                <th>Seller ID</th>
                <th>Sold Price</th>
            </tr>
            <%
            	String str2 = "SELECT Item_ID, Seller_ID, Vehicle_Type, Sold_Price FROM Item_Auction WHERE Sold_Price > 0 AND Vehicle_Type=?";
    			PreparedStatement ps2 = con.prepareStatement(str2);
    			ps2.setString(1, (String)request.getParameter("specification"));
    			ResultSet items = ps2.executeQuery();
    	
    			while(items.next()){
    				itemSold = true;
    				int ItemID = items.getInt("Item_ID");
    				int SellerID = items.getInt("Seller_ID");
    				String Vehicle_Type = items.getString("Vehicle_Type");
    				Float SoldPrice = items.getFloat("Sold_Price");
            %>
    		 <tr>
                <td><%=ItemID %></td>
                <td><%=Vehicle_Type%></td>
                <td><%=SellerID%></td>
                <td><%=SoldPrice %></td>
            </tr>
            <%
    		 	}
                items.close(); // Close the current ResultSet
            if (!itemSold) {
            %>
            <tr>
                <td>No Sold <%=request.getParameter("specification")%>s Found</td>
            </tr>
            <%
            }
            session.setAttribute("Total Earnings Type", 0);
            %>
            </table>
           </div>
</body>
</html>