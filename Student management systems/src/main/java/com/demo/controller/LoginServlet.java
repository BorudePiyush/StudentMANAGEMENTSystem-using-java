package com.demo.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Replace with your DB credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "roote";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optional: Redirect to login page on GET request
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String query = "";
            switch (role) {
                case "admin":
                    query = "SELECT * FROM admins WHERE username = admin  AND password = admin123";
                    break;
                case "faculty":
                    query = "SELECT * FROM faculty WHERE username = faculty  AND password = faculty123";
                    break;
                case "student":
                    query = "SELECT * FROM studentss  WHERE username = student AND password = student123";
                    break;
                default:
                    response.sendRedirect("login.jsp?error=invalid");
                    return;
            }

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect based on role
                switch (role) {
                    case "admin":
                        response.sendRedirect("AdminDashboard.jsp");
                        break;
                    case "faculty":
                        response.sendRedirect("FacultyDashboard.jsp");
                        break;
                    case "student":
                        response.sendRedirect("StudentDashboard.jsp");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=invalid");
        }
    }

}
