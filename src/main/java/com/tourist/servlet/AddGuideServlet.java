package com.tourist.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Types;
import com.tourist.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet; // Not needed if using web.xml
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// If you decide to remove web.xml mappings, uncomment the line below:
// @WebServlet("/addGuide") 
@MultipartConfig(maxFileSize = 16177215) 
public class AddGuideServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Collect Data
        String guideID = request.getParameter("guideID");
        String name = request.getParameter("name");
        String placesKnown = request.getParameter("placesKnown");
        String languages = request.getParameter("languages");
        String address = request.getParameter("address");
        String country = request.getParameter("country");
        String qualification = request.getParameter("qualification");
        String age = request.getParameter("age");
        String mobile = request.getParameter("mobileNo");
        String availability = request.getParameter("availability");
        
        // Get AdminID from Session
        String adminID = (String) request.getSession().getAttribute("admin");

        // 2. Handle Image
        InputStream inputStream = null;
        Part filePart = request.getPart("guideImage");
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        // 3. Database Operation
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO GuideDetails (GuideID, GuideName, PlacesKnown, LanguagesKnown, Address, "
                    + "Country, Qualification, Age, MobileNo, Availability, GuideImage, AdminID, UserID, TourPlanID) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, guideID);
            ps.setString(2, name);
            ps.setString(3, placesKnown);
            ps.setString(4, languages);
            ps.setString(5, address);
            ps.setString(6, country);
            ps.setString(7, qualification);

            if (age != null && !age.isEmpty())
                ps.setInt(8, Integer.parseInt(age));
            else
                ps.setNull(8, Types.INTEGER);

            ps.setString(9, mobile);
            ps.setString(10, availability);

            if (inputStream != null)
                ps.setBlob(11, inputStream);
            else
                ps.setNull(11, Types.BLOB);

            ps.setString(12, adminID);
            ps.setNull(13, Types.VARCHAR); 
            ps.setNull(14, Types.VARCHAR); 

            int row = ps.executeUpdate();
            
            // 4. Redirect based on result
            if (row > 0) {
                response.sendRedirect("adminDashboard.jsp?status=success");
            } else {
                response.sendRedirect("addGuide.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Passing the error back to the UI can help debugging
            response.sendRedirect("addGuide.jsp?status=db_error");
        }
    }
}