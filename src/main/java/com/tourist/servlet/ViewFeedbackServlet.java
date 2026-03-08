package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.tourist.db.DBConnection;

@WebServlet("/ViewFeedbackServlet")
public class ViewFeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 2. Database Logic
        try (Connection con = DBConnection.getConnection()) {
            
            String sql = "SELECT * FROM FeedbackDetails ORDER BY FeedbackDate DESC, FeedbackTime DESC";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            // Create a RowSet that lives even after 'con' is closed
            CachedRowSet crs = RowSetProvider.newFactory().createCachedRowSet();
            crs.populate(rs); 

            // 3. Pass data to JSP
            request.setAttribute("feedbacks", crs);
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=db_fail");
        }
    }
}