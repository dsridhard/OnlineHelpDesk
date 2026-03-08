<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Help Desk | Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /* Replace the URL below with your actual image path or a high-res Unsplash link */
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }

        .navbar {
            background-color: rgba(0, 123, 255, 0.9) !important; /* Semi-transparent blue */
            backdrop-filter: blur(5px);
        }

        .hero-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-custom {
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            background: rgba(255, 255, 255, 0.95); /* Slight transparency for a modern look */
            border: none;
        }

        .btn-lg {
            font-weight: 600;
            padding: 12px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <strong>Online Help Desk</strong>
            </a>
        </div>
    </nav>

    <div class="hero-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="card-custom text-center">
                        <h2 class="mb-3 text-primary">Support Portal</h2>
                        <p class="text-muted mb-4">Fast. Reliable. Here for you.</p>
                        
                        <div class="d-grid gap-3">
                            <a href="login.jsp" class="btn btn-primary btn-lg shadow-sm">User Login</a>
                            <a href="registration.jsp" class="btn btn-outline-secondary">Create New Account</a>
                            
                            <div class="position-relative my-4">
                                <hr>
                                <span class="position-absolute top-50 start-50 translate-middle bg-white px-2 text-muted small">ADMIN ONLY</span>
                            </div>
                            
                            <a href="adminLogin.jsp" class="btn btn-dark btn-sm py-2">Administrator Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>