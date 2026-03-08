<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection, java.util.Base64"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Explore Destinations | TouristPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .place-card {
            border: none; border-radius: 15px; overflow: hidden;
            transition: all 0.3s ease; background: white; height: 100%;
        }
        .place-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.12);
        }
        .card-img-top {
            height: 220px;
            object-fit: cover;
            background-color: #e9ecef;
        }
        .btn-book { border-radius: 25px; padding: 8px 25px; font-weight: 600; }
        .country-badge {
            position: absolute; top: 15px; right: 15px;
            background: rgba(255,255,255,0.9); padding: 5px 15px;
            border-radius: 20px; font-size: 0.8rem; font-weight: bold; color: #0d6efd;
        }
    </style>
</head>
<body>

      <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="welcome.jsp">🌍 TouristPortal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-2"><a class="btn btn-outline-primary rounded-pill" href="welcome.jsp"> <i class="fa-solid fa-house me-2"></i>Dashboard</a></li>
                    <li class="nav-item mx-2"><a href="LogoutServlet" class="btn btn-outline-danger btn-sm rounded-pill mt-1">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold">Explore Available Destinations</h1>
            <p class="text-muted">Hand-picked locations for your next journey</p>
        </div>

        <div class="row g-4">
            <%
            try (Connection con = DBConnection.getConnection();
                 Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM ExplorePlacesDetails")) {

                while (rs.next()) {
                    String pId = rs.getString("PlaceID");
                    String name = rs.getString("NameOfPlace");
                    String country = rs.getString("Country");
                    String desc = rs.getString("Description");
                    
                    // --- IMAGE PROCESSING ---
                    byte[] imgData = rs.getBytes("PlaceImage");
                    String imgHtmlSource = "https://via.placeholder.com/500x300?text=No+Image+Available"; // Default
                    
                    if (imgData != null && imgData.length > 0) {
                        String base64Image = Base64.getEncoder().encodeToString(imgData);
                        imgHtmlSource = "data:image/jpeg;base64," + base64Image;
                    }
            %>
            <div class="col-md-6 col-lg-4">
                <div class="card place-card shadow-sm position-relative">
                    <span class="country-badge shadow-sm"><i class="fa-solid fa-earth-americas"></i> <%=country%></span>
                    
                    <img src="<%=imgHtmlSource%>" class="card-img-top" alt="<%=name%>">
                    
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title fw-bold text-dark mb-2"><%=name%></h5>
                        <p class="card-text text-muted small flex-grow-1">
                            <%= (desc != null && desc.length() > 90) ? desc.substring(0, 90) + "..." : desc %>
                        </p>
                        
                        <div class="mt-3 d-flex justify-content-between align-items-center">
                            <a href="viewPlaceDetails.jsp?id=<%=pId%>" class="btn btn-sm btn-outline-secondary rounded-pill">Details</a>
                            
                            <a href="bookTour.jsp?placeId=<%=pId%>&placeName=<%=java.net.URLEncoder.encode(name, "UTF-8")%>" 
                               class="btn btn-primary btn-book btn-sm">
                               Book Now
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>