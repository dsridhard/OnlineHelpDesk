<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection"%>
<%
    String placeId = request.getParameter("placeId");
    String placeName = request.getParameter("placeName");
    String userID = (String) session.getAttribute("user");
    
    if(userID == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Tour | <%= placeName %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #264653 !important; }
        .booking-card { 
            background: white; 
            border-radius: 20px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.1); 
            border: none;
            overflow: hidden;
        }
        .booking-header {
            background: linear-gradient(45deg, #2a9d8f, #264653);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .form-label { font-weight: 600; color: #495057; }
        .btn-confirm { border-radius: 10px; transition: 0.3s; }
        .btn-confirm:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(42, 157, 143, 0.4); }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="welcome.jsp">🌍 TouristPortal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="welcome.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="explorePlaces.jsp">Places</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewPlan.jsp">My Bookings</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                    <li class="nav-item"><a class="btn btn-outline-danger btn-sm ms-lg-3 px-3 mt-1 rounded-pill" href="LogoutServlet">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <div class="booking-card">
                    <div class="booking-header">
                        <i class="fa-solid fa- suitcase-rolling fa-3x mb-3"></i>
                        <h2 class="fw-bold m-0">Finalize Your Trip</h2>
                        <p class="opacity-75 mb-0">You're just one step away from visiting <%= placeName %></p>
                    </div>

                    <div class="p-4 p-md-5">
                        <form action="TourPlanServlet" method="post">
                            
                            <div class="mb-4">
                                <label class="form-label"><i class="fa-solid fa-location-dot me-2"></i>Destination</label>
                                <input type="text" class="form-control form-control-lg bg-light" value="<%=placeName%>" readonly>
                                <input type="hidden" name="placeId" value="<%=placeId%>">
                            </div>

                            <div class="mb-4">
                                <label class="form-label"><i class="fa-solid fa-user-tie me-2"></i>Choose Your Guide</label>
                                <select name="guideId" class="form-select form-select-lg" required>
                                    <option value="" selected disabled>Select an available guide...</option>
                                    <%
                                        try(Connection con = DBConnection.getConnection();
                                            Statement st = con.createStatement();
                                            ResultSet rs = st.executeQuery("SELECT GuideID, GuideName FROM GuideDetails WHERE Availability='Full-Time'")) {
                                            while(rs.next()) {
                                    %>
                                        <option value="<%=rs.getString("GuideID")%>"><%=rs.getString("GuideName")%></option>
                                    <%
                                            }
                                        } catch(Exception e) { e.printStackTrace(); }
                                    %>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label class="form-label"><i class="fa-solid fa-calendar-days me-2"></i>Tour Date</label>
                                    <input type="date" name="tourDate" class="form-control form-control-lg" id="datePicker" required>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label class="form-label"><i class="fa-solid fa-clock me-2"></i>Tour Time</label>
                                    <input type="time" name="tourTime" class="form-control form-control-lg" required>
                                </div>
                            </div>

                            <div class="d-grid gap-2 mt-2">
                                <button type="submit" class="btn btn-success btn-lg btn-confirm fw-bold py-3">
                                    Confirm Itinerary <i class="fa-solid fa-circle-check ms-2"></i>
                                </button>
                                <a href="explorePlaces.jsp" class="btn btn-link text-muted text-decoration-none">
                                    <i class="fa-solid fa-chevron-left me-1"></i> Change Destination
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        document.getElementById('datePicker').min = new Date().toISOString().split("T")[0];
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>