<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Guide | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; display: flex; align-items: center; padding: 40px 0; }
        .guide-card { background: #ffffff; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none; }
        .card-header-guide { background: #198754; color: white; border-radius: 15px 15px 0 0; padding: 20px; text-align: center; }
        .form-label { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-7">
            
            <div class="mb-3">
                <a href="adminDashboard.jsp" class="text-decoration-none text-muted small">← Back to Dashboard</a>
            </div>

            <div class="card guide-card">
                <div class="card-header-guide">
                    <h4 class="mb-0">👤 Register New Guide</h4>
                    <p class="small mb-0 opacity-75">Complete all fields to register the guide</p>
                </div>
                
                <div class="card-body p-4">
                    <%-- Alert Handling --%>
                    <%
                        String status = request.getParameter("status");
                        if ("success".equals(status)) {
                    %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            Guide registered successfully!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } else if ("error".equals(status)) { %>
                        <div class="alert alert-danger">Error: Could not save data.</div>
                    <% } %>

                    <%-- IMPORTANT: Added enctype for Image Upload --%>
                   <form action="addGuide" method="post" enctype="multipart/form-data">
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold text-muted">Guide ID</label>
                                <input type="text" name="guideID" class="form-control" placeholder="G-101" required>
                            </div>
                            <div class="col-md-8 mb-3">
                                <label class="form-label fw-bold text-muted">Full Name</label>
                                <input type="text" name="name" class="form-control" placeholder="John Doe" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted">Age</label>
                                <input type="number" name="age" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted">Mobile No</label>
                                <input type="text" name="mobileNo" class="form-control" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted">Places Known</label>
                            <input type="text" name="placesKnown" class="form-control" placeholder="e.g. Paris, Eiffel Tower, Louvre">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted">Languages Known</label>
                            <input type="text" name="languages" class="form-control" placeholder="e.g. English, French" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted">Address</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted">Country</label>
                                <input type="text" name="country" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold text-muted">Availability</label>
                                <select name="availability" class="form-select" required>
                                    <option value="" selected disabled>Select Status</option>
                                    <option value="Full-Time">Full-Time</option>
                                    <option value="Part-Time">Part-Time</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-muted">Qualification</label>
                            <input type="text" name="qualification" class="form-control" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-muted">Guide Photo</label>
                            <input type="file" name="guideImage" class="form-control" accept="image/*" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg">Register Guide</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>