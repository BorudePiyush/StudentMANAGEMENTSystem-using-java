<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.text.DecimalFormat" %>
<%@ page session="true" %>
    <%
    String studentId = (String) session.getAttribute("studentId");
    if (studentId == null) {
        response.sendRedirect("StudentLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow p-4">
            <h2 class="text-center mb-4">Welcome, <%= session.getAttribute("name") %>!</h2>

            <table class="table table-bordered">
                <tr>
                    <th>Student ID</th>
                    <td><%= session.getAttribute("studentId") %></td>
                </tr>
                <tr>
                    <th>City</th>
                    <td><%= session.getAttribute("city") %></td>
                </tr>
                <tr>
                    <th>Course</th>
                    <td><%= session.getAttribute("course") %></td>
                </tr>
                <tr>
                    <th>Attendance (%)</th>
                    <td><%= new java.text.DecimalFormat("#.##").format(session.getAttribute("attendance")) %>%</td>
                </tr>
            </table>
               <div class="text-center">
                <a href="LogoutServlet" class="btn btn-danger">Logout</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>