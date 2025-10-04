<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - <%= session.getAttribute("name") %></title>
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
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
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

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        @keyframes progressBar {
            from { width: 0; }
            to { width: var(--progress); }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            color: white;
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23ffffff" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="%23ffffff" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
        }

        .student-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 3rem;
            font-weight: 700;
            animation: pulse 2s infinite;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: 4px solid rgba(255, 255, 255, 0.2);
            z-index: 1;
            position: relative;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            z-index: 1;
            position: relative;
        }

        .header .subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            z-index: 1;
            position: relative;
        }

        /* === Top Navigation === */
        .top-nav {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 15px 25px;
            margin-bottom: 25px;
            animation: slideInLeft 1s ease-out;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
        }

        .student-info .details h5 {
            margin: 0;
            font-weight: 600;
        }

        .student-info .details p {
            margin: 0;
            opacity: 0.8;
            font-size: 0.9rem;
        }

        .logout-btn {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
            color: white;
        }

        .container-custom {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .dashboard-cards {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 1.2s ease-out;
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

        .card-header-custom {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 25px 30px;
            border-bottom: 1px solid #dee2e6;
        }

        .card-header-custom h3 {
            color: #333;
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-body-custom {
            padding: 30px;
        }

        .info-table {
            width: 100%;
            margin-bottom: 0;
        }

        .info-table tr {
            border-bottom: 1px solid #f1f3f4;
            transition: all 0.3s ease;
            opacity: 0;
            animation: slideInUp 0.5s ease forwards;
        }

        .info-table tr:nth-child(1) { animation-delay: 0.1s; }
        .info-table tr:nth-child(2) { animation-delay: 0.2s; }
        .info-table tr:nth-child(3) { animation-delay: 0.3s; }
        .info-table tr:nth-child(4) { animation-delay: 0.4s; }
        .info-table tr:nth-child(5) { animation-delay: 0.5s; }
        .info-table tr:nth-child(6) { animation-delay: 0.6s; }
        .info-table tr:nth-child(7) { animation-delay: 0.7s; }

        .info-table tr:last-child {
            border-bottom: none;
        }

        .info-table tr:hover {
            background-color: #f8f9ff;
            transform: translateX(5px);
        }

        .info-table th {
            padding: 15px 0;
            font-weight: 600;
            color: #333;
            width: 40%;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-table td {
            padding: 15px 0;
            color: #666;
            font-weight: 500;
        }

        .info-value {
            font-weight: 600;
            color: #333;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .badge-course {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 8px 16px;
            border-radius: 50px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .status-badge {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 6px 12px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            animation: pulse 2s infinite;
        }

        .attendance-progress {
            margin-top: 20px;
        }

        .attendance-label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .attendance-label h5 {
            margin: 0;
            color: #333;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .attendance-percentage {
            font-size: 1.2rem;
            font-weight: 700;
        }

        .progress-container {
            height: 12px;
            background: #e9ecef;
            border-radius: 6px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar-custom {
            height: 100%;
            border-radius: 6px;
            transition: width 1s ease-out;
            position: relative;
            overflow: hidden;
        }

        .progress-bar-custom::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: shimmer 2s infinite;
        }

        .progress-excellent {
            background: linear-gradient(135deg, #28a745, #20c997);
        }

        .progress-good {
            background: linear-gradient(135deg, #ffc107, #e0a800);
        }

        .progress-warning {
            background: linear-gradient(135deg, #fd7e14, #e8590c);
        }

        .progress-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 25px;
        }

        .action-card {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--action-gradient);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border-color: var(--action-color);
        }

        .action-card .icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: var(--action-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: float 3s ease-in-out infinite;
        }

        .action-card h5 {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .action-card p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        .action-card.profile {
            --action-gradient: linear-gradient(135deg, #667eea, #764ba2);
            --action-color: #667eea;
        }

        .action-card.grades {
            --action-gradient: linear-gradient(135deg, #f093fb, #f5576c);
            --action-color: #f093fb;
        }

        .action-card.schedule {
            --action-gradient: linear-gradient(135deg, #4facfe, #00f2fe);
            --action-color: #4facfe;
        }

        .action-card.assignments {
            --action-gradient: linear-gradient(135deg, #43e97b, #38f9d7);
            --action-color: #43e97b;
        }

        /* === Statistics Cards === */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            animation: fadeInUp 1s ease-out;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--stat-gradient);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: var(--stat-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-card .number {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-card .label {
            color: #666;
            font-weight: 500;
        }

        .stat-card.assignments-stat {
            --stat-gradient: linear-gradient(135deg, #667eea, #764ba2);
        }

        .stat-card.grade-stat {
            --stat-gradient: linear-gradient(135deg, #f093fb, #f5576c);
        }

        .stat-card.courses-stat {
            --stat-gradient: linear-gradient(135deg, #4facfe, #00f2fe);
        }

        .stat-card.attendance-stat {
            --stat-gradient: linear-gradient(135deg, #43e97b, #38f9d7);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .btn-custom {
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 150px;
            justify-content: center;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-success-custom {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
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
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            color: white;
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

        .spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top: 3px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .student-avatar {
                width: 80px;
                height: 80px;
                font-size: 2.5rem;
            }
            
            .top-nav {
                flex-direction: column;
                text-align: center;
            }
            
            .dashboard-cards {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .stats-container {
                grid-template-columns: 1fr 1fr;
            }
            
            .quick-actions {
                grid-template-columns: 1fr 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-custom {
                width: 100%;
                max-width: 300px;
            }
            
            .info-table th,
            .info-table td {
                padding: 12px 0;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 480px) {
            .stats-container,
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <div class="container-custom">
        <!-- Header -->
        <div class="header">
            <div class="student-avatar">
                <%= ((String)session.getAttribute("name")).substring(0, 1).toUpperCase() %>
            </div>
            <h1>Welcome, <%= session.getAttribute("name") %>!</h1>
            <p class="subtitle">Student ID: <%= session.getAttribute("studentId") %> • <%= session.getAttribute("course") %></p>
        </div>

        <div class="top-nav">
            <div class="student-info">
                <div class="details">
                    <h5><i class="fas fa-user-graduate"></i> Student Dashboard</h5>
                    <p>Manage your academic information and progress</p>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="text-white">
                    <i class="fas fa-clock"></i>
                    <span id="currentTime"></span>
                </div>
                <a href="LogoutServlet" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <div class="stats-container">
            <div class="stat-card assignments-stat">
                <div class="icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <div class="number" id="assignmentsCount">12</div>
                <div class="label">Assignments</div>
            </div>
            
            <div class="stat-card grade-stat">
                <div class="icon">
                    <i class="fas fa-medal"></i>
                </div>
                <div class="number" id="gradeAvg">A+</div>
                <div class="label">Grade Average</div>
            </div>
            
            <div class="stat-card courses-stat">
                <div class="icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="number" id="coursesCount">6</div>
                <div class="label">Courses</div>
            </div>
            
            <div class="stat-card attendance-stat">
                <div class="icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="number" id="attendancePercentage">
                    <%
                        Object attendanceObj = session.getAttribute("attendance");
                        double attendance = 85.5; // Default value
                        if (attendanceObj != null) {
                            if (attendanceObj instanceof Double) {
                                attendance = (Double) attendanceObj;
                            } else if (attendanceObj instanceof String) {
                                try {
                                    attendance = Double.parseDouble((String) attendanceObj);
                                } catch (NumberFormatException e) {
                                    attendance = 85.5;
                                }
                            }
                        }
                        DecimalFormat df = new DecimalFormat("#.#");
                    %>
                    <%= df.format(attendance) %>%
                </div>
                <div class="label">Attendance</div>
            </div>
        </div>

        <div class="dashboard-cards">
            <!-- Student Information Card -->
            <div class="main-card">
                <div class="card-header-custom">
                    <h3>
                        <i class="fas fa-user"></i>
                        Student Information
                    </h3>
                </div>
                <div class="card-body-custom">
                    <table class="info-table">
                        <tr>
                            <th>
                                <i class="fas fa-id-card"></i>
                                Student ID
                            </th>
                            <td>
                                <span class="info-value">#<%= session.getAttribute("studentId") %></span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-user"></i>
                                Full Name
                            </th>
                            <td>
                                <span class="info-value"><%= session.getAttribute("name") %></span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-envelope"></i>
                                Email Address
                            </th>
                            <td>
                                <span class="info-value">
                                    <%= session.getAttribute("email") != null ? session.getAttribute("email") : "student@university.edu" %>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-graduation-cap"></i>
                                Course
                            </th>
                            <td>
                                <span class="badge-course">
                                    <i class="fas fa-book-open"></i>
                                    <%= session.getAttribute("course") %>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-phone"></i>
                                Phone Number
                            </th>
                            <td>
                                <span class="info-value">
                                    <%= session.getAttribute("phone") != null ? session.getAttribute("phone") : "+1 (555) 123-4567" %>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-map-marker-alt"></i>
                                City
                            </th>
                            <td>
                                <span class="info-value">
                                    <%= session.getAttribute("city") != null ? session.getAttribute("city") : "Not Specified" %>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <i class="fas fa-user-check"></i>
                                Status
                            </th>
                            <td>
                                <span class="status-badge">
                                    <i class="fas fa-check-circle"></i>
                                    Active Student
                                </span>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="action-buttons">
                        <a href="EditProfile.jsp" class="btn-custom btn-primary-custom">
                            <i class="fas fa-edit"></i>
                            Edit Profile
                        </a>
                        <a href="ViewTranscript.jsp" class="btn-custom btn-success-custom">
                            <i class="fas fa-file-alt"></i>
                            View Transcript
                        </a>
                    </div>
                </div>
            </div>

            <div class="main-card">
                <div class="card-header-custom">
                    <h3>
                        <i class="fas fa-chart-line"></i>
                        Academic Progress
                    </h3>
                </div>
                <div class="card-body-custom">
                    <!-- Attendance Progress -->
                    <div class="attendance-progress">
                        <div class="attendance-label">
                            <h5>
                                <i class="fas fa-calendar-check"></i>
                                Attendance Rate
                            </h5>
                            <span class="attendance-percentage 
                                <% 
                                    String attendanceClass = "text-danger";
                                    if (attendance >= 90) attendanceClass = "text-success";
                                    else if (attendance >= 75) attendanceClass = "text-warning";
                                    else if (attendance >= 60) attendanceClass = "text-info";
                                %>
                                <%= attendanceClass %>">
                                <%= df.format(attendance) %>%
                            </span>
                        </div>
                        <div class="progress-container">
                            <div class="progress-bar-custom 
                                <% 
                                    String progressClass = "progress-danger";
                                    if (attendance >= 90) progressClass = "progress-excellent";
                                    else if (attendance >= 75) progressClass = "progress-good";
                                    else if (attendance >= 60) progressClass = "progress-warning";
                                %>
                                <%= progressClass %>" 
                                style="width: <%= attendance %>%;">
                            </div>
                        </div>
                        <div class="mt-2">
                            <small class="text-muted">
                                <i class="fas fa-info-circle"></i>
                                <% if (attendance >= 75) { %>
                                    You meet the minimum attendance requirement
                                <% } else { %>
                                    <span class="text-warning">Warning: Below minimum attendance (75%)</span>
                                <% } %>
                            </small>
                        </div>
                    </div>

                    <div class="attendance-progress mt-4">
                        <div class="attendance-label">
                            <h5>
                                <i class="fas fa-star"></i>
                                Current GPA
                            </h5>
                            <span class="attendance-percentage text-primary">7.75</span>
                        </div>
                        <div class="progress-container">
                            <div class="progress-bar-custom progress-excellent" style="width: 93.75%;"></div>
                        </div>
                        <div class="mt-2">
                            <small class="text-muted">
                                <i class="fas fa-info-circle"></i>
                                Excellent academic performance!
                            </small>
                        </div>
                    </div>

                    <div class="attendance-progress mt-4">
                        <div class="attendance-label">
                            <h5>
                                <i class="fas fa-graduation-cap"></i>
                                Credits Completed
                            </h5>
                            <span class="attendance-percentage text-info">75 / 120</span>
                        </div>
                        <div class="progress-container">
                            <div class="progress-bar-custom progress-good" style="width: 62.5%;"></div>
                        </div>
                        <div class="mt-2">
                            <small class="text-muted">
                                <i class="fas fa-info-circle"></i>
                                63% towards graduation - Halfway milestone reached
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="quick-actions">
            <div class="action-card profile" onclick="location.href='ViewProfile.jsp'">
                <div class="icon">
                    <i class="fas fa-user-circle"></i>
                </div>
                <h5>View Full Profile</h5>
                <p>View and manage your complete student profile and personal information</p>
            </div>
            
            <div class="action-card grades" onclick="location.href='ViewGrades.jsp'">
                <div class="icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h5>View Grades</h5>
                <p>Check your grades, GPA, and academic performance across all courses</p>
            </div>
            
            <div class="action-card schedule" onclick="location.href='ViewSchedule.jsp'">
                <div class="icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <h5>Class Schedule</h5>
                <p>View your class schedule, timetable, and upcoming academic events</p>
            </div>
            
            <div class="action-card assignments" onclick="location.href='ViewAssignments.jsp'">
                <div class="icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <h5>Assignments</h5>
                <p>View pending assignments, deadlines, and submission status</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            const timeElement = document.getElementById('currentTime');
            if (timeElement) {
                timeElement.textContent = timeString;
            }
        }
        
        updateTime();
        setInterval(updateTime, 1000);
        
        document.addEventListener('DOMContentLoaded', function() {
            const statNumbers = document.querySelectorAll('.stat-card .number');
            statNumbers.forEach((element, index) => {
                setTimeout(() => {
                    element.style.animation = 'pulse 0.6s ease-in-out';
                }, index * 200);
            });
            
            setTimeout(() => {
                const loadingOverlay = document.getElementById('loadingOverlay');
                if (loadingOverlay) {
                    loadingOverlay.classList.remove('show');
                }
            }, 1000);
        });
        
        document.querySelectorAll('.action-card').forEach(card => {
            card.addEventListener('click', function() {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
        
        
        document.querySelectorAll('.info-table tr').forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9ff';
            });
            
            row.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
            });
        });
    </script>
</body>
</html>                                