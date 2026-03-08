package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.tourist.db.DBConnection;


public class ViewComplaintServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        String admin = (String) request.getSession().getAttribute("admin");
        if(admin == null){
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM ComplainDetails ORDER BY complainDate DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            request.setAttribute("complaints", rs);
            request.getRequestDispatcher("viewComplaints.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}