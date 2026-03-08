package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.tourist.db.DBConnection;

public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters (Matching name="feedbackMessage" from your JSP)
        String feedbackMessage = request.getParameter("feedbackMessage");
        
        // 2. Session Management
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("user");

        // 3. Security Check: Ensure user is logged in
        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 4. Validation: Check for empty input
        if (feedbackMessage == null || feedbackMessage.trim().isEmpty()) {
            response.sendRedirect("feedback.jsp?error=empty_message");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            /* DATABASE LOGIC:
               - FeedbackNo: Handled by auto_increment (omit from query)
               - FeedbackDate/Time: Handled by curdate()/curtime() (omit from query)
               - Created/Modified: Handled by CURRENT_TIMESTAMP (omit from query)
            */
            String sql = "INSERT INTO FeedbackDetails (FeedbackMessage, userID) VALUES (?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, feedbackMessage.trim());
            ps.setString(2, userID);

            int result = ps.executeUpdate();

            if (result > 0) {
                // Success: Redirect to welcome page
                response.sendRedirect("welcome.jsp?feedback=success");
            } else {
                // Failure: Redirect back to form
                response.sendRedirect("feedback.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Pass error back to UI for debugging if needed
            response.sendRedirect("feedback.jsp?error=db_error");
        } finally {
            // 5. Always close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}