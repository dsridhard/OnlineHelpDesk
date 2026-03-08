package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.tourist.db.DBConnection;

public class QueryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get Form Data
        String queryMessage = request.getParameter("queryMessage");
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("user");

        // 2. Security & Validation
        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (queryMessage == null || queryMessage.trim().isEmpty()) {
            response.sendRedirect("askQuery.jsp?error=empty");
            return;
        }

        // Generate a clean ID
        String queryNo = "QRY-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        try (Connection con = DBConnection.getConnection()) {
            // Updated SQL to use DB keywords for Date and Time
            String sql = "INSERT INTO QueryDetails "
                    + "(QueryNo, queryDate, queryTime, queryMessage, userID) "
                    + "VALUES (?, CURDATE(), CURTIME(), ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, queryNo);
            ps.setString(2, queryMessage.trim());
            ps.setString(3, userID);

            int rowsAffected = ps.executeUpdate();

            // 3. Conditional Redirect
            if (rowsAffected > 0) {
                // Success: Redirect to welcome with a success flag
                response.sendRedirect("welcome.jsp?query=success");
            } else {
                // Failure: Stay on page and show error
                response.sendRedirect("askQuery.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Printing error to help you debug in the browser if SQL fails
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}