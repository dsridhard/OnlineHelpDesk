<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Registration | Online Help Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 40px 0;
        }
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
            padding: 30px;
        }
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: #495057;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="register-card">
                <div class="text-center mb-4">
                    <h2 class="text-primary">Create Account</h2>
                    <p class="text-muted">Fill in your details to register for the Help Desk</p>
                </div>

                <form action="RegisterServlet" method="post" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">User ID</label>
                        <input type="text" name="userID" class="form-control" placeholder="Choose a unique ID" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="emailId" class="form-control" placeholder="name@example.com" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Mobile No</label>
                        <input type="tel" name="mobileNo" class="form-control" placeholder="+1 234 567 890">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Languages Known</label>
                        <input type="text" name="languageKnown" class="form-control" placeholder="e.g. English, Spanish">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control" rows="2"></textarea>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Country</label>
                        <input type="text" name="country" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Passport No</label>
                        <input type="text" name="passportNo" class="form-control">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Visa Details</label>
                        <input type="text" name="visaDetail" class="form-control">
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="col-12 mt-4 d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">Register Now</button>
                    </div>
                    
                    <div class="col-12 text-center mt-3">
                        <p class="mb-0">Already have an account? <a href="login.jsp" class="text-decoration-none">Login here</a></p>
                        <a href="index.jsp" class="small text-muted text-decoration-none">← Back to Home</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>