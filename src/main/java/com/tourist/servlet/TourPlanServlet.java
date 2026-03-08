package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Time;
import java.util.UUID;

import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet; // ❌ Removed
import jakarta.servlet.http.*;
import com.tourist.db.DBConnection;

// ❌ @WebServlet("/TourPlanServlet") Removed - now handled by web.xml
public class TourPlanServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("user");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String placeID = request.getParameter("placeId");
        String guideID = request.getParameter("guideId");
        String tourDate = request.getParameter("tourDate");
        String tourTime = request.getParameter("tourTime");
        
        // Generate Unique ID
        String tourPlanID = "TP-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            String query = "INSERT INTO TourPlanDetails "
                    + "(TourPlanID, TourDate, TourTime, userID, PlaceID, GuideID, Created, Modified) "
                    + "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

            ps = con.prepareStatement(query);

            ps.setString(1, tourPlanID);
            ps.setDate(2, Date.valueOf(tourDate));
            
            if (tourTime != null && tourTime.length() == 5) tourTime += ":00"; 
            ps.setTime(3, Time.valueOf(tourTime));
            
            ps.setString(4, userID);
            ps.setString(5, placeID);
            ps.setString(6, guideID);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("viewPlan.jsp?status=success");
            } else {
                response.getWriter().println("Failed to save tour plan.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}