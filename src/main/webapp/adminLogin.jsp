<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login | Online Help Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)), 
                        url('https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            font-family: 'Inter', sans-serif;
        }

        .admin-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            padding: 40px;
            width: 100%;
            max-width: 420px;
            border-top: 5px solid #212529;
        }

        .admin-header-icon {
            background-color: #212529;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.5rem;
        }

        .form-control {
            border-radius: 6px;
            padding: 10px 12px;
        }

        .btn-dark {
            border-radius: 6px;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="admin-card">
        <div class="text-center">
            <div class="admin-header-icon shadow">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <h3 class="fw-bold text-dark">Admin Console</h3>
            <p class="text-muted small mb-4">Authorized Personnel Only</p>
        </div>
        <% if("success".equals(request.getParameter("logout"))) { %>
    <div id="logoutAlert" class="container mt-3" style="max-width: 400px;">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-info me-2"></i>
            You have been logged out successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>

    <script>
        // Wait 3 seconds (3000ms) then close the alert
        setTimeout(function() {
            var alertElement = document.getElementById('logoutAlert');
            if (alertElement) {
                // Use Bootstrap's built-in alert close method
                var bsAlert = new bootstrap.Alert(alertElement.querySelector('.alert'));
                bsAlert.close();
                
                // Optional: Clean the URL address bar
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }, 3000);
    </script>
<% } %>

        <% 
            String error = request.getParameter("error");
            if("1".equals(error)) { 
        %>
            <div id="adminErrorAlert" class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>
                    <small><strong>Access Denied:</strong> Invalid Admin Credentials.</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 1rem;"></button>
            </div>

            <script>
                // Auto-close admin alert after 4 seconds
                setTimeout(function() {
                    let alertNode = document.getElementById('adminErrorAlert');
                    if (alertNode) {
                        let bsAlert = new bootstrap.Alert(alertNode);
                        bsAlert.close();
                        
                        // Clean URL to prevent recurring alerts
                        window.history.replaceState({}, document.title, window.location.pathname);
                    }
                }, 4000);
            </script>
        <% } %>

        

        <form action="AdminLoginServlet" method="post">
            <div class="mb-3">
                <label for="adminID" class="form-label small fw-bold text-uppercase text-secondary">Admin ID</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted small"><i class="fa-solid fa-user-lock"></i></span>
                    <input type="text" class="form-control border-start-0" id="adminID" name="adminID" placeholder="Admin Username" required>
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label small fw-bold text-uppercase text-secondary">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted small"><i class="fa-solid fa-key"></i></span>
                    <input type="password" class="form-control border-start-0" id="password" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-dark btn-lg shadow-sm">
                    Secure Login <i class="fa-solid fa-unlock-keyhole ms-2"></i>
                </button>
            </div>

            <div class="text-center mt-4 pt-2 border-top">
                <a href="index.jsp" class="text-decoration-none text-muted small">
                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Public Portal
                </a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>