<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction Page</title>
</head>
<body>
<div class="home-button">
    <a href="HomeScreen.jsp">Go back to Home Screen</a>
</div>
<div>
	<h1>Create Auction</h1>
	<p>Please enter the following information to create an auction for your vehicle. The initial price must be a minimum of 2000 and a maximum of 150000. The reserve price must be at least 500 above initial price. As well as this, the increment per bid is 250.
</div>
<div>
	<form method = "get" action="CreateAuctionAttempt.jsp">
		Type:<select name="createType" required>
			<option value=""></option>
			<option value="suv">suv</option>
			<option value="truck">truck</option>
			<option value="compact">compact</option>
			<option value="minivan">minivan</option>
			<option value="sports">sports</option>
		</select>
		Make: <select name="createMake" required>
			<option value=""></option>
			<option value="toyota">toyota</option>
			<option value="hyundai">hyundai</option>
			<option value="audi">audi</option>
			<option value="ford">ford</option>
			<option value="honda">honda</option>			
		</select>
		Color: <select name="createColor" required>
			<option value=""></option>
			<option value="red">red</option>
			<option value="blue">blue</option>
			<option value="black">black</option>
			<option value="grey">grey</option>
			<option value="white">white</option>
		</select>
		Condition: <select name ="createCondition" required>
			<option value=""></option>
			<option value="excellent">excellent</option>
			<option value="very-good">very-good</option>
			<option value="good">good</option>
			<option value="fair">fair</option>
		</select>
		<br>
		Mileage: <input type="text" name="createMileage" required>
		Year: <input type="text" name="createYear" required>
		MPG: <input type="text" name="createMpg" required>
		<br>
		<br>
		Initial Price: <input type="text" name="initialPrice" required>
		Reserve Price: <input type="text" name="reservePrice" required>
		<br>
		End After Time: <select name="endTime" required>
			<option value=""></option>
			<option value="1">1 hour</option>
			<option value="3">3 hours</option>
			<option value="6">6 hours</option>
			<option value="9">9 hours</option>
			<option value="12">12 hours</option>
		</select>
		<br>
		<input type="submit" name="submit" value="Enter"/>
	</form>
</div>
</body>