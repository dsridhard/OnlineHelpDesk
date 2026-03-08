<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Complaint | Tourist Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .complaint-container {
            margin-top: 80px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #dc3545; /* Red for Complaints */
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 20px;
        }
        .user-info {
            background: #fff5f5;
            padding: 10px;
            border-radius: 8px;
            border-left: 4px solid #dc3545;
            margin-bottom: 20px;
        }
        .btn-submit {
            background-color: #dc3545;
            border: none;
            padding: 12px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-submit:hover {
            background-color: #bb2d3b;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<%
    // Session Protection
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return; // Stop processing the rest of the page
    }
%>

<div class="container complaint-container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            
            <div class="text-center mb-3">
                <a href="welcome.jsp" class="text-muted text-decoration-none small">← Back to Dashboard</a>
            </div>

            <div class="card">
                <div class="card-header text-center">
                    <h3 class="mb-0">Report an Issue</h3>
                    <p class="small mb-0">We take your concerns seriously.</p>
                </div>
                
                <div class="card-body p-4">
                    <div class="user-info d-flex justify-content-between align-items-center">
                        <span>Logged in as: <strong><%= user %></strong></span>
                        <a href="LogoutServlet" class="btn btn-sm btn-outline-danger py-0">Logout</a>
                    </div>

                    <form action="ComplaintServlet" method="post">
                        <div class="mb-4">
                            <label class="form-label fw-bold">Describe your complaint:</label>
                            <textarea 
                                name="complaintMessage" 
                                class="form-control" 
                                rows="6" 
                                placeholder="Please provide details about the problem you encountered..." 
                                required></textarea>
                            <div class="form-text mt-2">
                                Please be as specific as possible to help us resolve the issue faster.
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-danger w-100 btn-submit">
                            Submit Complaint
                        </button>
                    </form>
                </div>
                
                <div class="card-footer bg-white text-center border-0 pb-4">
                    <small class="text-muted">Your complaint ID will be generated upon submission.</small>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>