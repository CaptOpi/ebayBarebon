<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Attempt</title>
</head>
<body>
<% try{ 
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get parameters from the HTML form at the index.jsp
			String newUsername = request.getParameter("username");
			String newPassword = request.getParameter("password");
			
			
			String str2 = "SELECT s.Staff_ID FROM Staff s WHERE s.Username=? AND s.Staff_Password=?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
			PreparedStatement ps2 = con.prepareStatement(str2);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			
			
			String str = "SELECT u.User_ID FROM End_Users u WHERE u.Username=? AND u.User_Password=?";
			PreparedStatement ps = con.prepareStatement(str);
			ps.setString(1, newUsername);
			ps.setString(2, newPassword);
			ResultSet users = ps.executeQuery();
			
			ps2.setString(1, newUsername);
			ps2.setString(2, newPassword);
			ResultSet staff = ps2.executeQuery();
			session.setAttribute("incorrect", "false");
			
			//Checks if the second query produced a staff account
			if(staff.next() == true){
				Integer StaffID = staff.getInt("Staff_ID");
				session.setAttribute("user", newUsername);
				session.setAttribute("Staff_ID", staff.getInt("Staff_ID"));
				//Checks if the staff account is a Customer Representative or Administrative
				String str3 = "SELECT c.Staff_ID FROM Customer_Representatives c WHERE c.Staff_ID=?";
				String str4 = "SELECT a.Staff_ID FROM Administrative a WHERE a.Staff_ID=?";
				PreparedStatement ps3 = con.prepareStatement(str3);
				PreparedStatement ps4 = con.prepareStatement(str4);
				ps3.setInt(1, StaffID);
				ps4.setInt(1, StaffID);
				ResultSet rep = ps3.executeQuery();
				ResultSet admin = ps4.executeQuery();
				if(rep.next() == true){
					session.setAttribute("user", newUsername);
					session.setAttribute("Staff_ID", StaffID);
					response.sendRedirect("RepresentativeScreen.jsp");
					rep.close();
				}
				else if(admin.next()== true){
					session.setAttribute("user", newUsername);
					session.setAttribute("Staff_ID", StaffID);
					response.sendRedirect("AdminScreen.jsp");
					admin.close();
				}
				else{
					//Staff account exists, but does not exist in either representative or admin table. SQL error.
					out.println("SQL Database error. Staff account exists, but does not exists in either the representative or administrative tables.");
					session.setAttribute("incorrect", "test staff login error");
					response.sendRedirect("LoginScreen.jsp");
				}
				
			}
			else if(users.next() == true){
				session.setAttribute("user", newUsername);
				session.setAttribute("User_ID", users.getInt("User_ID"));
				out.print("Login succeeded");
				response.sendRedirect("HomeScreen.jsp");
			}
			else{
				out.print("Incorrect Username and-or Password.");
				session.setAttribute("incorrect", "true");
				response.sendRedirect("LoginScreen.jsp");
			}
			
			
			
			
			
			users.close();
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			staff.close();
			con.close();
			
			
	}catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}%>
</body>
</html>