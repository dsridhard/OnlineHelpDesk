<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection, java.util.Base64" %>
<%
    String placeId = request.getParameter("id");
    if (placeId == null || placeId.isEmpty()) {
        response.sendRedirect("explorePlaces.jsp");
        return;
    }

    String name = "", addr = "", country = "", desc = "", imgBase64 = "";

    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT * FROM ExplorePlacesDetails WHERE PlaceID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, placeId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("NameOfPlace");
            addr = rs.getString("PlaceAddress");
            country = rs.getString("Country");
            desc = rs.getString("Description");
            
            // Image Processing
            byte[] imgBytes = rs.getBytes("PlaceImage");
            if (imgBytes != null && imgBytes.length > 0) {
                imgBase64 = Base64.getEncoder().encodeToString(imgBytes);
            }
        } else {
            response.sendRedirect("explorePlaces.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> | Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hero-section {
            height: 50vh;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
                        url('<%= imgBase64.isEmpty() ? "https://via.placeholder.com/1200x600" : "data:image/jpeg;base64," + imgBase64 %>');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }
        .content-card {
            margin-top: -80px;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .meta-info i { color: #2a9d8f; width: 25px; }
    </style>
</head>
<body class="bg-light">

    <div class="hero-section">
        <div>
            <h1 class="display-3 fw-bold"><%= name %></h1>
            <p class="lead"><i class="fa-solid fa-location-dot me-2"></i><%= country %></p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="content-card">
                    <div class="row">
                        <div class="col-md-8">
                            <h3 class="fw-bold mb-4">About this Destination</h3>
                            <p class="text-muted" style="line-height: 1.8;">
                                <%= desc %>
                            </p>
                            
                            <hr class="my-4">
                            
                            <div class="meta-info">
                                <p><i class="fa-solid fa-map-location-dot"></i> <strong>Address:</strong> <%= addr %></p>
                                <p><i class="fa-solid fa-globe"></i> <strong>Region:</strong> <%= country %></p>
                                <p><i class="fa-solid fa-clock"></i> <strong>Best Time to Visit:</strong> All Year Round</p>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card border-0 bg-primary text-white p-4 text-center rounded-4 shadow-sm">
                                <h4 class="mb-3">Ready to Visit?</h4>
                                <p class="small mb-4">Plan your itinerary with a professional guide to get the most out of your trip.</p>
                                <a href="bookTour.jsp?placeId=<%= placeId %>&placeName=<%= java.net.URLEncoder.encode(name, "UTF-8") %>" 
                                   class="btn btn-light fw-bold rounded-pill py-2 w-100">
                                    Book Tour Now
                                </a>
                            </div>
                            
                            <div class="mt-4">
                                <a href="explorePlaces.jsp" class="btn btn-outline-secondary btn-sm w-100 rounded-pill">
                                    <i class="fa-solid fa-arrow-left me-2"></i>Back to All Places
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>