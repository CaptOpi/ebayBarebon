<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deleting Item/Bid</title>
</head>
<body>
	<%
	try{
		int ItemID = Integer.parseInt(request.getParameter("ItemID2"));
		int UserID = Integer.parseInt(request.getParameter("UserID"));
		ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	
    	//Determines which table to delete from
    	String deletionType = request.getParameter("DeletionType");
    	
    	if(deletionType.equals("Bid")){
    		String str = "DELETE FROM Bids WHERE Bid_ID=?";
        	PreparedStatement ps = con.prepareStatement(str);
        	ps.setInt(1, ItemID);
        	int result = ps.executeUpdate();
    	}
    	else if(deletionType.equals("Item")){
    		
    		String str = "DELETE FROM Item_Auction WHERE Item_ID=?";
        	PreparedStatement ps = con.prepareStatement(str);
        	ps.setInt(1, ItemID);
        	int result = ps.executeUpdate();
    	}
    	response.sendRedirect("RepresentativeScreen.jsp");
    			
	}catch (Exception ex) {
		//Account deletion failed, send user back to their home page.
		out.print(ex);
		out.print("Delete Auction/Bid failed");
		//response.sendRedirect("AccountOverview.jsp");
		
	}
	%>
</body>
</html>