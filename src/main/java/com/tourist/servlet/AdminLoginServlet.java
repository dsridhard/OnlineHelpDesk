package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tourist.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String adminID = request.getParameter("adminID");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM StaffDetails WHERE AdminID=? AND Password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, adminID);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.getSession().setAttribute("admin", adminID);
                response.sendRedirect("adminDashboard.jsp");
            } else {
            	response.sendRedirect("adminLogin.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
