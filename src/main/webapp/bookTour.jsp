<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tourist.db.DBConnection"%>
<%
    String placeId = request.getParameter("placeId");
    String placeName = request.getParameter("placeName");
    String userID = (String) session.getAttribute("user");
    
    if(userID == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Your Tour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 card p-4 shadow-sm border-0" style="border-radius: 15px;">
                <h3 class="fw-bold mb-4 text-primary">Confirm Your Booking</h3>
                
                <form action="TourPlanServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label text-muted">Destination</label>
                        <input type="text" class="form-control bg-light" value="<%=placeName%>" readonly>
                        <input type="hidden" name="placeId" value="<%=placeId%>">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Choose a Guide</label>
                        <select name="guideId" class="form-select" required>
                            <option value="">Select an available guide...</option>
                            <%
                                try(Connection con = DBConnection.getConnection();
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery("SELECT GuideID, GuideName FROM GuideDetails")) {
                                    while(rs.next()) {
                            %>
                                <option value="<%=rs.getString("GuideID")%>"><%=rs.getString("GuideName")%></option>
                            <%
                                    }
                                } catch(Exception e) {}
                            %>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tour Date</label>
                            <input type="date" name="tourDate" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tour Time</label>
                            <input type="time" name="tourTime" class="form-control" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold mt-3" style="border-radius: 10px;">
                        Confirm Itinerary
                    </button>
                    <a href="explorePlaces.jsp" class="btn btn-link w-100 mt-2 text-decoration-none text-muted">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>