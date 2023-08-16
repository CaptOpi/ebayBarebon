<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Found Users</title>
</head>
<body>
<div class="home-button">
	<a href="RepresentativeScreen.jsp">Go back to Home Screen</a>
</div>
<%
	String searchUsers = request.getParameter("searchField");
    boolean found = false;

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    %>
    <div class="search-results-container">
        <h1>User Results</h1>
        <p>Search Query: <%= searchUsers %> </p>
        <table>
            <tr>
                <th>UserID</th>
                <th>Username</th>
                <th>Password</th>
            </tr>
            <%
           
             String querySearch = "SELECT u.User_ID, u.Username, u.User_Password FROM End_Users u WHERE u.Username LIKE ?";
             PreparedStatement ps = con.prepareStatement(querySearch);
             ps.setString(1, "%" + searchUsers + "%");
             ResultSet result = ps.executeQuery();
             while (result.next()) {
            	 found = true;
                 Integer userID = result.getInt("User_ID");
                 String Username = result.getString("Username");
                 String User_Password = result.getString("User_Password");
                 
            %>
            <tr>
                <td><%= userID %></td>
                <td><%= Username %></td>
                <td><%= User_Password %></td> 
                <td>
                	<form method="post" action="AccountOverview.jsp">
                		<input type="hidden" name="UserID" value=<%=userID%>>
                		<input type="hidden" name="Username" value="<%=Username%>">
                		<input type="hidden" name="Password" value="<%=User_Password%>">
                		<input type="submit" value="Modify Account" name="Edit"/>
            		</form>
            	</td>
            </tr>
            <%
                }
                result.close(); // Close the current ResultSet
            if (!found) {
            %>
            <tr>
                <td>No Users Found</td>
            </tr>
            <%
            }
            %>
        </table>
    </div>
    <%
        // Close resources
        con.close();
    %>
</body>
</html>