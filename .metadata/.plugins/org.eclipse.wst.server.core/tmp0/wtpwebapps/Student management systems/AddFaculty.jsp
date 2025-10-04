
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String facultyUser = (String) session.getAttribute("facultyUser");
    if (facultyUser == null) {
        response.sendRedirect("FacultyLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Faculty - Student Management System</title>
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
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23ffffff" opacity="0.05"/><circle cx="75" cy="75" r="1.5" fill="%23ffffff" opacity="0.03"/><circle cx="50" cy="10" r="0.8" fill="%23ffffff" opacity="0.07"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
        }

        .floating-shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
            z-index: 1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 20%;
            right: 15%;
            animation-delay: 2s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        .shape:nth-child(4) {
            width: 100px;
            height: 100px;
            bottom: 30%;
            right: 10%;
            animation-delay: 1s;
        }

        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInFromLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        
        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
            color: white;
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            z-index: 10;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        
        .breadcrumb-nav {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 15px 25px;
            margin-bottom: 25px;
            animation: slideInFromLeft 1s ease-out;
            z-index: 10;
            position: relative;
        }

        .breadcrumb-nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .breadcrumb-nav a:hover {
            color: #f8f9fa;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            transform: translateX(5px);
        }

        .breadcrumb-separator {
            color: rgba(255, 255, 255, 0.6);
            margin: 0 15px;
        }

       
        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            animation: fadeInUp 1.2s ease-out;
            position: relative;
            z-index: 10;
            max-width: 700px;
            margin: 0 auto;
        }

        .main-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 300% 100%;
            animation: gradientShift 3s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .card-header-custom {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 40px;
            text-align: center;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .card-header-custom h2 {
            color: #333;
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 15px;
            animation: slideDown 1s ease-out;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .card-header-custom p {
            color: #666;
            font-size: 1.1rem;
            margin: 0;
            opacity: 0.9;
        }

        
        .form-container {
            padding: 50px;
            background: white;
        }

        .form-group {
            margin-bottom: 30px;
            animation: fadeInUp 0.8s ease-out;
            animation-fill-mode: both;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        .form-group:nth-child(6) { animation-delay: 0.6s; }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1rem;
        }

        .form-label i {
            color: #667eea;
            width: 20px;
        }

        .form-control-custom {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafbfc;
            position: relative;
        }

        .form-control-custom:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            background: white;
            outline: none;
            transform: translateY(-2px);
        }

        .form-control-custom:hover {
            border-color: #667eea;
            background: white;
        }

        
        .input-group-custom {
            position: relative;
        }

        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.1rem;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .form-control-custom:focus + .input-icon {
            color: #764ba2;
            transform: translateY(-50%) scale(1.1);
        }

        .select-custom {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 12px center;
            background-repeat: no-repeat;
            background-size: 16px;
        }

       
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            animation: fadeInUp 1s ease-out;
            animation-delay: 0.7s;
            animation-fill-mode: both;
        }

        .btn-custom {
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
            cursor: pointer;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            min-width: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary-custom {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        }

        .btn-custom::before {
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

        .btn-custom:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.2);
        }

        .btn-custom:active {
            transform: translateY(-1px);
        }

       
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(102, 126, 234, 0.9);
            display: flex;
            flex-direction: column;
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

        .spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 20px;
        }

        .loading-text {
            color: white;
            font-size: 1.2rem;
            font-weight: 500;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

       
        .form-control-custom.is-invalid {
            border-color: #dc3545;
            animation: shake 0.5s ease-in-out;
        }

        .form-control-custom.is-valid {
            border-color: #28a745;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .invalid-feedback {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .valid-feedback {
            color: #28a745;
            font-size: 0.9rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        
        .success-checkmark {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: block;
            stroke-width: 2;
            stroke: #28a745;
            stroke-miterlimit: 10;
            margin: 10% auto;
            box-shadow: inset 0px 0px 0px #28a745;
            animation: fill 0.4s ease-in-out 0.4s forwards, scale 0.3s ease-in-out 0.9s both;
        }

        .success-checkmark__circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 2;
            stroke-miterlimit: 10;
            stroke: #28a745;
            fill: none;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
        }

        .success-checkmark__check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
        }

        @keyframes stroke {
            100% { stroke-dashoffset: 0; }
        }

        @keyframes scale {
            0%, 100% { transform: none; }
            50% { transform: scale3d(1.1, 1.1, 1); }
        }

        @keyframes fill {
            100% { box-shadow: inset 0px 0px 0px 60px #28a745; }
        }

        
        .progress-container {
            margin: 30px 0;
            animation: fadeInUp 0.8s ease-out;
            animation-delay: 0.8s;
            animation-fill-mode: both;
        }

        .progress-custom {
            height: 8px;
            border-radius: 10px;
            background: #e9ecef;
            overflow: hidden;
        }

        .progress-bar-custom {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 10px;
            transition: width 0.3s ease;
        }

        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .card-header-custom h2 {
                font-size: 1.8rem;
            }
            
            .form-container {
                padding: 30px 20px;
            }
            
            .button-group {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-custom {
                width: 100%;
                margin-bottom: 10px;
            }
            
            .main-card {
                margin: 0 10px;
            }
        }

        @media (max-width: 480px) {
            .header {
                padding: 20px;
            }
            
            .card-header-custom {
                padding: 25px 20px;
            }
            
            .form-container {
                padding: 25px 15px;
            }
            
            .header h1 {
                font-size: 1.8rem;
                flex-direction: column;
                gap: 10px;
            }
        }

        
        .tooltip-custom {
            position: relative;
            display: inline-block;
            cursor: help;
        }

        .tooltip-custom .tooltip-text {
            visibility: hidden;
            width: 200px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 8px;
            position: absolute;
            z-index: 1000;
            bottom: 125%;
            left: 50%;
            margin-left: -100px;
            opacity: 0;
            transition: opacity 0.3s;
            font-size: 0.9rem;
        }

        .tooltip-custom:hover .tooltip-text {
            visibility: visible;
            opacity: 1;
        }
    </style>
</head>
<body>
   
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
        <div class="loading-text">Adding Faculty Member...</div>
    </div>

    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-user-plus"></i>
                Add New Faculty Member
            </h1>
            <p class="subtitle">Join our academic community - Add faculty details below</p>
        </div>

        
        <div class="breadcrumb-nav">
            <a href="FacultyDashboard.jsp">
                <i class="fas fa-tachometer-alt"></i> Faculty Dashboard
            </a>
            <span class="breadcrumb-separator">•</span>
            <span style="color: rgba(255,255,255,0.8);">
                <i class="fas fa-user-plus"></i> Add Faculty
            </span>
        </div>

        
        <div class="main-card">
            <div class="card-header-custom">
                <h2>
                    <i class="fas fa-chalkboard-teacher"></i>
                    Faculty Information
                </h2>
                <p>Please fill in all the required details for the new faculty member</p>
            </div>

            <div class="form-container">
                <!-- Progress Bar -->
                <div class="progress-container">
                    <div class="progress-custom">
                        <div class="progress-bar-custom" id="formProgress" style="width: 0%"></div>
                    </div>
                    <div class="text-center mt-2">
                        <small class="text-muted">Form Completion: <span id="progressText">0%</span></small>
                    </div>
                </div>

                <form id="facultyForm" action="AddFaculty" method="post" novalidate>
                    <!-- Name Field -->
                    <div class="form-group">
                        <label class="form-label" for="name">
                            <i class="fas fa-user"></i>
                            Full Name
                            <span class="tooltip-custom">
                                <i class="fas fa-info-circle text-info"></i>
                                <span class="tooltip-text">Enter the complete name of the faculty member</span>
                            </span>
                        </label>
                        <div class="input-group-custom">
                            <input 
                                type="text" 
                                id="name" 
                                name="name" 
                                class="form-control form-control-custom" 
                                placeholder="Enter full name (e.g., Dr. John Smith)"
                                required 
                                minlength="2"
                                maxlength="50"
                                pattern="[A-Za-z\s\.]+"
                                title="Name should only contain letters, spaces, and dots"
                            />
                            <i class="fas fa-user-tie input-icon"></i>
                        </div>
                        <div class="invalid-feedback"></div>
                        <div class="valid-feedback">
                            <i class="fas fa-check-circle"></i> Looks good!
                        </div>
                    </div>

                    
                    <div class="form-group">
                        <label class="form-label" for="email">
                            <i class="fas fa-envelope"></i>
                            Email Address
                            <span class="tooltip-custom">
                                <i class="fas fa-info-circle text-info"></i>
                                <span class="tooltip-text">Professional email address for communication</span>
                            </span>
                        </label>
                        <div class="input-group-custom">
                            <input 
                                type="email" 
                                id="email" 
                                name="email" 
                                class="form-control form-control-custom" 
                                placeholder="Enter email address (e.g., john.smith@university.edu)"
                                required
                            />
                            <i class="fas fa-at input-icon"></i>
                        </div>
                        <div class="invalid-feedback"></div>
                        <div class="valid-feedback">
                            <i class="fas fa-check-circle"></i> Valid email format!
                        </div>
                    </div>

                    
                    <div class="form-group">
                        <label class="form-label" for="subject">
                            <i class="fas fa-book"></i>
                            Subject/Department
                            <span class="tooltip-custom">
                                <i class="fas fa-info-circle text-info"></i>
                                <span class="tooltip-text">Primary subject or department of expertise</span>
                            </span>
                        </label>
                        <div class="input-group-custom">
                            <select 
                                id="subject" 
                                name="subject" 
                                class="form-control form-control-custom select-custom" 
                                required
                            >
                                <option value="">Select a subject</option>
                                <option value="Computer Science">Computer Science</option>
                                <option value="Mathematics">Mathematics</option>
                                <option value="Java">Java</option>
                                <option value="C++">C++</option>
                                <option value="Biology">Biology</option>
                                <option value="English Literature">English Literature</option>
                                <option value="History">History</option>
                                <option value="Data Science">Data Science</option>
                                <option value="Business Administration">Business Administration</option>
                                <option value="Engineering">Engineering</option>
                                <option value="Psychology">Psychology</option>
                                <option value="Other">Other</option>
                            </select>
                            <i class="fas fa-graduation-cap input-icon"></i>
                        </div>
                        <div class="invalid-feedback"></div>
                        <div class="valid-feedback">
                            <i class="fas fa-check-circle"></i> Subject selected!
                        </div>
                    </div>

                    
                    <div class="form-group">
                        <label class="form-label" for="phone">
                            <i class="fas fa-phone"></i>
                            Phone Number
                            <span class="tooltip-custom">
                                <i class="fas fa-info-circle text-info"></i>
                                <span class="tooltip-text">Contact number for official communication</span>
                            </span>
                        </label>
                        <div class="input-group-custom">
                            <input 
                                type="tel" 
                                id="phone" 
                                name="phone" 
                                class="form-control form-control-custom" 
                                placeholder="Enter phone number (e.g., +1-234-567-8900)"
                                required
                                pattern="1234567890"
                                title="Please enter a valid phone number"
                            />
                            <i class="fas fa-mobile-alt input-icon"></i>
                        </div>
                        <div class="invalid-feedback"></div>
                        <div class="valid-feedback">
                            <i class="fas fa-check-circle"></i> Valid phone number!
                        </div>
                    </div>

                    <!-- City Field -->
                    <div class="form-group">
                        <label class="form-label" for="city">
                            <i class="fas fa-map-marker-alt"></i>
                            City
                            <span class="tooltip-custom">
                                <i class="fas fa-info-circle text-info"></i>
                                <span class="tooltip-text">Current city of residence</span>
                            </span>
                        </label>
                        <div class="input-group-custom">
                            <input 
                                type="text" 
                                id="city" 
                                name="city" 
                                class="form-control form-control-custom" 
                                placeholder="Enter city name (e.g., New York)"
                                required
                                minlength="2"
                                maxlength="50"
                                pattern="[A-Za-z\s]+"
                                title="City name should only contain letters and spaces"
                            />
                            <i class="fas fa-city input-icon"></i>
                        </div>
                        <div class="invalid-feedback"></div>
                        <div class="valid-feedback">
                            <i class="fas fa-check-circle"></i> Valid city name!
                        </div>
                    </div>

                    <!-- Button Group -->
                    <div class="button-group">
                        <button type="submit" class="btn-custom btn-primary-custom" id="submitBtn">
                            <i class="fas fa-save"></i>
                            <span>Save Faculty</span>
                        </button>
                        <a href="FacultyDashboard.jsp" class="btn-custom btn-secondary-custom">
                            <i class="fas fa-times"></i>
                            <span>Cancel</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    
    <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center p-5">
                    <svg class="success-checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                        <circle class="success-checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                        <path class="success-checkmark__check" fill="none" d="m14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>
                    <h3 class="mt-3 text-success">Faculty Added Successfully!</h3>
                    <p class="text-muted">The faculty member has been added to the system.</p>
                    <div class="mt-4">
                        <a href="FacultyDashboard.jsp" class="btn btn-success btn-lg">
                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('facultyForm');
            const inputs = form.querySelectorAll('input, select');
            const submitBtn = document.getElementById('submitBtn');
            const progressBar = document.getElementById('formProgress');
            const progressText = document.getElementById('progressText');
            
            
            inputs.forEach(input => {
                input.addEventListener('input', updateProgress);
                input.addEventListener('blur', validateField);
            });
            
            function updateProgress() {
                const totalFields = inputs.length;
                let filledFields = 0;
                
                inputs.forEach(input => {
                    if (input.value.trim() !== '') {
                        filledFields++;
                    }
                });
                
                const progress = (filledFields / totalFields) * 100;
                progressBar.style.width = progress + '%';
                progressText.textContent = Math.round(progress) + '%';
            }
            
            function validateField(event) {
                const input = event.target;
                const value = input.value.trim();
                
               
                input.classList.remove('is-valid', 'is-invalid');
                
               
                const feedback = input.parentNode.parentNode.querySelector('.invalid-feedback');
                const validFeedback = input.parentNode.parentNode.querySelector('.valid-feedback');
                
                if (feedback) feedback.style.display = 'none';
                if (validFeedback) validFeedback.style.display = 'none';
                
                
                let isValid = true;
                let errorMessage = '';
                
                if (input.required && value === '') {
                    isValid = false;
                    errorMessage = 'This field is required.';
                } else if (input.type === 'email' && value && !isValidEmail(value)) {
                    isValid = false;
                    errorMessage = 'Please enter a valid email address.';
                } else if (input.name === 'phone' && value && !isValidPhone(value)) {
                    isValid = false;
                    errorMessage = 'Please enter a valid phone number.';
                } else if (input.name === 'name' && value && value.length < 2) {
                    isValid = false;
                    errorMessage = 'Name must be at least 2 characters long.';
                }
                
                if (isValid && value !== '') {
                    input.classList.add('is-valid');
                    if (validFeedback) validFeedback.style.display = 'flex';
                } else if (!isValid) {
                    input.classList.add('is-invalid');
                    if (feedback) {
                        feedback.textContent = errorMessage;
                        feedback.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + errorMessage;
                        feedback.style.display = 'flex';
                    }
                }
            }
            
            function isValidEmail(email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailRegex.test(email);
            }
            
            function isValidPhone(phone) {
                const phoneRegex = /^[+]?[\d\s\-\(\)]{10,}$/;
                return phoneRegex.test(phone);
            }
            
            
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                
                
                let isFormValid = true;
                inputs.forEach(input => {
                    validateField({ target: input });
                    if (input.classList.contains('is-invalid') || (input.required && !input.value.trim())) {
                        isFormValid = false;
                    }
                });
                
                if (isFormValid) {
                    
                    document.getElementById('loadingOverlay').classList.add('show');
                    
                    
                    setTimeout(() => {
                        
                        document.getElementById('loadingOverlay').classList.remove('show');
                        
                        
                        form.submit();
                    }, 2000);
                } else {
                   
                    showNotification('Please fill in all required fields correctly.', 'warning');
                }
            });
            
            
            const subjectSelect = document.getElementById('subject');
            subjectSelect.addEventListener('change', function() {
                if (this.value === 'Other') {
                   
                    const customInput = document.createElement('input');
                    customInput.type = 'text';
                    customInput.name = 'subject';
                    customInput.className = 'form-control form-control-custom mt-2';
                    customInput.placeholder = 'Please specify the subject';
                    customInput.required = true;
                    
                    this.parentNode.appendChild(customInput);
                    this.name = 'subject_select';
                    customInput.focus();
                    
                    customInput.addEventListener('blur', validateField);
                    customInput.addEventListener('input', updateProgress);
                }
            });
        });
        
        
        function showNotification(message, type) {
            const iconClass = type === 'success' ? 'check-circle' : 
                            type === 'warning' ? 'exclamation-triangle' : 
                            type === 'error' ? 'exclamation-circle' : 'info-circle';
            
            const notification = document.createElement('div');
            notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 10000; min-width: 300px;';
            notification.innerHTML = `<i class="fas fa-${iconClass} me-2"></i>${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>`;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 5000);
        }
        
        
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            const successModal = new bootstrap.Modal(document.getElementById('successModal'));
            successModal.show();
        } else if (urlParams.get('error')) {
            showNotification('An error occurred while adding the faculty. Please try again.', 'error');
        }
        
       
        document.getElementById('phone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 10) {
                value = value.substring(0, 10);
                value = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
            } else if (value.length >= 6) {
                value = value.replace(/(\d{3})(\d{3})/, '($1) $2-');
            } else if (value.length >= 3) {
                value = value.replace(/(\d{3})/, '($1) ');
            }
            e.target.value = value;
        });
        
        
        document.getElementById('name').addEventListener('input', function(e) {
            const words = e.target.value.split(' ');
            const capitalizedWords = words.map(word => {
                if (word.length > 0) {
                    return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
                }
                return word;
            });
            e.target.value = capitalizedWords.join(' ');
        });
        
        
        document.getElementById('city').addEventListener('input', function(e) {
            const words = e.target.value.split(' ');
            const capitalizedWords = words.map(word => {
                if (word.length > 0) {
                    return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
                }
                return word;
            });
            e.target.value = capitalizedWords.join(' ');
        });
    </script>
</body>
</html>