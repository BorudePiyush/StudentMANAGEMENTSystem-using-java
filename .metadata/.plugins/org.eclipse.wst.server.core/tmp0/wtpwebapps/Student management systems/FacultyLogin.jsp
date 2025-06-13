<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Faculty Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
 <div class="container mt-5">
        <div class="card mx-auto shadow" style="max-width: 400px;">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">Faculty Login</h3>
                <form action="FacultyLogin" method="post">
                    <div class="mb-3">
                        <label for="facultyUsername" class="form-label">Username</label>
                        <input type="text" name="username" id="facultyUsername" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="facultyPassword" class="form-label">Password</label>
                        <input type="password" name="password" id="facultyPassword" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Login</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>