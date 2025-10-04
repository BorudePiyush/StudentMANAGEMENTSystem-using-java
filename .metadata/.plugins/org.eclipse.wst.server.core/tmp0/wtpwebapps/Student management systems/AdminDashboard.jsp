<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    
    // Get current date and time
    Date currentDate = new Date();
    SimpleDateFormat dateFormatter = new SimpleDateFormat("EEEE, MMMM dd, yyyy");
    SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");
    String formattedDate = dateFormatter.format(currentDate);
    String formattedTime = timeFormatter.format(currentDate);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
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
            overflow-x: hidden;
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
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

        @keyframes fadeInScale {
            from {
                transform: scale(0.9);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
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

        .sidebar {
            height: 100vh;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            padding: 0;
            animation: slideInLeft 0.8s ease-in-out;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            background: rgba(0, 0, 0, 0.2);
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h4 {
            color: white;
            font-weight: 700;
            margin: 0;
            font-size: 1.4rem;
        }

        .sidebar-header .admin-info {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin-top: 8px;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .sidebar a {
            color: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            padding: 15px 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .sidebar a::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            transition: width 0.3s ease;
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateX(10px);
            border-left-color: #3498db;
        }

        .sidebar a:hover::before {
            width: 100%;
        }

        .sidebar a.active {
            background: rgba(52, 152, 219, 0.2);
            color: white;
            border-left-color: #3498db;
        }

        .sidebar a i {
            margin-right: 12px;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            border: none;
            border-radius: 50px;
            padding: 12px 20px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.3);
            color: white;
        }

        .main-content {
            margin-left: 300px;
            padding: 0;
            min-height: 100vh;
            transition: margin-left 0.3s ease;
        }

        /* === Header === */
        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 25px 30px;
            color: white;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header .welcome-text {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-top: 5px;
        }

        .header .date-time {
            font-size: 0.9rem;
            opacity: 0.8;
            margin-top: 10px;
        }

        .content {
            padding: 30px;
            background: rgba(255, 255, 255, 0.05);
            min-height: calc(100vh - 120px);
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            animation: fadeInScale 0.9s ease-in-out;
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
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
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

        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out;
        }

        .quick-actions h3 {
            color: #333;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 25px 20px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            background: #f8f9fa;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            transition: width 0.3s ease;
            z-index: 0;
        }

        .action-btn:hover::before {
            width: 100%;
        }

        .action-btn:hover {
            border-color: #667eea;
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
        }

        .action-btn i {
            font-size: 2rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .action-btn span {
            font-weight: 600;
            position: relative;
            z-index: 1;
        }

        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 1.2s ease-out;
        }

        .recent-activity h3 {
            color: #333;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f1f3f4;
            transition: all 0.3s ease;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:hover {
            background: #f8f9ff;
            padding-left: 10px;
            border-radius: 8px;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1rem;
        }

        .activity-icon.add {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .activity-icon.edit {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .activity-icon.delete {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .activity-text {
            flex: 1;
        }

        .activity-text .action {
            font-weight: 500;
            color: #333;
        }

        .activity-text .time {
            font-size: 0.85rem;
            color: #666;
            margin-top: 2px;
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

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* === Responsive Design === */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .mobile-toggle {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1001;
                background: rgba(255, 255, 255, 0.2);
                border: none;
                color: white;
                font-size: 1.2rem;
                padding: 10px;
                border-radius: 8px;
                backdrop-filter: blur(10px);
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }
        }

        .mobile-toggle {
            display: none;
        }

        .floating-element {
            animation: float 3s ease-in-out infinite;
        }

        .system-status {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }

        .status-indicator {
            width: 12px;
            height: 12px;
            background: #28a745;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }

        .status-text {
            color: white;
            font-size: 0.85rem;
            background: rgba(0, 0, 0, 0.3);
            padding: 5px 10px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body>
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <button class="mobile-toggle" id="mobileToggle">
        <i class="fas fa-bars"></i>
    </button>

    <div class="system-status">
        <div class="status-text">
            <span class="status-indicator"></span>
            System Online
        </div>
    </div>

    <div class="container-fluid p-0">
        <div class="row g-0">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar" id="sidebar">
                    <div class="sidebar-header">
                        <h4><i class="fas fa-shield-alt"></i> Admin Panel</h4>
                        <div class="admin-info">
                            <i class="fas fa-user-circle"></i> Welcome, <%= adminUser %>
                        </div>
                    </div>
                    
                    <div class="sidebar-menu">
                        <a href="AdminDashboard.jsp" class="active">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a href="AddStudent.jsp">
                            <i class="fas fa-user-plus"></i> Add Student
                        </a>
                        <a href="ViewStudentsServlet">
                            <i class="fas fa-users"></i> View Students
                        </a>
                        <a href="ManageFaculty.jsp">
                            <i class="fas fa-chalkboard-teacher"></i> Manage Faculty
                        </a>
                        <a href="Reports.jsp">
                            <i class="fas fa-chart-bar"></i> Reports
                        </a>
                        <a href="Settings.jsp">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                        <a href="SystemLogs.jsp">
                            <i class="fas fa-file-alt"></i> System Logs
                        </a>
                    </div>
                    
                    <a href="LogoutServlet" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <div class="col-md-9">
                <div class="main-content">
                    <!-- Header -->
                    <div class="header" data-aos="fade-down">
                        <h1><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
                        <div class="welcome-text">Welcome back, <%= adminUser %>! Here's what's happening today.</div>
                        <div class="date-time">
                            <i class="fas fa-calendar-day"></i> <%= formattedDate %>
                            <span class="ms-3"><i class="fas fa-clock"></i> <span id="currentTime"><%= formattedTime %></span></span>
                        </div>
                    </div>

                    <div class="content">
                        <!-- Dashboard Stats -->
                        <div class="stats-container">
                            <div class="stat-card floating-element" data-aos="fade-up" data-aos-delay="100">
                                <div class="icon">
                                    <i class="fas fa-user-graduate"></i>
                                </div>
                                <div class="number" id="totalStudents">245</div>
                                <div class="label">Total Students</div>
                            </div>

                            <div class="stat-card floating-element" data-aos="fade-up" data-aos-delay="200">
                                <div class="icon">
                                    <i class="fas fa-chalkboard-teacher"></i>
                                </div>
                                <div class="number" id="totalFaculty">18</div>
                                <div class="label">Faculty Members</div>
                            </div>

                            <div class="stat-card floating-element" data-aos="fade-up" data-aos-delay="300">
                                <div class="icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <div class="number" id="totalCourses">12</div>
                                <div class="label">Active Courses</div>
                            </div>

                            <div class="stat-card floating-element" data-aos="fade-up" data-aos-delay="400">
                                <div class="icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="number" id="todayAdmissions">5</div>
                                <div class="label">Today's Admissions</div>
                            </div>
                        </div>

                        <div class="quick-actions" data-aos="fade-up" data-aos-delay="500">
                            <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                            <div class="actions-grid">
                                <a href="AddStudent.jsp" class="action-btn">
                                    <i class="fas fa-user-plus"></i>
                                    <span>Add Student</span>
                                </a>
                                <a href="ViewStudentsServlet" class="action-btn">
                                    <i class="fas fa-users"></i>
                                    <span>View Students</span>
                                </a>
                                <a href="GenerateReport.jsp" class="action-btn">
                                    <i class="fas fa-file-pdf"></i>
                                    <span>Generate Report</span>
                                </a>
                                <a href="SendNotification.jsp" class="action-btn">
                                    <i class="fas fa-bell"></i>
                                    <span>Send Notification</span>
                                </a>
                                <a href="BackupData.jsp" class="action-btn">
                                    <i class="fas fa-database"></i>
                                    <span>Backup Data</span>
                                </a>
                                <a href="SystemSettings.jsp" class="action-btn">
                                    <i class="fas fa-cog"></i>
                                    <span>System Settings</span>
                                </a>
                            </div>
                        </div>

                        <div class="recent-activity" data-aos="fade-up" data-aos-delay="600">
                            <h3><i class="fas fa-history"></i> Recent Activity</h3>
                            <div class="activity-list">
                                <div class="activity-item">
                                    <div class="activity-icon add">
                                        <i class="fas fa-plus"></i>
                                    </div>
                                    <div class="activity-text">
                                        <div class="action">New student "Rohan Shinde" added to Computer Science</div>
                                        <div class="time">2 minutes ago</div>
                                    </div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon edit">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class="activity-text">
                                        <div class="action">Student record updated for "Nishant Borude"</div>
                                        <div class="time">15 minutes ago</div>
                                    </div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon add">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="activity-text">
                                        <div class="action">New faculty member "Piyush Borude" registered</div>
                                        <div class="time">1 hour ago</div>
                                    </div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon delete">
                                        <i class="fas fa-trash"></i>
                                    </div>
                                    <div class="activity-text">
                                        <div class="action">Student "Dev Sonavane" removed from system</div>
                                        <div class="time">3 hours ago</div>
                                    </div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon edit">
                                        <i class="fas fa-download"></i>
                                    </div>
                                    <div class="activity-text">
                                        <div class="action">Monthly report generated and downloaded</div>
                                        <div class="time">1 day ago</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    
    <script>
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true
        });

        window.addEventListener('load', function() {
            document.getElementById('loadingOverlay').classList.remove('show');
            updateCurrentTime();
            animateStats();
        });

        function updateCurrentTime() {
            var now = new Date();
            var timeString = now.toLocaleTimeString();
            document.getElementById('currentTime').textContent = timeString;
        }

        setInterval(updateCurrentTime, 1000);

        function animateStats() {
            animateNumber('totalStudents', 245);
            animateNumber('totalFaculty', 18);
            animateNumber('totalCourses', 12);
            animateNumber('todayAdmissions', 5);
        }

        function animateNumber(elementId, target) {
            var element = document.getElementById(elementId);
            var current = 0;
            var increment = target / 50;
            var timer = setInterval(function() {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                element.textContent = Math.floor(current);
            }, 30);
        }

        var mobileToggle = document.getElementById('mobileToggle');
        var sidebar = document.getElementById('sidebar');

        mobileToggle.addEventListener('click', function() {
            sidebar.classList.toggle('show');
        });

        document.addEventListener('click', function(event) {
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !mobileToggle.contains(event.target)) {
                    sidebar.classList.remove('show');
                }
            }
        });

        var links = document.querySelectorAll('a');
        for (var i = 0; i < links.length; i++) {
            links[i].addEventListener('click', function(e) {
                if (!this.hasAttribute('data-bs-toggle') && 
                    this.getAttribute('href') && 
                    this.getAttribute('href') != '#' &&
                    !this.getAttribute('href').startsWith('mailto:')) {
                    document.getElementById('loadingOverlay').classList.add('show');
                }
            });
        }

        function showNotification(message, type) {
            var iconClass = 'info-circle';
            if (type == 'success') {
                iconClass = 'check-circle';
            } else if (type == 'danger' || type == 'error') {
                iconClass = 'exclamation-circle';
            } else if (type == 'warning') {
                iconClass = 'exclamation-triangle';
            }
            
            var notification = document.createElement('div');
            notification.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
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

        setTimeout(function() {
            showNotification('Welcome to Admin Dashboard! All systems are operational.', 'success');
        }, 1000);

        function handleResize() {
            if (window.innerWidth > 768) {
                sidebar.classList.remove('show');
            }
        }

        window.addEventListener('resize', handleResize);
    </script>
</body>
</html>