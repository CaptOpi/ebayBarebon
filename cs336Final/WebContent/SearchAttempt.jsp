<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auctioned Items Search</title>
<script type="text/javascript">
	function alertName(){
		alert("Please provide at least one search parameter.");
	} 
</script> 
</head>
<body>
<%
    try {
        // Get parameters from the HTML form at the index.jsp
        String type = request.getParameter("type");
        String make = request.getParameter("make");
        String yearStr = request.getParameter("year");
        String mpgStr = request.getParameter("mpg");
        String mileageStr = request.getParameter("mileage");
        String color = request.getParameter("color");
        String condition = request.getParameter("condition");
        if (yearStr.isEmpty() && mpgStr.isEmpty() && mileageStr.isEmpty() && type.isEmpty() && make.isEmpty() && condition.isEmpty() && color.isEmpty()){
            request.setAttribute("errorMessage", "Please provide at least one search parameter.");
            response.sendRedirect("HomeScreen.jsp");
        	return;
        }
        int year = 0;
        if (yearStr != null && !yearStr.isEmpty()) {
            year = Integer.parseInt(yearStr);
            session.setAttribute("year",year);
        }
        int mpg = 0;
        if (mpgStr != null && !mpgStr.isEmpty()) {
            mpg = Integer.parseInt(mpgStr);
            session.setAttribute("mpg",mpg);
        }
        int mileage = 0;
        if (mileageStr != null && !mileageStr.isEmpty()) {
            mileage = Integer.parseInt(mileageStr);
            session.setAttribute("mileage",mileage);
        }
        if (color != null && !color.isEmpty()) {
        	session.setAttribute("color",color);
        }
        if (type != null && !type.isEmpty()) {
        	session.setAttribute("type",type);
        }
        if (make != null && !make.isEmpty()) {
        	session.setAttribute("make",make);
        }
        if (condition != null && !condition.isEmpty()) {
        	session.setAttribute("condition", condition);
        }
        response.sendRedirect("SearchScreen.jsp");
    } catch (Exception ex) {
        // Print error message and handling for any exceptions
        out.print("An error occurred during search.");
        response.sendRedirect("HomeScreen.jsp");
    }
%>
</body>
</html>



