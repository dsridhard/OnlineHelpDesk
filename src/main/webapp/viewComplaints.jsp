<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Complaints | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; padding: 20px; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        th { background-color: #dc3545 !important; color: white !important; } /* Red theme for complaints */
    </style>
</head>
<body>

<%
    // Session Security: Ensure only Admin can see this
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return; 
    }
%>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-danger">🚫 User Complaints</h2>
        <a href="adminDashboard.jsp" class="btn btn-secondary btn-sm">Back to Dashboard</a>
    </div>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Complaint ID</th>
                <th>User ID</th>
                <th>Message</th>
                <th>Date</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>
        <%
            boolean found = false;
            // Direct query using try-with-resources
            try (Connection con = DBConnection.getConnection();
                 Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM ComplainDetails")) {

                while(rs.next()){
                    found = true;
        %>
            <tr>
                <td><strong>#<%= rs.getString("ComplainNo") %></strong></td>
                <td><%= rs.getString("userID") %></td>
                <td><%= rs.getString("complainMessage") %></td>
                <td><%= rs.getDate("complainDate") %></td>
                <td><%= rs.getTime("complainTime") %></td>
            </tr>
        <%
                }
                
                if (!found) {
        %>
            <tr>
                <td colspan="5" class="text-center py-4 text-muted">No complaints filed yet.</td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>