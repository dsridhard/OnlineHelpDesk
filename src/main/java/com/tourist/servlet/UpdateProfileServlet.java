package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.tourist.db.DBConnection;

public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("user");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get parameters from form
        String emailId = request.getParameter("emailId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String mobileNo = request.getParameter("mobileNo");
        String languageKnown = request.getParameter("languageKnown");
        String address = request.getParameter("address");
        String country = request.getParameter("country");
        String passportNo = request.getParameter("passportNo");
        String visaDetail = request.getParameter("visaDetail");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE TouristProfileDetails SET FirstName=?, LastName=?, Address=?, "
                       + "Country=?, EmailId=?, MobileNo=?, LanguageKnown=?, PassportNo=?, "
                       + "VisaDetails=?, Modified=NOW() WHERE userID=?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, address);
            ps.setString(4, country);
            ps.setString(5, emailId);
            ps.setString(6, mobileNo);
            ps.setString(7, languageKnown);
            ps.setString(8, passportNo);
            ps.setString(9, visaDetail);
            ps.setString(10, userID);

            ps.executeUpdate();
            response.sendRedirect("profile.jsp?update=success");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=failed");
        }
    }
}