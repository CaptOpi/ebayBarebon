<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Unanswered User Questions</title>
</head>
<body>
<%
    boolean found = false;

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    
    String staff_name = (String)session.getAttribute("user");
    String str = "SELECT Staff_ID FROM Staff WHERE Username=?";
    PreparedStatement ps = con.prepareStatement(str);
    ps.setString(1, staff_name);
    ResultSet staff = ps.executeQuery();
    
    Integer StaffID = -1;
    while(staff.next()){
    	StaffID = staff.getInt("Staff_ID");
    	
    }
    

    %>
    <div>
   	<h3>Answer Question</h3>
   	<form method="post" action="SubmitQuestion.jsp">
   		<input type="text" name="Response" value="Answer Here" 
			onfocus="this.value==this.defaultValue?this.value='':null"/>
			<input type="text" name = "QuestionID" value="QuestionID"
			onfocus="this.value==this.defaultValue?this.value='':null"/>
		<input type="hidden" name="Mode" value="Staff">
		<input type="hidden" name="StaffID" value=<%=StaffID%>>
		<input type="submit" name="Submission" value="Enter"/>
   	</form>
   	</div>
   	
   	<div class="search-results-container">
        <h1>Unanswered Questions</h1>
        <table>
            <tr>
            	<th>Question ID</th>
                <th>Question</th>
                <th>Response</th>
            </tr>
            <%
            	String querySearch = "SELECT * FROM Question WHERE Responses LIKE ?";
            	PreparedStatement ps2 = con.prepareStatement(querySearch);
            	ps2.setString(1, "Not Yet Answered");
            	ResultSet questions = ps2.executeQuery();
            
            	while(questions.next()){
            		found = true;
            		Integer Question_ID = questions.getInt("Question_ID");
                    String Question = questions.getString("Questions");
                    String Response = questions.getString("Responses");
            %>
            <tr>
                <td><%= Question_ID %></td>
                <td><%=Question %></td>
                <td><%=Response %></td>
            </tr>
            <%
                }
                questions.close(); // Close the current ResultSet
            if (!found) {
            %>
            <tr>
                <td>No Unanswered Questions Found</td>
            </tr>
            <%
            }
            %>
            </table>
    </div>
    
    <div class="search-results-container">
        <h1>Answered Questions</h1>
        <table>
            <tr>
            	<th>Question ID</th>
                <th>Question</th>
                <th>Response</th>
            </tr>
            <%
            	String querySearch2 = "SELECT * FROM Question WHERE Responses <> ?";
            	PreparedStatement ps3 = con.prepareStatement(querySearch2);
            	ps3.setString(1, "Not Yet Answered");
            	ResultSet questions2 = ps3.executeQuery();
            	boolean found2 = false;
            
            	while(questions2.next()){
            		found2 = true;
            		Integer Question_ID = questions2.getInt("Question_ID");
                    String Question = questions2.getString("Questions");
                    String Response = questions2.getString("Responses");
            %>
            <tr>
                <td><%= Question_ID %></td>
                <td><%=Question %></td>
                <td><%=Response %></td>
            </tr>
            <%
                }
                questions2.close(); // Close the current ResultSet
            if (!found2) {
            %>
            <tr>
                <td>No Answered Questions Found</td>
            </tr>
            <%
            }
            %>
            </table>
    </div>
</body>
</html>