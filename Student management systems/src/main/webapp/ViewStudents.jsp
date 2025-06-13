<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Students</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Student Records</h2>
    <a href="AddStudent.jsp" class="btn btn-success mb-3">Add Student</a>
    <div class="col-md-3 sidebar">
     <a href="LogoutServlet">Logout</a>
     </div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Course</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Map<String, String>> students = (List<Map<String, String>>) request.getAttribute("stud_db");
            if (students != null) {
                for (Map<String, String> s : students) {
        %>
            <tr>
                <td><%= s.get("id") %></td>
                <td><%= s.get("name") %></td>
                <td><%= s.get("email") %></td>
                <td><%= s.get("course") %></td>
                <td>
                    <a href="EditStudent?id=<%= s.get("id") %>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="DeleteStudent?id=<%= s.get("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this student?')">Delete</a>
                </td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>