<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, com.demo.controller.Faculty" %>
<%@ page session="true" %>
<%
    String facultyUser = (String) session.getAttribute("facultyUser");
    if (facultyUser == null) {
        response.sendRedirect("FacultyLogin.jsp");
        return;
    }

    List<Faculty> facultyList = (List<Faculty>) request.getAttribute("facultyList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Faculty Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card p-4 shadow">
        <h2 class="mb-4">Faculty Records</h2>

        <a href="AddFaculty.jsp" class="btn btn-success mb-3">Add New Faculty</a>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Subject</th><th>Phone</th><th>City</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (facultyList != null && !facultyList.isEmpty()) {
                    for (Faculty f : facultyList) {
            %>
                <tr>
                    <td><%= f.getId() %></td>
                    <td><%= f.getName() %></td>
                    <td><%= f.getEmail() %></td>
                    <td><%= f.getSubject() %></td>
                    <td><%= f.getPhone() %></td>
                    <td><%= f.getCity() %></td>
                    <td>
                        <a href="EditFaculty.jsp?id=<%= f.getId() %>" class="btn btn-sm btn-warning">Edit</a>
                        <a href="DeleteFaculty?id=<%= f.getId() %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this faculty?');">Delete</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="7" class="text-center text-danger">No faculty records found.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
