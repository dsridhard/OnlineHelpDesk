package com.tourist.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the current session
        HttpSession session = request.getSession(false);
        
        // Default redirect page
        String redirectTo = "login.jsp"; 

        if (session != null) {
            // 2. Determine who is logging out before invalidating
            Object admin = session.getAttribute("admin");
            Object user = session.getAttribute("user");

            if (admin != null) {
                redirectTo = "adminLogin.jsp?logout=success";
            } else if (user != null) {
                redirectTo = "login.jsp?logout=success";
            }

            // 3. Clear data and kill the session
            session.invalidate();
        }

        // 4. Perform the dynamic redirect
        response.sendRedirect(redirectTo);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}