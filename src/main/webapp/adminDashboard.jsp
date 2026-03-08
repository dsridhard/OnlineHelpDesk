<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String admin = (String) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard | Help Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background: #212529; min-height: 100vh; color: white; }
        .nav-link { color: #adb5bd; transition: 0.3s; }
        .nav-link:hover { color: white; background: #343a40; }
        .stat-card { 
            border: none; 
            border-radius: 15px; 
            transition: transform 0.3s; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .stat-card:hover { transform: translateY(-5px); }
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
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-3">
            <h4 class="text-center mb-4 text-primary">Admin Panel</h4>
            <ul class="nav flex-column">
                <li class="nav-item mb-2"><a class="nav-link active rounded" href="#">🏠 Dashboard</a></li>
                <li class="nav-item mb-2"><a class="nav-link rounded" href="viewQueries.jsp">❓ View Queries</a></li>
                <li class="nav-item mb-2"><a class="nav-link rounded" href="viewComplaints.jsp">⚠️ Complaints</a></li>
                <hr>
                <li class="nav-item"><a class="nav-link text-danger rounded" href="LogoutServlet">🚪 Logout</a></li>
            </ul>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Welcome back, <span class="text-primary"><%= admin %></span></h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-sm btn-outline-secondary">Export Data</button>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-3">
                        <div class="icon-box bg-primary text-white">📍</div>
                        <h5>Manage Places</h5>
                        <p class="text-muted small">Add new tourist locations to the database.</p>
                        <a href="addPlace.jsp" class="btn btn-primary w-100">Add Place</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-3">
                        <div class="icon-box bg-success text-white">👤</div>
                        <h5>Tour Guides</h5>
                        <p class="text-muted small">Register and assign new guides.</p>
                        <a href="addGuide.jsp" class="btn btn-success w-100">Add Guide</a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card stat-card p-3">
                        <div class="icon-box bg-info text-white">💬</div>
                        <h5>User Feedback</h5>
                        <p class="text-muted small">Review comments from your users.</p>
                        <a href="viewFeedback.jsp" class="btn btn-info text-white w-100">View Feedback</a>
                    </div>
                </div>
            </div>

            <div class="mt-4 p-5 bg-white rounded shadow-sm">
                <h4>System Overview</h4>
                <p>Use the cards above to manage your help desk operations. The sidebar provides quick access to user issues and complaints.</p>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>