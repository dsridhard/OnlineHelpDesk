package com.tourist.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get the session (false means don't create a new one if it doesn't exist)
        HttpSession session = request.getSession(false);

        // 2. Check if session exists and has the 'admin' attribute
        if (session == null || session.getAttribute("admin") == null) {
            // Not logged in as admin, send to admin login
            response.sendRedirect("adminLogin.jsp");
        } else {
            // 3. Logged in, so invalidate (kill) the session
            session.invalidate();
            // 4. Redirect to general login or home
            response.sendRedirect("login.jsp");
        }
    }
}