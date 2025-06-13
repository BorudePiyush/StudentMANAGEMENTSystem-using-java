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
@WebServlet("/StudentLogin")
public class StudentLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to DB
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/stud_db", "root", "roote"
            );

            PreparedStatement stmt = con.prepareStatement(
                    "SELECT * FROM students WHERE student_id = ? AND password = ?");
                stmt.setString(1, studentId);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("studentId", studentId);
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("city", rs.getString("city"));
                session.setAttribute("course", rs.getString("course"));
                session.setAttribute("attendance", rs.getDouble("attendance"));
                 response.sendRedirect("StudentDashboard.jsp");
            } else {
                response.sendRedirect("StudentLogin.jsp?error=Invalid+Credentials");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StudentLogin.jsp?error=Server+Error");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("StudentLogin.jsp");
    }
}
