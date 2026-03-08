<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Query | Tourist Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .query-card {
            background: white;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .card-header {
            background: #0d6efd;
            color: white;
            padding: 20px;
            text-align: center;
            border: none;
        }
        .btn-submit {
            background: #0d6efd;
            border: none;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            background: #0b5ed7;
            transform: translateY(-2px);
        }
        .user-badge {
            background: #e9ecef;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            color: #495057;
        }
    </style>
</head>
<body>

<%
    // Session Protection
    String user = (String) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            
            <div class="text-center mb-4">
                <a href="welcome.jsp" class="text-decoration-none text-muted small">← Back to Home</a>
            </div>

            <div class="card query-card">
                <div class="card-header">
                    <h3 class="mb-0">Ask a Question</h3>
                    <p class="small mb-0 opacity-75">We usually respond within 24 hours</p>
                </div>
                
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="user-badge">👤 <%= user %></span>
                        <a href="LogoutServlet" class="text-danger small text-decoration-none">Logout</a>
                    </div>

                    <form action="QueryServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">How can we help you today?</label>
                            <textarea 
                                name="queryMessage" 
                                class="form-control" 
                                rows="5" 
                                placeholder="Describe your query in detail..." 
                                required></textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 btn-submit">
                            Send Query
                        </button>
                    </form>
                </div>
                
                <div class="card-footer bg-light text-center py-3">
                    <small class="text-muted">Need urgent help? Call us at 1-800-TOURIST</small>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>