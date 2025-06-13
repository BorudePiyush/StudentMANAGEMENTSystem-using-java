package com.demo.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FacultyLogin")
public class FacultyLogin extends HttpServlet {

    // Handles GET request (e.g., if user visits /FacultyLogin directly)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to login page
        response.sendRedirect("FacultyLogin.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("faculty".equals(username) && "faculty123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("facultyUser", username);
            response.sendRedirect("FacultyDashboard.jsp");
        } else {
            response.sendRedirect("FacultyLogin.jsp?error=Invalid Credentials");
        }
    }

}
