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

@WebServlet("/viewQueries")
public class ViewQueryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        try {
            // Do NOT use try-with-resources here, or it will close the connection too early
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM QueryDetails";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Pass both the ResultSet AND the Connection to the JSP
            request.setAttribute("queries", rs);
            request.setAttribute("connection", con); 
            
            request.getRequestDispatcher("viewQueries.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=1");
        }
    }
}