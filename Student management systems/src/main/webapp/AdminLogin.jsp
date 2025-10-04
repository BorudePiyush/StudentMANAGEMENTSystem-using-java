<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Student Management System</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

       
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23ffffff" opacity="0.03"/><circle cx="75" cy="75" r="1" fill="%23ffffff" opacity="0.03"/><circle cx="50" cy="10" r="1" fill="%23ffffff" opacity="0.03"/><circle cx="10" cy="90" r="1" fill="%23ffffff" opacity="0.03"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
            z-index: 1;
        }

        
        .floating-element {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
            z-index: 1;
        }

        .floating-element:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 70%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 15%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(120deg); }
            66% { transform: translateY(-10px) rotate(240deg); }
        }

        @keyframes slideInUp {
            from {
                transform: translateY(100px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .login-container {
            position: relative;
            z-index: 10;
            animation: slideInUp 0.8s ease-out;
            max-width: 450px;
            width: 100%;
        }

        /* === Login Card === */
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .login-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }

        .login-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .admin-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            animation: pulse 2s infinite;
        }

        .admin-avatar i {
            font-size: 2.5rem;
            color: white;
        }

        .login-header h3 {
            color: #333;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .login-header p {
            color: #666;
            margin: 0;
            font-size: 1rem;
        }

        
        .login-form {
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

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 10;
            transition: all 0.3s ease;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 15px 20px 15px 50px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            outline: none;
        }

        .form-control:focus + .input-icon {
            color: #667eea;
            animation: pulse 1s infinite;
        }

        .form-control.is-invalid {
            border-color: #dc3545;
            animation: shake 0.5s ease-in-out;
        }

        .form-control.is-valid {
            border-color: #28a745;
        }

       
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            padding: 5px;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            background: #f8f9fa;
            color: #667eea;
        }

        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .form-check {
            display: flex;
            align-items: center;
        }

        .form-check-input {
            width: 18px;
            height: 18px;
            margin-right: 8px;
            border: 2px solid #dee2e6;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }

        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .forgot-password:hover {
            color: #5a6fd8;
            text-decoration: underline;
        }

       
        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
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
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }

        .btn-login:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-login .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            display: none;
        }

        .btn-login.loading .spinner {
            display: block;
        }

        .btn-login.loading .btn-text {
            display: none;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* === Footer === */
        .login-footer {
            padding: 20px 30px;
            text-align: center;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }

        .login-footer p {
            color: #666;
            margin: 0;
            font-size: 0.9rem;
        }

        .login-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        
        .error-message {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideInUp 0.5s ease-out;
        }

      
        .success-message {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideInUp 0.5s ease-out;
        }

       
        @media (max-width: 576px) {
            .login-container {
                margin: 10px;
            }
            
            .login-header,
            .login-form {
                padding: 30px 20px;
            }
            
            .admin-avatar {
                width: 60px;
                height: 60px;
            }
            
            .admin-avatar i {
                font-size: 2rem;
            }
            
            .login-header h3 {
                font-size: 1.6rem;
            }
            
            .remember-forgot {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }

        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(102, 126, 234, 0.9);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .loading-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top: 3px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
    </style>
</head>
<body>
    
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>

    <!-- Floating Background Elements -->
    <div class="floating-element"></div>
    <div class="floating-element"></div>
    <div class="floating-element"></div>

    <!-- Main Login Container -->
    <div class="login-container">
        <div class="login-card">
            <!-- Header -->
            <div class="login-header">
                <div class="admin-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h3>Admin Login</h3>
                <p>Access the Student Management System</p>
            </div>

            
            <div class="login-form">
                <% 
                String error = request.getParameter("error");
                if (error != null) {
                %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <% if (error.equals("invalid")) { %>
                            Invalid username or password. Please try again.
                        <% } else if (error.equals("session")) { %>
                            Your session has expired. Please login again.
                        <% } else { %>
                            Login failed. Please check your credentials.
                        <% } %>
                    </div>
                <% } %>

                
                <% 
                String success = request.getParameter("success");
                if (success != null && success.equals("logout")) {
                %>
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        You have been successfully logged out.
                    </div>
                <% } %>

                <form action="AdminLogin" method="post" id="loginForm">
                    <!-- Username Field -->
                    <div class="form-group">
                        <label for="adminUsername" class="form-label">
                            <i class="fas fa-user"></i> Username
                        </label>
                        <div class="input-group">
                            <input type="text" 
                                   name="username" 
                                   id="adminUsername" 
                                   class="form-control" 
                                   placeholder="Enter your username"
                                   required 
                                   autocomplete="username"
                                   value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="adminPassword" class="form-label">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="input-group">
                            <input type="password" 
                                   name="password" 
                                   id="adminPassword" 
                                   class="form-control" 
                                   placeholder="Enter your password"
                                   required 
                                   autocomplete="current-password">
                            <i class="fas fa-lock input-icon"></i>
                            <button type="button" class="password-toggle" onclick="togglePassword()">
                                <i class="fas fa-eye" id="passwordToggleIcon"></i>
                            </button>
                        </div>
                    </div>

                   
                    <div class="remember-forgot">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember me
                            </label>
                        </div>
                        <a href="#" class="forgot-password" onclick="showForgotPassword()">
                            Forgot password?
                        </a>
                    </div>

                    <!-- Login Button -->
                    <button type="submit" class="btn-login" id="loginBtn">
                        <div class="spinner"></div>
                        <span class="btn-text">
                            <i class="fas fa-sign-in-alt"></i>
                            Sign In
                        </span>
                    </button>
                </form>
            </div>

            
            <div class="login-footer">
                <p>&copy; 2024 Student Management System. All rights reserved.</p>
                <p>Need help? <a href="#" onclick="showHelp()">Contact Support</a></p>
            </div>
        </div>
    </div>

   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        
        window.addEventListener('load', function() {
            document.getElementById('loadingOverlay').classList.remove('show');
        });

        
        function togglePassword() {
            var passwordInput = document.getElementById('adminPassword');
            var toggleIcon = document.getElementById('passwordToggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            var username = document.getElementById('adminUsername').value.trim();
            var password = document.getElementById('adminPassword').value.trim();
            var loginBtn = document.getElementById('loginBtn');
            
            
            if (username === '' || password === '') {
                e.preventDefault();
                showNotification('Please fill in all fields', 'error');
                return;
            }
            
            if (username.length < 3) {
                e.preventDefault();
                showNotification('Username must be at least 3 characters long', 'error');
                document.getElementById('adminUsername').classList.add('is-invalid');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                showNotification('Password must be at least 6 characters long', 'error');
                document.getElementById('adminPassword').classList.add('is-invalid');
                return;
            }
            
            
            loginBtn.classList.add('loading');
            loginBtn.disabled = true;
            
            
            document.getElementById('loadingOverlay').classList.add('show');
        });

        
        document.getElementById('adminUsername').addEventListener('input', function() {
            this.classList.remove('is-invalid');
            if (this.value.trim().length >= 3) {
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
            }
        });

        document.getElementById('adminPassword').addEventListener('input', function() {
            this.classList.remove('is-invalid');
            if (this.value.trim().length >= 6) {
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
            }
        });

        
        function showForgotPassword() {
            showNotification('Please contact your system administrator for password reset', 'info');
        }

        
        function showHelp() {
            showNotification('For technical support, please contact: admin@studentmanagement.com', 'info');
        }

        
        function showNotification(message, type) {
            var iconClass = 'info-circle';
            if (type === 'success') {
                iconClass = 'check-circle';
            } else if (type === 'error') {
                iconClass = 'exclamation-circle';
            } else if (type === 'warning') {
                iconClass = 'exclamation-triangle';
            }
            
            var notification = document.createElement('div');
            notification.className = 'alert alert-' + (type === 'error' ? 'danger' : type) + ' alert-dismissible fade show position-fixed';
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 10000; min-width: 300px;';
            notification.innerHTML = '<i class="fas fa-' + iconClass + ' me-2"></i>' + 
                                    message + 
                                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            document.body.appendChild(notification);
            
            setTimeout(function() {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 5000);
        }

       
        document.addEventListener('keydown', function(e) {
            
            if (e.key === 'Enter' && (e.target.id === 'adminUsername' || e.target.id === 'adminPassword')) {
                document.getElementById('loginForm').dispatchEvent(new Event('submit'));
            }
            
            
            if (e.key === 'Escape') {
                document.getElementById('loginForm').reset();
                document.querySelectorAll('.is-valid, .is-invalid').forEach(function(el) {
                    el.classList.remove('is-valid', 'is-invalid');
                });
            }
        });

        document.getElementById('adminUsername').focus();

        
        window.addEventListener('load', function() {
            var rememberMe = localStorage.getItem('adminRememberMe');
            var savedUsername = localStorage.getItem('adminUsername');
            
            if (rememberMe === 'true' && savedUsername) {
                document.getElementById('adminUsername').value = savedUsername;
                document.getElementById('rememberMe').checked = true;
            }
        });

        document.getElementById('loginForm').addEventListener('submit', function() {
            var rememberMe = document.getElementById('rememberMe').checked;
            var username = document.getElementById('adminUsername').value;
            
            if (rememberMe) {
                localStorage.setItem('adminRememberMe', 'true');
                localStorage.setItem('adminUsername', username);
            } else {
                localStorage.removeItem('adminRememberMe');
                localStorage.removeItem('adminUsername');
            }
        });

        
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</body>
</html>