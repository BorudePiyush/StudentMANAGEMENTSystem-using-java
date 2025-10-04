<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Login - Student Management System</title>
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
            background: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInFromLeft {
            from { opacity: 0; transform: translateX(-50px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
            animation: fadeInUp 1s ease-out;
            position: relative;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
        }

        .login-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 40px 30px 30px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .login-icon {
            font-size: 4rem;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        .login-title {
            color: #333;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
            animation: slideInFromLeft 1.2s ease-out;
        }

        .login-subtitle {
            color: #666;
            font-size: 1rem;
            animation: slideInFromLeft 1.4s ease-out;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
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
            color: #4ecdc4;
            font-size: 1.1rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            border-color: #4ecdc4;
            box-shadow: 0 0 0 0.2rem rgba(78, 205, 196, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 38px;
            cursor: pointer;
            color: #666;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #4ecdc4;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transition: all 0.4s ease;
            transform: translate(-50%, -50%);
        }

        .btn-login:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(78, 205, 196, 0.4);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #4ecdc4;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            color: #44a08d;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .alert-custom {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: none;
            animation: fadeInUp 0.6s ease-out;
        }

        .alert-danger-custom {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        @media (max-width: 576px) {
            .login-header {
                padding: 30px 20px 20px;
            }
            .login-body {
                padding: 30px 20px;
            }
            .login-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="login-icon">
                <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <h2 class="login-title">Faculty Login</h2>
            <p class="login-subtitle">Welcome back! Please sign in to continue</p>
        </div>

        <div class="login-body">
            <% if (request.getParameter("error") != null) { %>
                <div class="alert-custom alert-danger-custom">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Invalid credentials. Please try again.
                </div>
            <% } %>

            <form action="FacultyLogin" method="post" id="loginForm">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i>
                        Username
                    </label>
                    <input type="text" name="username" class="form-control" 
                           placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i>
                        Password
                    </label>
                    <input type="password" name="password" class="form-control" 
                           placeholder="Enter your password" required id="passwordField">
                    <i class="fas fa-eye password-toggle" onclick="togglePassword()"></i>
                </div>

                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                </button>
            </form>

            <div class="back-link">
                <a href="index.html">
                    <i class="fas fa-arrow-left me-1"></i>
                    Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordField = document.getElementById('passwordField');
            const toggleIcon = document.querySelector('.password-toggle');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        // Auto-hide error messages
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