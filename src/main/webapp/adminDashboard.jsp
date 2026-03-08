<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>
<%@ page session="true" %>
<%
    // 1. Session Check
    String adminId = (String) session.getAttribute("admin");
    if(adminId == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // 2. Fetch Admin Details from StaffDetails table
    String displayName = adminId; // Default fallback
    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT AdminName FROM StaffDetails WHERE AdminID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, adminId);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            String name = rs.getString("AdminName");
            if(name != null && !name.isEmpty()) {
                displayName = name;
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard | Help Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background: #212529; min-height: 100vh; color: white; position: sticky; top: 0; }
        .nav-link { color: #adb5bd; transition: 0.3s; padding: 12px 20px; }
        .nav-link:hover { color: white; background: #343a40; }
        .nav-link.active { background: #0d6efd; color: white; }
        .stat-card { 
            border: none; 
            border-radius: 15px; 
            transition: transform 0.3s; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            background: white;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        .icon-box {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar p-3">
            <div class="text-center mb-4">
                <i class="fa-solid fa-shield-halved fa-3x text-primary mb-2"></i>
                <h4 class="fw-bold">Admin Panel</h4>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item mb-2"><a class="nav-link active rounded" href="adminDashboard.jsp"><i class="fa-solid fa-gauge me-2"></i> Dashboard</a></li>
                <li class="nav-item mb-2"><a class="nav-link rounded" href="viewQueries.jsp"><i class="fa-solid fa-question-circle me-2"></i> View Queries</a></li>
                <li class="nav-item mb-2"><a class="nav-link rounded" href="viewComplaints.jsp"><i class="fa-solid fa-circle-exclamation me-2"></i> Complaints</a></li>
                <li class="nav-item mb-2"><a class="nav-link rounded" href="viewFeedback.jsp"><i class="fa-solid fa-star me-2"></i> Feedback</a></li>
                <hr class="text-secondary">
                <li class="nav-item"><a class="nav-link text-danger rounded" href="LogoutServlet"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a></li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            
            <% String status = request.getParameter("status"); 
               if("success".equals(status)) { %>
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> <strong>Success!</strong> Action completed and database updated.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
                <div>
                    <h1 class="h2 fw-bold">Welcome back, <span class="text-primary"><%= displayName %></span></h1>
                    <p class="text-muted">Admin ID: <%= adminId %></p>
                </div>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-sm btn-outline-primary me-2"><i class="fa-solid fa-download me-1"></i> Export Data</button>
                    <button type="button" class="btn btn-sm btn-primary"><i class="fa-solid fa-plus me-1"></i> New Report</button>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-4">
                        <div class="icon-box bg-primary text-white"><i class="fa-solid fa-location-dot"></i></div>
                        <h5 class="fw-bold">Manage Places</h5>
                        <p class="text-muted small">Update or add new tourist locations and landmarks to the explorer list.</p>
                        <a href="addPlace.jsp" class="btn btn-primary w-100 rounded-pill">Add New Place</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-4">
                        <div class="icon-box bg-success text-white"><i class="fa-solid fa-user-tie"></i></div>
                        <h5 class="fw-bold">Tour Guides</h5>
                        <p class="text-muted small">Register professional guides and assign them to specific regions.</p>
                        <a href="addGuide.jsp" class="btn btn-success w-100 rounded-pill">Add New Guide</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-4">
                        <div class="icon-box bg-info text-white"><i class="fa-solid fa-comments"></i></div>
                        <h5 class="fw-bold">User Feedback</h5>
                        <p class="text-muted small">Monitor customer satisfaction and review travel experiences.</p>
                        <a href="viewFeedback.jsp" class="btn btn-info text-white w-100 rounded-pill">View All Feedback</a>
                    </div>
                </div>
            </div>

            <div class="mt-4 p-4 bg-white rounded shadow-sm border-0">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="fw-bold">Recent System Activity</h4>
                    <span class="badge bg-light text-dark border">Real-time Data</span>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Category</th>
                                <th>Last Action</th>
                                <th>Admin Involved</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="badge bg-primary-subtle text-primary px-3">Places</span></td>
                                <td>New Location Added: Paris</td>
                                <td><%= displayName %></td>
                                <td><span class="text-success"><i class="fa-solid fa-check-circle"></i> Complete</span></td>
                            </tr>
                            <tr>
                                <td><span class="badge bg-success-subtle text-success px-3">Guides</span></td>
                                <td>Guide G-105 Status Updated</td>
                                <td>Admin System</td>
                                <td><span class="text-warning"><i class="fa-solid fa-clock"></i> Pending</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>