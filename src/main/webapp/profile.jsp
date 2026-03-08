<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection" %>

<%! 
    // This helper method catches both actual nulls and the string "null"
    public String fixNull(String s) {
        if (s == null || s.trim().equalsIgnoreCase("null") || s.trim().isEmpty()) {
            return "";
        }
        return s.trim();
    }
%>

<%
    // 1. Session Security
    String sessionUser = (String) session.getAttribute("user");
    if(sessionUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // Initialize all variables to empty strings
    String fName = "", lName = "", addr = "", country = "", email = "", 
           mobile = "", lang = "", passport = "", visa = "", created = "";
    
    // 2. Database Fetching
    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT * FROM TouristProfileDetails WHERE userID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, sessionUser);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            fName = fixNull(rs.getString("FirstName"));
            lName = fixNull(rs.getString("LastName"));
            addr = fixNull(rs.getString("Address"));
            country = fixNull(rs.getString("Country"));
            email = fixNull(rs.getString("EmailId"));
            mobile = fixNull(rs.getString("MobileNo"));
            lang = fixNull(rs.getString("LanguageKnown"));
            passport = fixNull(rs.getString("PassportNo"));
            visa = fixNull(rs.getString("VisaDetails"));
            created = fixNull(rs.getString("Created"));
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | TouristPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .profile-card { border: none; border-radius: 25px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; background: white; }
        .profile-header { background: linear-gradient(135deg, #2a9d8f 0%, #264653 100%); height: 140px; }
        .profile-img-container { margin-top: -70px; }
        .profile-icon-circle { width: 130px; height: 130px; border: 6px solid white; background: #f8f9fa; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: #2a9d8f; font-size: 3.5rem; }
        .info-label { color: #8898aa; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; }
        .info-value { color: #32325d; font-weight: 600; margin-bottom: 1.5rem; }
        .section-title { font-size: 1rem; color: #2a9d8f; font-weight: 700; border-bottom: 2px solid #e9ecef; padding-bottom: 5px; margin-bottom: 15px; }
        .doc-box { p-3; border-radius: 15px; background-color: #f8f9fa; border: 1px solid #e9ecef; transition: 0.3s; }
        .doc-box:hover { background-color: #fff; border-color: #2a9d8f; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            
            <div class="mb-4 d-flex justify-content-between align-items-center">
                <a href="welcome.jsp" class="btn btn-sm btn-white bg-white rounded-pill px-3 shadow-sm text-decoration-none">
                    <i class="fa-solid fa-house me-1"></i> Dashboard
                </a>
                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-2">
                    <i class="fa-solid fa-circle-check me-1"></i> Verified Traveler
                </span>
            </div>

            <div class="card profile-card">
                <div class="profile-header"></div>
                
                <div class="profile-img-container text-center">
                    <div class="profile-icon-circle shadow-sm">
                        <i class="fa-solid fa-user-gear"></i>
                    </div>
                </div>

                <div class="card-body px-4 px-md-5 pb-5">
                    <div class="text-center mb-5">
                        <h2 class="fw-bold text-dark mb-1">
                            <%= (fName.isEmpty() && lName.isEmpty()) ? sessionUser : (fName + " " + lName) %>
                        </h2>
                        <p class="text-muted">
                            <i class="fa-solid fa-location-dot me-2 text-danger"></i>
                            <%= country.isEmpty() ? "Location Not Set" : country %>
                        </p>
                    </div>

                    <div class="section-title">Personal Details</div>
                    <div class="row">
                        <div class="col-md-6">
                            <p class="info-label mb-1">Account ID</p>
                            <p class="info-value"><%= sessionUser %></p>
                        </div>
                        <div class="col-md-6">
                            <p class="info-label mb-1">Email Address</p>
                            <p class="info-value"><%= email.isEmpty() ? "No Email Provided" : email %></p>
                        </div>
                        <div class="col-md-6">
                            <p class="info-label mb-1">Mobile</p>
                            <p class="info-value"><%= mobile.isEmpty() ? "Not Linked" : mobile %></p>
                        </div>
                        <div class="col-md-6">
                            <p class="info-label mb-1">Languages</p>
                            <p class="info-value"><%= lang.isEmpty() ? "English" : lang %></p>
                        </div>
                        <div class="col-12">
                            <p class="info-label mb-1">Current Address</p>
                            <p class="info-value"><%= addr.isEmpty() ? "Update address in settings" : addr %></p>
                        </div>
                    </div>

                    <div class="section-title mt-3">Travel Documentation</div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="doc-box p-3">
                                <p class="info-label mb-1 text-primary"><i class="fa-solid fa-passport me-2"></i>Passport Number</p>
                                <p class="info-value mb-0"><%= passport.isEmpty() ? "Pending" : passport %></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="doc-box p-3">
                                <p class="info-label mb-1 text-primary"><i class="fa-solid fa-id-card me-2"></i>Visa Status</p>
                                <p class="info-value mb-0"><%= visa.isEmpty() ? "N/A" : visa %></p>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-3 mt-5">
                        <a href="UpdateProfileServlet.jsp" class="btn btn-primary flex-grow-1 py-3 fw-bold rounded-pill shadow-sm">
                            <i class="fa-solid fa-user-pen me-2"></i> Update Profile
                        </a>
                        <a href="LogoutServlet" class="btn btn-outline-danger py-3 px-4 rounded-pill d-flex align-items-center justify-content-center">
                            <i class="fa-solid fa-power-off"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted small">Registered on: <%= created.isEmpty() ? "March 2026" : created %></p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>