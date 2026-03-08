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
    <title>Add New Place | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; display: flex; align-items: center; padding: 40px 0; }
        .form-card { background: #ffffff; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none; overflow: hidden; }
        .form-header { background: #212529; color: white; padding: 20px; text-align: center; }
        .image-preview-box { border: 2px dashed #dee2e6; border-radius: 10px; padding: 20px; text-align: center; background: #fafafa; }
    </style>
</head>
<body>

<div class="container">
<div class="container mt-3">
    <%
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>Success!</strong> The new place has been added to the database.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        } else if ("error".equals(status) || "db_error".equals(status)) {
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Error!</strong> Something went wrong while saving the data. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%
        }
    %>
</div>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            
            <div class="mb-3">
                <a href="adminDashboard.jsp" class="text-decoration-none text-muted small">← Back to Dashboard</a>
            </div>

            <div class="card form-card">
                <div class="form-header">
                    <h4 class="mb-0">📍 Add New Location</h4>
                </div>
                
                <div class="card-body p-4">
                    <form action="AddPlaceServlet" method="post" enctype="multipart/form-data">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold small text-muted">Place ID</label>
                                <input type="text" name="placeID" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold small text-muted">Place Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Country</label>
                            <input type="text" name="country" class="form-control" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">Place Image</label>
                            <div class="image-preview-box">
                                <input type="file" name="placeImage" class="form-control" id="imageInput" accept="image/*" required>
                                <div class="form-text mt-2">Upload a high-quality JPG or PNG (Max 2MB)</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Full Address</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">Description</label>
                            <textarea name="description" class="form-control" rows="3" required></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">Save Place Details</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('status') === 'success') {
        Swal.fire({
            title: 'Great Job!',
            text: 'Data Inserted Successfully',
            icon: 'success',
            confirmButtonColor: '#0d6efd'
        });
    } else if (urlParams.get('status') === 'error') {
        Swal.fire({
            title: 'Oops...',
            text: 'Something went wrong!',
            icon: 'error',
            confirmButtonColor: '#dc3545'
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>