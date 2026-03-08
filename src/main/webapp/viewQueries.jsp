<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Queries | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Inter', sans-serif; }
        .table-container { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); padding: 25px; margin-top: 30px; }
        .page-header { border-bottom: 2px solid #eee; margin-bottom: 25px; padding-bottom: 15px; }
        .table thead { background-color: #0d6efd; color: white; }
        .query-id { font-weight: 600; color: #0d6efd; }
    </style>
</head>
<body>

<%
    // Session Security Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return; 
    }
%>

<div class="container pb-5">
    <div class="table-container">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold text-dark mb-1">User Queries</h2>
                <p class="text-muted small mb-0">Review and manage questions from tourists</p>
            </div>
            <a href="adminDashboard.jsp" class="btn btn-outline-primary btn-sm">
                &larr; Back to Dashboard
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th class="border-0"># Query ID</th>
                        <th class="border-0">User ID</th>
                        <th class="border-0">Message</th>
                        <th class="border-0">Date Received</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    boolean hasData = false;
                    // Auto-closes connection, statement, and resultset
                    try (Connection con = DBConnection.getConnection();
                         Statement stmt = con.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM QueryDetails ORDER BY queryDate DESC")) {

                        while(rs.next()){
                            hasData = true;
                %>
                    <tr>
                        <td class="query-id">#<%= rs.getString("QueryNo") %></td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="bg-light rounded-circle p-2 me-2">👤</div>
                                <span><%= rs.getString("userID") %></span>
                            </div>
                        </td>
                        <td class="text-secondary" style="max-width: 300px;"><%= rs.getString("queryMessage") %></td>
                        <td>
                            <span class="badge bg-light text-dark border">
                                <%= rs.getDate("queryDate") %>
                            </span>
                        </td>
                    </tr>
                <%
                        }
                        
                        if (!hasData) {
                %>
                    <tr>
                        <td colspan="4" class="text-center py-5">
                            <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="50" class="mb-3 opacity-50"><br>
                            <span class="text-muted">No queries found in the database.</span>
                        </td>
                    </tr>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='4'><div class='alert alert-danger'>Error: " + e.getMessage() + "</div></td></tr>");
                        e.printStackTrace();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>