package com.tourist.servlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.tourist.db.DBConnection;


public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String complaintMessage = request.getParameter("complaintMessage");
        String userID = (String) request.getSession().getAttribute("user");

        String complainNo = UUID.randomUUID().toString().substring(0, 20);

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO ComplainDetails "
                    + "(ComplainNo, complainDate, complainTime, complainMessage, userID) "
                    + "VALUES (?, CURDATE(), CURTIME(), ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, complainNo);
            ps.setString(2, complaintMessage);
            ps.setString(3, userID);

            ps.executeUpdate();

            response.sendRedirect("welcome.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error submitting complaint");
        }
    }
}
