<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Processing</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	//This screen supports both answering and creating questions
	String mode = (String)request.getParameter("Mode");

	//If the mode is User, create a question
	if(mode.equals("User")){
		String questionText = (String)request.getParameter("Question");
		Integer UserID = Integer.parseInt((String)request.getParameter("UserID"));
		String str = "INSERT INTO Question (User_ID, Questions, Responses) VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(str);
		ps.setInt(1, UserID);
		ps.setString(2, questionText);
		ps.setString(3, "Not Yet Answered");
		ps.executeUpdate();
		response.sendRedirect("HomeScreen.jsp");
	}
	else if(mode.equals("Staff")){
		String responseText = (String)request.getParameter("Response");
		Integer StaffID = Integer.parseInt((String)request.getParameter("StaffID"));
		Integer QuestionID = Integer.parseInt((String)request.getParameter("QuestionID"));
		String questionSearch = "SELECT * FROM Question WHERE Question_ID=?";
		PreparedStatement ps = con.prepareStatement(questionSearch);
		ps.setInt(1, QuestionID);
		ResultSet question = ps.executeQuery();
		while(question.next()){
			String responseUpdate = "UPDATE Question SET Staff_ID=?, Responses=? WHERE Question_ID=?";
			PreparedStatement ps2 = con.prepareStatement(responseUpdate);
			ps2.setInt(1, StaffID);
			ps2.setString(2, responseText);
			ps2.setInt(3, QuestionID);
			ps2.executeUpdate();
		}
		question.close();
		response.sendRedirect("RepresentativeScreen.jsp");
	}
	con.close();

%>
</body>
</html>