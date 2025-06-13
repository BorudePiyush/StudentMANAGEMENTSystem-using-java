
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Student Management System - Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background: #f8f9fa;
    }

    .hero {
      background: linear-gradient(135deg, #0d6efd, #6610f2);
      color: white;
      padding: 60px 0;
      text-align: center;
      border-radius: 0 0 20px 20px;
    }

    .hero h1 {
      font-size: 3rem;
      font-weight: 700;
    }

    .btn-group-custom .btn {
      min-width: 150px;
    }

    .card:hover {
      transform: scale(1.03);
      transition: transform 0.2s ease-in-out;
    }

    footer {
      margin-top: 100px;
    }
  </style>
</head>
<body>

  
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
      <a class="navbar-brand" href="#">Student Management System</a>
    </div>
  </nav>

  
  <div class="hero">
    <div class="container">
      <h1>Welcome to the Student Management System!!!!</h1>
      <p class="lead">Manage Students, Faculty, and Admin.</p>
    </div>
  </div>

  
  <div class="container text-center mt-5">
    <div class="btn-group-custom d-flex justify-content-center gap-3">
      <a href="AdminLogin" class="btn btn-outline-primary">Admin Login</a>
      <a href="FacultyLogin" class="btn btn-outline-secondary">Faculty Login</a>
      <a href="StudentLogin" class="btn btn-outline-success">Student Login</a>
    </div>
  </div>

  
  <div class="container mt-5">
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body text-center">
            <h5 class="card-title">Add New Student</h5>
            <p class="card-text">Insert new student details into the system.</p>
            <a href="AddStudent.jsp" class="btn btn-success">Add Student</a>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body text-center">
            <h5 class="card-title">View All Students</h5>
            <p class="card-text">Browse all students, edit or delete records.</p>
            <a href="ViewStudentsServlet" class="btn btn-primary">View Students</a>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body text-center">
            <h5 class="card-title">About</h5>
            <p class="card-text">Learn more about this Student Management System.</p>
            <a href="#" class="btn btn-info" onclick="alert('This is a simple Java Servlet + JSP project.')">Info</a>
          </div>
        </div>
      </div>
    </div>
  </div>

 
  <footer class="footer mt-auto py-4 bg-light text-center">
    <div class="container">
      <span class="text-muted">&copy; 2025 Student Management System. All Rights Reserved.</span>
    </div>
  </footer>

</body>
</html>
