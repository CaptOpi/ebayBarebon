<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Home Page</title>
</head>
<body>
<%
    boolean found = false;
	boolean found2 = false;

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    String Username = (String)request.getParameter("Username");
    
    String querySearch = "SELECT User_ID FROM End_Users u WHERE Username LIKE ?";
    PreparedStatement ps = con.prepareStatement(querySearch);
    ps.setString(1, "%" + Username + "%");
    ResultSet users = ps.executeQuery();
    Integer UserID = -1;
    while (users.next()) {
   	 	found = true;
        UserID = users.getInt("User_ID");
        
    }
    users.close();
    %>
   	
   	<div>
   	<h3>Ask Question To Our Customer Representatives</h3>
   	<form method="post" action="SubmitQuestion.jsp">
   		<input type="text" name="Question" value="Ask Here" 
			onfocus="this.value==this.defaultValue?this.value='':null"/>
		<input type="hidden" name="Mode" value="User">
		<input type="hidden" name="UserID" value=<%=UserID%>>
		<input type="submit" name="Submission" value="Enter"/>
   	</form>
   	</div>
   	
	<div class="search-results-container">
        <h1>Active Questions</h1>
        <table>
            <tr>
            	<th>Question ID</th>
                <th>Question</th>
                <th>Response</th>
            </tr>
            <%
        	 
        	 
             String querySearch2 = "SELECT Question_ID, Questions, Responses FROM Question WHERE User_ID=?";
             PreparedStatement ps2 = con.prepareStatement(querySearch2);
             ps2.setInt(1, UserID);
             ResultSet question = ps2.executeQuery();
             while (question.next()) {
            	 found2 = true;
                 Integer Question_ID = question.getInt("Question_ID");
                 String Question = question.getString("Questions");
                 String Response = question.getString("Responses");
                 if(Response==null){
                	 Response = "Not Yet Answered";
                 }
                 
            %>
            <tr>
                <td><%= Question_ID %></td>
                <td><%= Question %></td>
                <td><%= Response %></td>
            </tr>
            <%
                }
                question.close(); // Close the current ResultSet
            if (!found2) {
            %>
            <tr>
                <td>No Questions Found</td>
            </tr>
            <%
            }
            %>
        </table>
    </div>
</body>
</html>