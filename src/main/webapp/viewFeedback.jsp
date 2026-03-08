<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback | Admin Console</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    // Session Security Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return; 
    }
%>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-dark">💬 User Feedback</h2>
        <a href="adminDashboard.jsp" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Message</th>
                        <th>Date</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    boolean hasData = false;

                    try {
                        con = DBConnection.getConnection();
                        String sql = "SELECT * FROM FeedbackDetails ORDER BY FeedbackDate DESC, FeedbackTime DESC";
                        stmt = con.createStatement();
                        rs = stmt.executeQuery(sql);

                        while(rs.next()){
                            hasData = true;
                %>
                    <tr>
                        <td><span class="badge bg-primary">#<%= rs.getString("FeedbackNo") %></span></td>
                        <td class="fw-bold"><%= rs.getString("userID") %></td>
                        <td><%= rs.getString("FeedbackMessage") %></td>
                        <td class="text-muted"><%= rs.getString("FeedbackDate") %></td>
                        <td class="text-muted"><%= rs.getString("FeedbackTime") %></td>
                    </tr>
                <%
                        }
                        
                        if (!hasData) {
                %>
                    <tr>
                        <td colspan="5" class="text-center py-5 text-muted">
                            No feedback found in the database.
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>