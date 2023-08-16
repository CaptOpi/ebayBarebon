<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Alert</title>
</head>
<body>
<div class="home-button">
	<a href="HomeScreen.jsp">Go back to Home Screen</a>
</div>
<div>
	<h1>Create Alert</h1>
</div>

<form method="get" action="CreateAlertAttempt.jsp">
		Type:<select name="type" required>
			<option value=""></option>
			<option value="suv">suv</option>
			<option value="truck">truck</option>
			<option value="compact">compact</option>
			<option value="minivan">minivan</option>
			<option value="sports">sports</option>
		</select>
		Make: <select name="make" required>
			<option value=""></option>
			<option value="toyota">toyota</option>
			<option value="hyundai">hyundai</option>
			<option value="audi">audi</option>
			<option value="ford">ford</option>
			<option value="honda">honda</option>			
		</select>
		Color: <select name="color" required>
			<option value=""></option>
			<option value="red">red</option>
			<option value="blue">blue</option>
			<option value="black">black</option>
			<option value="grey">grey</option>
			<option value="white">white</option>
		</select>
		Condition: <select name ="condition" required>
			<option value=""></option>
			<option value="excellent">excellent</option>
			<option value="very-good">very-good</option>
			<option value="good">good</option>
			<option value="fair">fair</option>
		</select>
		<br>
        <input type="submit" value="Create Alert">
    </form>
</body>
</html>