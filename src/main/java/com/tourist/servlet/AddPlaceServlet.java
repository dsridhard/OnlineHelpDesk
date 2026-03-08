package com.tourist.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.tourist.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/addPlace")
@MultipartConfig(maxFileSize = 16177215) // Max size approx 16MB
public class AddPlaceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Regular Text Fields
        String placeID = request.getParameter("placeID");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String country = request.getParameter("country");
        String description = request.getParameter("description");
        String adminID = (String) request.getSession().getAttribute("admin");

        // Image File Handling
        InputStream inputStream = null; 
        Part filePart = request.getPart("placeImage"); // name must match JSP input name
        
        if (filePart != null) {
            // Obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }

        try (Connection con = DBConnection.getConnection()) {

            // Added Image column to the SQL query
            String sql = "INSERT INTO ExplorePlacesDetails "
                    + "(PlaceID, NameOfPlace, PlaceAddress, Country, Description, AdminID, PlaceImage) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, placeID);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, country);
            ps.setString(5, description);
            ps.setString(6, adminID);
            
            if (inputStream != null) {
                // Fetches input stream and sends it to the database as a Blob
                ps.setBlob(7, inputStream);
            } else {
                ps.setNull(7, java.sql.Types.BLOB);
            }

            int row = ps.executeUpdate();
            if (row > 0) {
                response.sendRedirect("adminDashboard.jsp?success=1");
            } else {
                // Redirect with an error flag
                response.sendRedirect("addPlace.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}