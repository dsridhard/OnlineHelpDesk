<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Share Feedback | TouristPortal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #f4f7f6 0%, #e9ecef 100%);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
        }
        .feedback-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: 50px;
        }
        .card-header-custom {
            background: #2a9d8f;
            color: white;
            padding: 30px;
            text-align: center;
        }
        .form-label {
            font-weight: 600;
            color: #264653;
        }
        /* The styled Feedback Textarea */
        .feedback-input {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            transition: all 0.3s ease;
            resize: none;
            font-size: 1.05rem;
        }
        .feedback-input:focus {
            border-color: #2a9d8f;
            box-shadow: 0 0 0 0.25 row rgba(42, 157, 143, 0.25);
            outline: none;
        }
        .char-counter {
            font-size: 0.8rem;
            color: #6c757d;
            text-align: right;
            margin-top: 5px;
        }
        .btn-submit {
            background-color: #2a9d8f;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #21867a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 157, 143, 0.3);
        }
        .user-badge {
            background-color: rgba(42, 157, 143, 0.1);
            color: #2a9d8f;
            padding: 8px 15px;
            border-radius: 30px;
            display: inline-block;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            
            <div class="mt-4">
                <a href="welcome.jsp" class="text-decoration-none text-muted">
                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>

            <div class="card feedback-card">
                <div class="card-header-custom">
                    <i class="fa-solid fa-comment-dots fa-3x mb-3"></i>
                    <h3 class="fw-bold">We value your opinion</h3>
                    <p class="mb-0 opacity-75">Tell us about your recent travel experience</p>
                </div>
                
                <div class="card-body p-4 p-md-5">
                    <div class="text-center">
                        <div class="user-badge">
                            <i class="fa-solid fa-user me-2"></i><strong><%= userName %></strong>
                        </div>
                    </div>

                    <form action="FeedbackServlet" method="post">
                        <div class="mb-4">
                            <label for="feedbackMessage" class="form-label">
                                Your Feedback Message
                            </label>
                            <textarea 
                                name=feedbackMessage 
                                id="feedbackMessage"
                                class="form-control feedback-input" 
                                rows="6" 
                                placeholder="What did you enjoy most about your trip? Any suggestions for us?"
                                maxlength="500"
                                required></textarea>
                            <div class="char-counter">
                                <span id="currentChars">0</span> / 500 characters
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-submit w-100 py-3">
                            <i class="fa-solid fa-paper-plane me-2"></i> Submit Feedback
                        </button>
                    </form>
                </div>
            </div>
            
            <div class="text-center mt-4 mb-5 text-muted small">
                Your feedback helps us provide better service to the tourist community.
            </div>
        </div>
    </div>
</div>

<script>
    // Live Character Counter Script
    const textarea = document.getElementById('feedbackMessage');
    const counter = document.getElementById('currentChars');

    textarea.addEventListener('input', function() {
        const length = textarea.value.length;
        counter.textContent = length;
        
        // Change color as it gets full
        if (length >= 450) {
            counter.style.color = '#dc3545';
        } else {
            counter.style.color = '#6c757d';
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>