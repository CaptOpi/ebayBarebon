<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction Script</title>
</head>
<body>
	<%
	String createType = request.getParameter("createType");
    String createMake = request.getParameter("createMake");
    String createColor = request.getParameter("createColor");
    String createCondition = request.getParameter("createCondition");
    String user = (String) session.getAttribute("user");
    int userID = (Integer) session.getAttribute("User_ID");
    int endTime = Integer.parseInt(request.getParameter("endTime"));
    int createMileage = 0;
    int createYear = 0;
    int createMpg = 0;
    double initialPrice = 0.0;
    double reservePrice = 0.0;
    LocalDateTime currentDateTime = LocalDateTime.now();
    LocalDateTime newDateTime = currentDateTime.plus(endTime, ChronoUnit.HOURS);
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String formattedDate = newDateTime.format(dateFormatter);
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
    String formattedTime = newDateTime.format(timeFormatter);
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	String sqlStatement = "INSERT INTO Item_Auction (Vehicle_Type,Vehicle_Make,Vehicle_Color,Vehicle_Year, Vehicle_Condition,Vehicle_Mileage, Vehicle_MPG, Initial_Price, Current_Price, Secret_Min, Increment_Amt,Close_Date,Close_Time,Seller_ID)" +
	    	"VALUE (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	PreparedStatement preparedStatement = con.prepareStatement(sqlStatement);
	String checkStatement = "SELECT Alert_ID, Vehicle_Type, Vehicle_Make, Vehicle_Color, Vehicle_Condition, Alerted FROM Alerts";
    PreparedStatement stmt = con.prepareStatement(checkStatement);
    ResultSet results = null;
	try {
    	initialPrice = Double.parseDouble(request.getParameter("initialPrice"));
    	if(initialPrice < 2000 || initialPrice > 150000) {
    		out.print("Please enter smaller amounts.");
        	response.sendRedirect("CreateAuctionScreen.jsp");
        	con.close();
    	}
        reservePrice = Double.parseDouble(request.getParameter("reservePrice"));
        if(reservePrice < initialPrice + 500 || reservePrice <= initialPrice) {
        	out.print("Please enter correct reserve price.");
        	response.sendRedirect("CreateAuctionScreen.jsp");
        	con.close();
        }
        createMileage = Integer.parseInt(request.getParameter("createMileage"));
        createYear = Integer.parseInt(request.getParameter("createYear"));
        createMpg = Integer.parseInt(request.getParameter("createMpg"));
        if(createMileage == 0 || createYear == 0 || createMpg == 0) {
        	out.print("Please enter numbers for the year/mpg/mileage.");
        	response.sendRedirect("CreateAuctionScreen.jsp");
        	con.close();
        }
        if (createYear < 1950 || createMpg < 15 || createMpg > 50) {
        	out.print("Please enter accurate numbers for mpg/year.");
        	response.sendRedirect("CreateAuctionScreen.jsp");
        	con.close();
        }
    } catch (Exception ex) {
    	out.print("Something went wrong.");
    	con.close();
    }
    try {
    	preparedStatement.setString(1,createType);
    	preparedStatement.setString(2,createMake);
    	preparedStatement.setString(3,createColor);
    	preparedStatement.setInt(4,createYear);
    	preparedStatement.setString(5,createCondition);
    	preparedStatement.setInt(6,createMileage);
    	preparedStatement.setInt(7,createMpg);
    	preparedStatement.setDouble(8,initialPrice);
    	preparedStatement.setDouble(9,initialPrice);
    	preparedStatement.setDouble(10,reservePrice);
    	preparedStatement.setDouble(11,250);
    	preparedStatement.setString(12,formattedDate);
    	preparedStatement.setString(13,formattedTime);
    	preparedStatement.setInt(14,userID);
    	preparedStatement.executeUpdate();
    	preparedStatement.close();
    	results = stmt.executeQuery();
    	while (results.next()) {
    		int alertId = results.getInt("Alert_ID");
            String vehicleType = results.getString("Vehicle_Type");
            String vehicleMake = results.getString("Vehicle_Make");
            String vehicleColor = results.getString("Vehicle_Color");
            String vehicleCondition = results.getString("Vehicle_Condition");
            boolean alerted = results.getBoolean("Alerted");
            
            if (vehicleType.equals(createType) && vehicleMake.equals(createMake) && vehicleColor.equals(createColor) && vehicleCondition.equals(createCondition) && alerted != true) {
				String updateQuery = "UPDATE Alerts SET Alerted = ? WHERE Alert_ID = ?";
				PreparedStatement update = con.prepareStatement(updateQuery);
				update.setBoolean(1, true);
				update.setInt(2, alertId);
				int rows = update.executeUpdate();
				if (rows > 0) {
					
				} else {
					out.print("Critical Failure.");
				}
            }
    	}
    	con.close();
    } catch (Exception ex) {
    	out.print("Error connecting to database/insertion.");
    	con.close();
    	preparedStatement.close();
    }
    response.sendRedirect("HomeScreen.jsp");
	%>
</body>
</html>