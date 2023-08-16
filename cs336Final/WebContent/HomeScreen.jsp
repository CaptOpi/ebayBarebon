<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Home Page</title>
</head>
<body>
<div> 
	<h1>Welcome Back</h1>
	<p>
	<%
		if((String) session.getAttribute("user") == "null") {
			response.sendRedirect("LoginScreen.jsp");
		} else {
			out.println("Username:" + " " + session.getAttribute("user"));
		}
	%>
	<p/>
</div>
<div>
	<form method="post" action="ViewSelfAuctions.jsp">
		<input type="submit" value="View Auctions"/>
	</form>
</div>
<div>
	<form method="post" action="CreateAuctionScreen.jsp">
		<input type="submit" value="Create Auction"/>
	</form>
</div>
<div>
	<form method="post" action="ViewAlerts.jsp">
		<input type="submit" value= "View Alerts"/>
	</form>
</div>
<div>
    <form method="post" action="ModifyAccount.jsp">
    	<input type="hidden" value=<%=session.getAttribute("user") %> name="Username">
        <input type="submit" value="Modify Account"/>
    </form>
</div>
<div>
	<form method="post" action="LogoutAttempt.jsp">
		<input type="submit" value="Logout"/>
	</form>
</div>
<div>
	<h2>View User Auctions</h2>
	<form method="post" action="ViewUserAuctions.jsp">
			<input type="text" name="searchField" value="View User" 
				onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="submit" name="searchButton" value="Enter"/>
	</form>
</div>
<div>
	<h2>Search Vehicles</h1>
	<form method="get" action="SearchAttempt.jsp">
		Type:<select name="type">
			<option value=""></option>
			<option value="suv">suv</option>
			<option value="truck">truck</option>
			<option value="compact">compact</option>
			<option value="minivan">minivan</option>
			<option value="sports">sports</option>
		</select>
		Make: <select name="make">
			<option value=""></option>
			<option value="toyota">toyota</option>
			<option value="hyundai">hyundai</option>
			<option value="audi">audi</option>
			<option value="ford">ford</option>
			<option value="honda">honda</option>			
		</select>
		Color: <select name="color">
			<option value=""></option>
			<option value="red">red</option>
			<option value="blue">blue</option>
			<option value="black">black</option>
			<option value="grey">grey</option>
			<option value="white">white</option>
		</select>
		<br>
		Condition: <select name ="condition">
			<option value=""></option>
			<option value="excellent">excellent</option>
			<option value="very-good">very-good</option>
			<option value="good">good</option>
			<option value="fair">fair</option>
		</select>
		Mileage: <select name="mileage">
			<option value=""></option>
			<option value="50000"><50000</option>
			<option value="100000"><100000</option>
			<option value="150000"><150000</option>
			<option value="200000"><200000</option>
		</select>
		<br>
		Year: <input type="text" name="year">
		MPG: <input type="text" name="mpg">
		<br>
		<input type="submit" name="submit" value="Enter"/>
	</form>
</div>
<div>
	<h3>View Your Questions Home page</h3>
    <form method="post" action="QuestionScreen.jsp">
    	<input type="hidden" value=<%=session.getAttribute("user")%> name="Username">
        <input type="submit" value="Go To Questions">
    </form>
</div>
</body>
</html>