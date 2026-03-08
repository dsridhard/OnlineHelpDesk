<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>

<h2>Available Guides</h2>

<table border="1">
<tr>
    <th>Name</th>
    <th>Languages</th>
    <th>Qualification</th>
    <th>Availability</th>
</tr>

<%
ResultSet rs = (ResultSet) request.getAttribute("guides");

while(rs.next()){
%>
<tr>
    <td><%= rs.getString("GuideName") %></td>
    <td><%= rs.getString("LanguagesKnown") %></td>
    <td><%= rs.getString("Qualification") %></td>
    <td><%= rs.getString("Availability") %></td>
</tr>
<%
}
%>
</table>
</body>
</html>