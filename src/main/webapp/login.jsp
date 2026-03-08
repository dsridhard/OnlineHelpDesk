<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Login | Online Help Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease;
        }

        .login-icon-box {
            width: 70px; 
            height: 70px;
            background-color: #0d6efd;
            color: white;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        }

        .form-control {
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
            border-color: #0d6efd;
        }

        .btn-login {
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
        }
    </style>
</head>
<body>

    <div class="container d-flex justify-content-center">
        <div class="login-card text-center">
            
            <div class="login-icon-box">
                <i class="fa-solid fa-user"></i>
            </div>

            <h3 class="mb-2 fw-bold text-dark">User Login</h3>
            <p class="text-muted small mb-4">Welcome back! Please enter your details.</p>

            <% 
                String error = request.getParameter("error");
                if("1".equals(error)) { 
            %>
                <div id="errorAlert" class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                    <div class="d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                        <small><strong>Wrong Credentials!</strong> Try again.</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 1rem;"></button>
                </div>

                <script>
                    // Auto-close after 4 seconds
                    setTimeout(function() {
                        let alertElem = document.getElementById('errorAlert');
                        if (alertElem) {
                            let bsAlert = new bootstrap.Alert(alertElem);
                            bsAlert.close();
                            
                            // Clean the URL: removes "?error=1" so it won't reappear on manual refresh
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    }, 4000);
                </script>
            <% } %>

            <% if("success".equals(request.getParameter("logout"))) { %>
                <div class="alert alert-info py-2 small mb-4 border-0 shadow-sm">
                    Logged out successfully.
                </div>
            <% } %>

            
            <form action="LoginServlet" method="post">
                <div class="mb-3 text-start">
                    <label for="userID" class="form-label fw-semibold small">User ID</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-id-badge text-muted"></i></span>
                        <input type="text" class="form-control border-start-0" id="userID" name="userID" placeholder="Enter your ID" required>
                    </div>
                </div>

                <div class="mb-4 text-start">
                    <label for="password" class="form-label fw-semibold small">Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-lock text-muted"></i></span>
                        <input type="password" class="form-control border-start-0" id="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary btn-login shadow-sm">
                        Sign In <i class="fa-solid fa-right-to-bracket ms-2"></i>
                    </button>
                </div>
                
                <div class="mt-4 border-top pt-3">
                    <p class="small text-muted mb-1">Don't have an account?</p>
                    <a href="registration.jsp" class="text-decoration-none fw-bold">Register Now</a>
                </div>

                <div class="mt-3">
                    <a href="index.jsp" class="text-muted small text-decoration-none">
                        <i class="fa-solid fa-house-chimney me-1"></i> Return to Home
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>