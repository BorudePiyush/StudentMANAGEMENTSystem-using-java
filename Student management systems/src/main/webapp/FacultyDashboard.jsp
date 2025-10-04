<!-- filepath: g:\java project task\student management systems\Student management systems\src\main\webapp\FacultyDashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
    <title>Faculty Dashboard - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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

        /* === Animations === */
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
            50% { transform: scale(1.02); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        /* === Header === */
        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            margin: 20px;
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

        .header h1 {
            font-size: 2.8rem;
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
            margin: 0 20px 25px 20px;
            animation: slideInFromLeft 1s ease-out;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .breadcrumb-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .breadcrumb-nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .breadcrumb-nav a:hover {
            color: #f8f9fa;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .nav-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .current-time {
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 15px;
            border-radius: 20px;
            color: white;
            font-weight: 500;
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

        /* === Statistics Cards === */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 0 20px 30px 20px;
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
            background: var(--gradient);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: float 3s ease-in-out infinite;
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

        .stat-card.faculty {
            --gradient: linear-gradient(135deg, #667eea, #764ba2);
        }

        .stat-card.students {
            --gradient: linear-gradient(135deg, #f093fb, #f5576c);
        }

        .stat-card.courses {
            --gradient: linear-gradient(135deg, #4facfe, #00f2fe);
        }

        .stat-card.active {
            --gradient: linear-gradient(135deg, #43e97b, #38f9d7);
        }

        /* === Main Card === */
        .main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 1.2s ease-out;
            position: relative;
            margin: 0 20px;
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
            padding: 30px;
            border-bottom: 1px solid #dee2e6;
        }

        .card-header-custom h2 {
            color: #333;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 15px;
            animation: slideInFromLeft 1.2s ease-out;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-message {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            padding: 20px;
            border-radius: 12px;
            color: #1565c0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* === Controls Section === */
        .controls-section {
            padding: 25px 30px;
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-container {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-container input {
            width: 100%;
            padding: 12px 50px 12px 20px;
            border: 2px solid #e9ecef;
            border-radius: 50px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .search-container input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }

        .search-container .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.1rem;
        }

        /* === Action Buttons === */
        .btn-custom {
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-refresh {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
        }

        .btn-export {
            background: linear-gradient(135deg, #6f42c1, #563d7c);
            color: white;
            box-shadow: 0 4px 15px rgba(111, 66, 193, 0.3);
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

        /* === Table Styling === */
        .table-container {
            padding: 30px;
            overflow-x: auto;
        }

        .table {
            margin-bottom: 0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .table thead th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 12px;
            font-weight: 600;
            text-align: center;
            white-space: nowrap;
        }

        .table tbody td {
            padding: 15px 12px;
            border-color: #f1f3f4;
            vertical-align: middle;
            text-align: center;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9ff;
            transform: scale(1.01);
        }

        /* === Action Buttons in Table === */
        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-sm-custom {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            min-width: 70px;
        }

        .btn-edit {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-view {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-sm-custom:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* === Empty State === */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
        }

        .empty-state .icon {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        /* === Loading Animation === */
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
            .header h1 {
                font-size: 2rem;
            }
            
            .top-nav {
                flex-direction: column;
                text-align: center;
                margin: 0 10px 20px 10px;
            }
            
            .controls-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-container {
                min-width: auto;
            }
            
            .table-container {
                padding: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .stats-container {
                grid-template-columns: 1fr 1fr;
                margin: 0 10px 20px 10px;
            }

            .main-card {
                margin: 0 10px;
            }
        }

        @media (max-width: 480px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <div class="container-fluid">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-chalkboard-teacher"></i> Faculty Dashboard</h1>
            <p class="subtitle">Manage Faculty Members and Academic Information</p>
        </div>

        <!-- Top Navigation -->
        <div class="top-nav">
            <div class="breadcrumb-nav">
                <a href="index.html"><i class="fas fa-home"></i> Dashboard</a>
                <span class="mx-2 text-white-50">•</span>
                <span class="text-white">Faculty Management</span>
            </div>
            <div class="nav-actions">
                <div class="current-time">
                    <i class="fas fa-clock"></i>
                    <span id="currentTime"></span>
                </div>
                <a href="LogoutServlet" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <!-- Welcome Message -->
        <div class="stats-container">
            <div class="stat-card faculty">
                <div class="icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div class="number" id="totalFaculty">0</div>
                <div class="label">Total Faculty</div>
            </div>
            <div class="stat-card students">
                <div class="icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="number" id="totalStudents">0</div>
                <div class="label">Students</div>
            </div>
            <div class="stat-card courses">
                <div class="icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="number" id="totalCourses">0</div>
                <div class="label">Subjects</div>
            </div>
            <div class="stat-card active">
                <div class="icon">
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="number">1</div>
                <div class="label">Active User</div>
            </div>
        </div>

        <!-- Main Card -->
        <div class="main-card">
            <div class="card-header-custom">
                <div class="welcome-message">
                    <i class="fas fa-user-tie"></i>
                    <div>
                        <strong>Welcome back, <%= facultyUser %>!</strong>
                        <p class="mb-0">Here's your faculty management dashboard</p>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h2><i class="fas fa-users-cog"></i> Faculty Management</h2>
                        <p class="text-muted mb-0">Manage and view all faculty information</p>
                    </div>
                </div>
            </div>

            <!-- Controls Section -->
            <div class="controls-section">
                <div class="search-container">
                    <input type="text" id="globalSearch" placeholder="Search faculty by name, email, subject...">
                    <i class="fas fa-search search-icon"></i>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <a href="AddFaculty.jsp" class="btn-custom btn-add">
                        <i class="fas fa-plus"></i> Add Faculty
                    </a>
                    <button onclick="refreshData()" class="btn-custom btn-refresh">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                    <button onclick="exportData()" class="btn-custom btn-export">
                        <i class="fas fa-download"></i> Export CSV
                    </button>
                </div>
            </div>

            <!-- Table Section -->
            <div class="table-container">
                <%
                    int facultyCount = 0;
                    int courseCount = 0;
                    boolean hasData = false;
                %>
                <table class="table table-striped" id="facultyTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag"></i> ID</th>
                            <th><i class="fas fa-user"></i> Name</th>
                            <th><i class="fas fa-envelope"></i> Email</th>
                            <th><i class="fas fa-book"></i> Subject</th>
                            <th><i class="fas fa-phone"></i> Phone</th>
                            <th><i class="fas fa-map-marker-alt"></i> City</th>
                            <th><i class="fas fa-cogs"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stud_db", "root", "roote");

                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM faculty");

                                while (rs.next()) {
                                    hasData = true;
                                    facultyCount++;
                        %>
                        <tr>
                            <td><strong>#<%= rs.getInt("id") %></strong></td>
                            <td>
                                <div class="d-flex align-items-center justify-content-center">
                                    <div class="rounded-circle bg-primary d-flex align-items-center justify-content-center me-2" 
                                         style="width: 35px; height: 35px; color: white; font-weight: bold;">
                                        <%= rs.getString("name").substring(0, 1).toUpperCase() %>
                                    </div>
                                    <%= rs.getString("name") %>
                                </div>
                            </td>
                            <td>
                                <a href="mailto:<%= rs.getString("email") %>" class="text-decoration-none">
                                    <i class="fas fa-envelope me-1"></i><%= rs.getString("email") %>
                                </a>
                            </td>
                            <td>
                                <span class="badge bg-info text-dark rounded-pill px-3 py-2">
                                    <%= rs.getString("subject") %>
                                </span>
                            </td>
                            <td>
                                <a href="tel:<%= rs.getString("phone") %>" class="text-decoration-none">
                                    <i class="fas fa-phone me-1"></i><%= rs.getString("phone") %>
                                </a>
                            </td>
                            <td>
                                <i class="fas fa-map-marker-alt me-1"></i><%= rs.getString("city") %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="ViewFacultyDetails?id=<%= rs.getInt("id") %>" 
                                       class="btn-sm-custom btn-view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="EditFaculty.jsp?id=<%= rs.getInt("id") %>" 
                                       class="btn-sm-custom btn-edit" title="Edit Faculty">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button onclick="confirmDelete('<%= rs.getInt("id") %>', '<%= rs.getString("name") %>')" 
                                            class="btn-sm-custom btn-delete" title="Delete Faculty">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                                
                                // Count unique subjects
                                ResultSet countRs = stmt.executeQuery("SELECT COUNT(DISTINCT subject) as subject_count FROM faculty");
                                if (countRs.next()) {
                                    courseCount = countRs.getInt("subject_count");
                                }
                                
                                rs.close();
                                countRs.close();
                                stmt.close();
                                con.close();
                            } catch (Exception e) {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-danger">
                                <i class="fas fa-exclamation-triangle"></i>
                                Error loading faculty data: <%= e.getMessage() %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <% if (!hasData) { %>
                    <div class="empty-state">
                        <div class="icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <h3>No Faculty Found</h3>
                        <p>There are no faculty members in the system yet.</p>
                        <a href="AddFaculty.jsp" class="btn-custom btn-add mt-3">
                            <i class="fas fa-plus"></i> Add First Faculty
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle"></i> Confirm Delete
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <i class="fas fa-user-times text-danger mb-3" style="font-size: 3rem;"></i>
                        <p class="fs-5">Are you sure you want to delete faculty:</p>
                        <p class="fw-bold text-primary fs-4" id="facultyNameToDelete"></p>
                        <p class="text-muted">This action cannot be undone and will permanently remove all faculty data.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Faculty
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        // Set faculty and course counts
        var facultyCount = <%= facultyCount %>;
        var courseCount = <%= courseCount %>;
        
        // Remove loading overlay when page loads
        window.addEventListener('load', function() {
            document.getElementById('loadingOverlay').classList.remove('show');
            updateCurrentTime();
            animateStats();
        });

        // Update current time
        function updateCurrentTime() {
            var now = new Date();
            var timeString = now.toLocaleTimeString();
            document.getElementById('currentTime').textContent = timeString;
        }

        // Update time every second
        setInterval(updateCurrentTime, 1000);

        // Animate statistics
        function animateStats() {
            animateNumber('totalFaculty', facultyCount);
            animateNumber('totalStudents', 150); // This should come from actual student count
            animateNumber('totalCourses', courseCount);
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
            }, 20);
        }

        // Initialize DataTables
        $(document).ready(function() {
            if ($('#facultyTable').length > 0 && $('#facultyTable tbody tr').length > 0) {
                var table = $('#facultyTable').DataTable({
                    responsive: true,
                    pageLength: 10,
                    lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
                    order: [[0, 'asc']],
                    language: {
                        search: "",
                        searchPlaceholder: "Search faculty...",
                        lengthMenu: "Show _MENU_ faculty per page",
                        info: "Showing _START_ to _END_ of _TOTAL_ faculty",
                        paginate: {
                            first: "First",
                            last: "Last",
                            next: "Next",
                            previous: "Previous"
                        }
                    },
                    columnDefs: [
                        { orderable: false, targets: -1 } // Disable sorting on Actions column
                    ]
                });

                // Global search functionality
                $('#globalSearch').on('keyup', function() {
                    table.search(this.value).draw();
                });
            }
        });

        // Delete confirmation
        function confirmDelete(facultyId, facultyName) {
            document.getElementById('facultyNameToDelete').textContent = facultyName;
            document.getElementById('confirmDeleteBtn').href = 'DeleteFaculty?id=' + facultyId;
            
            var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        // Refresh data
        function refreshData() {
            document.getElementById('loadingOverlay').classList.add('show');
            window.location.reload();
        }

        // Export data
        function exportData() {
            var table = document.getElementById('facultyTable');
            if (!table || table.querySelectorAll('tbody tr').length == 0) {
                showNotification('No data to export!', 'warning');
                return;
            }

            var csv = 'ID,Name,Email,Subject,Phone,City\n';
            
            var rows = table.querySelectorAll('tbody tr');
            for (var i = 0; i < rows.length; i++) {
                var cells = rows[i].querySelectorAll('td');
                if (cells.length >= 6) {
                    var rowData = [
                        cells[0].textContent.trim().replace('#', ''),
                        cells[1].textContent.trim(),
                        cells[2].textContent.trim(),
                        cells[3].textContent.trim(),
                        cells[4].textContent.trim(),
                        cells[5].textContent.trim()
                    ];
                    csv += rowData.map(function(field) { 
                        return '"' + field + '"'; 
                    }).join(',') + '\n';
                }
            }

            var blob = new Blob([csv], { type: 'text/csv' });
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = 'faculty_' + new Date().toISOString().split('T')[0] + '.csv';
            a.click();
            window.URL.revokeObjectURL(url);

            showNotification('Faculty data exported successfully!', 'success');
        }

        // Notification system
        function showNotification(message, type) {
            var iconClass = 'info-circle';
            if (type == 'success') {
                iconClass = 'check-circle';
            } else if (type == 'warning') {
                iconClass = 'exclamation-triangle';
            } else if (type == 'danger' || type == 'error') {
                iconClass = 'exclamation-circle';
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

        // Add loading overlay for navigation
        var links = document.querySelectorAll('a');
        for (var i = 0; i < links.length; i++) {
            links[i].addEventListener('click', function(e) {
                if (!this.hasAttribute('data-bs-toggle') && !this.hasAttribute('onclick') && 
                    this.getAttribute('href') != '#' && 
                    this.getAttribute('href') && !this.getAttribute('href').startsWith('mailto:') && 
                    !this.getAttribute('href').startsWith('tel:')) {
                    document.getElementById('loadingOverlay').classList.add('show');
                }
            });
        }

        // Handle URL parameters for notifications
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('deleted') == 'true') {
            showNotification('Faculty deleted successfully!', 'success');
        } else if (urlParams.get('added') == 'true') {
            showNotification('Faculty added successfully!', 'success');
        } else if (urlParams.get('updated') == 'true') {
            showNotification('Faculty updated successfully!', 'success');
        } else if (urlParams.get('error')) {
            showNotification('An error occurred. Please try again.', 'danger');
        } else if (urlParams.get('login') == 'success') {
            showNotification('Welcome to Faculty Dashboard!', 'success');
        }
    </script>
</body>
</html>