<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection"%>
<%
// 1. Session Security: Check if user is logged in
String currentUserID = (String) session.getAttribute("user");
if (currentUserID == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tour Plans | TouristPortal</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .main-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); }
        .thead-dark { background-color: #264653; color: white; }
        .badge-status { background-color: #e9f5f2; color: #2a9d8f; padding: 6px 12px; border-radius: 50px; font-weight: 600; font-size: 0.75rem; }
        .guide-avatar { width: 35px; height: 35px; background: #e9ecef; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; margin-right: 10px; color: #6c757d; }
        .navbar { margin-bottom: 0; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="welcome.jsp">
                <i class="fa-solid fa-earth-americas me-2"></i>TouristPortal
            </a>
            <div class="d-flex align-items-center">
                <div class="me-3 d-none d-sm-block">
                    <span class="badge bg-light text-dark border p-2">
                        <i class="fa-solid fa-circle-user text-primary me-2"></i>
                        <%= currentUserID %>
                    </span>
                </div>
                <a href="LogoutServlet" class="btn btn-outline-danger btn-sm rounded-pill px-3">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>
<%-- Registration Success Alert --%>
			<%
			if ("success".equals(request.getParameter("status"))) {
			%>
			<div
				class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4"
				role="alert">
				<div class="d-flex align-items-center justify-content-center">
					<i class="fa-solid fa-circle-check me-2"></i> <small>Your Booking is 
			        successful!</small>
				</div>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<%
			}
			%>
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1">My Booked Tours</h2>
                <p class="text-muted">Explore your upcoming adventures and itineraries</p>
            </div>
            <a href="welcome.jsp" class="btn btn-outline-primary rounded-pill px-4"> 
                <i class="fa-solid fa-house me-2"></i>Dashboard
            </a>
        </div>

        <div class="card main-card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="thead-dark">
                            <tr>
                                <th class="ps-4 py-3">ID</th>
                                <th>Destination</th>
                                <th>Tour Guide</th>
                                <th>Schedule</th>
                                <th>Booked On</th>
                                <th class="pe-4 text-center">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            try (Connection con = DBConnection.getConnection()) {
                                // Updated JOIN QUERY based on your specific request
                                String sql = "SELECT t.TourPlanID, t.TourDate, t.TourTime, t.Created, " 
                                           + "Epl.NameOfPlace, g.GuideName "
                                           + "FROM TourPlanDetails t " 
                                           + "JOIN GuideDetails g ON t.GuideID = g.GuideID "
                                           + "JOIN ExplorePlacesDetails Epl ON t.PlaceID = Epl.PlaceID " 
                                           + "WHERE t.userID = ? " 
                                           + "ORDER BY t.TourDate DESC";

                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, currentUserID);
                                ResultSet rs = ps.executeQuery();

                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                            %>
                            <tr>
                                <td class="ps-4 fw-bold text-secondary">#<%=rs.getString("TourPlanID")%></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fa-solid fa-location-dot text-danger me-2"></i> 
                                        <span class="fw-bold"><%=rs.getString("NameOfPlace")%></span>
                                    </div>
                                </td>
                                <td>
                                    <div class="guide-avatar">
                                        <i class="fa-solid fa-user-tie"></i>
                                    </div> <span><%=rs.getString("GuideName")%></span>
                                </td>
                                <td>
                                    <div class="small">
                                        <i class="fa-regular fa-calendar-check me-1 text-primary"></i>
                                        <%=rs.getDate("TourDate")%>
                                    </div>
                                    <div class="small text-muted">
                                        <i class="fa-regular fa-clock me-1"></i>
                                        <%=rs.getTime("TourTime")%>
                                    </div>
                                </td>
                                <td class="text-muted small"><%=rs.getTimestamp("Created")%></td>
                                <td class="pe-4 text-center">
                                    <span class="badge-status">Confirmed</span>
                                </td>
                            </tr>
                            <%
                                }

                                if (!hasData) {
                            %>
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076402.png" width="80" class="mb-3 opacity-50"><br>
                                    <p>You haven't planned any tours yet.</p> 
                                    <a href="explorePlaces.jsp" class="btn btn-primary btn-sm rounded-pill px-4">Start Planning</a>
                                </td>
                            </tr>
                            <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6' class='p-4 text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace();
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
<script>
		window.onload = function() {
			// Find all dismissible alerts inside the login card
			const alerts = document.querySelectorAll('.alert-dismissible');

			alerts.forEach(function(alertElem) {
				// Wait 3.5 seconds
				setTimeout(function() {
					// Create a Bootstrap alert instance and close it
					let bsAlert = bootstrap.Alert
							.getOrCreateInstance(alertElem);
					if (bsAlert) {
						bsAlert.close();
					}

					// Clean URL: removes "?logout=success" or "?error=1" from address bar
					const cleanUrl = window.location.protocol + "//"
							+ window.location.host + window.location.pathname;
					window.history.replaceState({
						path : cleanUrl
					}, '', cleanUrl);
				}, 3500);
			});
		};
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>