package com.demo.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddFaculty")
public class AddFaculty extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stud_db", "root", "roote");

            String sql = "INSERT INTO faculty (name, email, subject, phone, city) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, phone);
            ps.setString(5, city);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("FacultyDashboard.jsp?msg=Faculty Added");
            } else {
                response.sendRedirect("AddFaculty.jsp?error=Something went wrong");
            }
            con.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AddFaculty.jsp?error=Exception");
        }
    }

}
