<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Item</title>
</head>
<body>
<%
	try{
		ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
		Integer ItemID = Integer.parseInt(request.getParameter("ItemID2"));
		session.setAttribute("ItemEntered", ItemID);
    	
    	
		String str = "DELETE FROM Item_Auction WHERE Item_ID=?";
    	PreparedStatement ps = con.prepareStatement(str);
    	ps.setInt(1, ItemID);
    	int result2 = ps.executeUpdate();
    	session.setAttribute("ItemEntered2", "Reached Execute");
    	response.sendRedirect("AccountOverview.jsp");
    	
	}catch (Exception ex) {
		out.print(ex);
		session.setAttribute("ReachedAuction", "Error Encountered");
		out.print("Delete Auction failed");
		response.sendRedirect("AccountOverview.jsp");
	}
	
	
	
	
	
%>
</body>
</html>