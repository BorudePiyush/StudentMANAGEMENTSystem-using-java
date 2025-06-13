<%@ page session="true" %>
<%
    String facultyUser = (String) session.getAttribute("facultyUser");
    if (facultyUser == null) {
        response.sendRedirect("FacultyLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Faculty</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="card p-4 shadow">
        <h2>Add Faculty Details</h2>
        <form action="AddFaculty" method="post">
            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" class="form-control" required />
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required />
            </div>
            <div class="mb-3">
                <label>Subject</label>
                <input type="text" name="subject" class="form-control" required />
            </div>
            <div class="mb-3">
                <label>Phone</label>
                <input type="text" name="phone" class="form-control" required />
            </div>
            <div class="mb-3">
                <label>City</label>
                <input type="text" name="city" class="form-control" required />
            </div>
            <button type="submit" class="btn btn-primary">Save Faculty</button>
        </form>
    </div>
</div>
</body>
</html>
