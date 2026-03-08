package com.tourist.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tourist.db.DBConnection;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Capture ALL parameters from JSP (names must match exactly)
        String userID = request.getParameter("userID");
        String emailId = request.getParameter("emailId"); // Fixed name
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String mobileNo = request.getParameter("mobileNo");
        String languageKnown = request.getParameter("languageKnown");
        String address = request.getParameter("address");
        String country = request.getParameter("country");
        String passportNo = request.getParameter("passportNo");
        String visaDetail = request.getParameter("visaDetail");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            // 2. Comprehensive SQL Query matching your table structure
            String query = "INSERT INTO TouristProfileDetails "
                    + "(userID, FirstName, LastName, Address, Country, EmailId, MobileNo, "
                    + "LanguageKnown, Password, PassportNo, VisaDetails, Created, Modified) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userID);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, address);
            ps.setString(5, country);
            ps.setString(6, emailId);
            ps.setString(7, mobileNo);
            ps.setString(8, languageKnown);
            ps.setString(9, password);
            ps.setString(10, passportNo);
            ps.setString(11, visaDetail);

            int result = ps.executeUpdate();

            if (result > 0) {
                // Success: Redirect to login with a success message
                response.sendRedirect("login.jsp?reg=success");
            } else {
                response.sendRedirect("registration.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registration.jsp?error=db");
        }
    }
}