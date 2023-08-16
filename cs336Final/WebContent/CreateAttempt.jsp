<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account Page</title>
</head>
<body>
    <h1>Create User</h1>
    
    <form action="CreateAttempt.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" minlength="7" required><br>
        
        <input type="submit" value="Create User">
    </form>

    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username != null && password != null) {
            // Check if the username already exists
            try {
            	ApplicationDB db = new ApplicationDB();	
    			Connection con = db.getConnection();

    			//Create a SQL statement
    			Statement stmt = con.createStatement();
                PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM end_users WHERE Username = ?");
                checkStmt.setString(1, username);
                ResultSet checkResult = checkStmt.executeQuery();
                if (checkResult.next()) {
    				%>
                    <p>Username already exists. Please choose a different username.</p>
    				<%
                } else {
                    // Insert new user into the database
                    PreparedStatement insertStmt = con.prepareStatement("INSERT INTO end_users (username, user_password) VALUES (?, ?)");
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, password);
                    int rowsInserted = insertStmt.executeUpdate();
                    if (rowsInserted > 0) {
   						 %>
                        <p>User created successfully.</p>
    					<%
    					session.setAttribute("user", username);
    					response.sendRedirect("HomeScreen.jsp");
                    } else {
   	 					%>
                        <p>Error creating user.</p>
    					<%
                    }

                    insertStmt.close();
                }

                checkStmt.close();
                con.close();
            } catch (SQLException e) {
    			%>
                <p>Error connecting to the database.</p>
    			<%
            }
        }
    %>
</body>
</html>