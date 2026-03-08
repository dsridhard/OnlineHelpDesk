<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>
<%
    // Security Check
    String userID = (String) session.getAttribute("user");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch existing data
    String firstName="", lastName="", email="", mobile="", lang="", addr="", country="", passport="", visa="";
    
    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT * FROM TouristProfileDetails WHERE userID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userID);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            firstName = rs.getString("FirstName");
            lastName = rs.getString("LastName");
            email = rs.getString("EmailId");
            mobile = rs.getString("MobileNo");
            lang = rs.getString("LanguageKnown");
            addr = rs.getString("Address");
            country = rs.getString("Country");
            passport = rs.getString("PassportNo");
            visa = rs.getString("VisaDetails");
        }
    } catch (Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile | Tourist Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; padding-top: 50px; }
        .profile-card { background: white; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); border: none; }
        .form-label { font-weight: 600; color: #555; font-size: 0.9rem; }
    </style>
</head>
<body>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            
            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="welcome.jsp" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left"></i> Back</a>
                <h3 class="fw-bold m-0">My Profile</h3>
            </div>

            <%-- Success Alert --%>
            <% if("success".equals(request.getParameter("update"))) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    Profile updated successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="card profile-card p-4">
                <form action="UpdateProfileServlet" method="post" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">User ID (ReadOnly)</label>
                        <input type="text" class="form-control bg-light" value="<%= userID %>" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="emailId" class="form-control" value="<%= email %>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" value="<%= firstName %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" value="<%= lastName %>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Mobile No</label>
                        <input type="tel" name="mobileNo" class="form-control" value="<%= (mobile == null) ? "" : mobile %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Languages Known</label>
                        <input type="text" name="languageKnown" class="form-control" value="<%= (lang == null) ? "" : lang %>">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control" rows="2"><%= (addr == null) ? "" : addr %></textarea>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Country</label>
                        <input type="text" name="country" class="form-control" value="<%= (country == null) ? "" : country %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Passport No</label>
                        <input type="text" name="passportNo" class="form-control" value="<%= (passport == null) ? "" : passport %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Visa Details</label>
                        <input type="text" name="visaDetail" class="form-control" value="<%= (visa == null) ? "" : visa %>">
                    </div>

                    <div class="col-12 mt-4 text-end">
                        <button type="submit" class="btn btn-primary px-5">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>