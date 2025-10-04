<%@ page session="true" %>
<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInFromLeft {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            color: white;
            animation: fadeInUp 0.8s ease-out;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 1s ease-out;
            position: relative;
        }

        .main-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .card-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 30px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .card-header h2 {
            color: #333;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
            animation: slideInFromLeft 1.2s ease-out;
        }

        .card-header .icon {
            font-size: 3rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
            animation: pulse 2s infinite;
        }

        .form-container {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
            animation: fadeInUp 1.4s ease-out;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: #667eea;
            font-size: 1.1rem;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .btn-container {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .btn-custom {
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            min-width: 150px;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary-custom {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
        }

        .btn-back-custom {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .breadcrumb-nav {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 15px 25px;
            margin-bottom: 25px;
            animation: slideInFromLeft 1s ease-out;
        }

        .breadcrumb-nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .breadcrumb-nav a:hover {
            color: #f8f9fa;
        }

        .alert-custom {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: none;
            animation: fadeInUp 0.6s ease-out;
        }

        .alert-success-custom {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-danger-custom {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 25px;
            }
            .btn-container {
                flex-direction: column;
                align-items: center;
            }
            .btn-custom {
                width: 100%;
                max-width: 250px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-graduate"></i> Student Management</h1>
            <p class="subtitle">Add new student to the system</p>
        </div>

        <nav class="breadcrumb-nav">
            <a href="index.html"><i class="fas fa-home"></i> Dashboard</a>
            <span class="mx-2 text-white-50">•</span>
            <a href="AdminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</a>
            <span class="mx-2 text-white-50">•</span>
            <span class="text-white">Add Student</span>
        </nav>

        <div class="main-card">
            <div class="card-header">
                <div class="icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h2>Add New Student</h2>
                <p class="text-muted mb-0">Please fill in all the required information</p>
            </div>

            <div class="form-container">
                <% if (request.getParameter("success") != null) { %>
                    <div class="alert-custom alert-success-custom">
                        <i class="fas fa-check-circle me-2"></i>
                        Student added successfully!
                    </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="alert-custom alert-danger-custom">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        Error adding student. Please try again.
                    </div>
                <% } %>

                <form action="AddStudent" method="post" id="studentForm">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-user"></i>
                                    Full Name
                                </label>
                                <input type="text" name="name" class="form-control" 
                                       placeholder="Enter full name" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-envelope"></i>
                                    Email Address
                                </label>
                                <input type="email" name="email" class="form-control" 
                                       placeholder="Enter email address" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-birthday-cake"></i>
                                    Age
                                </label>
                                <input type="number" name="age" class="form-control" 
                                       placeholder="Enter age" min="16" max="50" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-venus-mars"></i>
                                    Gender
                                </label>
                                <select name="gender" class="form-select" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-graduation-cap"></i>
                                    Course
                                </label>
                                <input type="text" name="course" class="form-control" 
                                       placeholder="Enter course" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-phone"></i>
                                    Phone Number
                                </label>
                                <input type="tel" name="phone" class="form-control" 
                                       placeholder="Enter phone number" required>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-map-marker-alt"></i>
                                    Address
                                </label>
                                <textarea name="address" class="form-control" rows="3" 
                                          placeholder="Enter complete address" required></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn-custom btn-primary-custom">
                            <i class="fas fa-save me-2"></i>Save Student
                        </button>
                        <button type="reset" class="btn-custom btn-secondary-custom">
                            <i class="fas fa-undo me-2"></i>Reset Form
                        </button>
                        <a href="AdminDashboard.jsp" class="btn-custom btn-back-custom">
                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
       
        const form = document.getElementById('studentForm');
        const inputs = form.querySelectorAll('input, select, textarea');

        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validateField(this);
            });
        });

        function validateField(field) {
            const isValid = field.checkValidity();
            
            if (isValid) {
                field.classList.remove('is-invalid');
                field.classList.add('is-valid');
            } else {
                field.classList.remove('is-valid');
                field.classList.add('is-invalid');
            }
        }

        const alerts = document.querySelectorAll('.alert-custom');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });
    </script>
</body>
</html>