<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.courseselection.dao.CourseDAO" %>
<%@ page import="com.courseselection.model.EnrollmentDetails" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Enrollments</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h3>Admin Portal</h3>
        </div>
        <ul class="nav-links">
            <li><a href="admin.jsp">Dashboard</a></li>
            <li><a href="add-subject.jsp">Manage Subjects</a></li>
            <li class="active"><a href="enrollments.jsp">Student Enrollments</a></li>
            <li><a href="#">Faculty List</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <header class="top-header">
            <h2>Enrollment Records</h2>
            <a href="login.html" class="logout-btn">Logout</a>
        </header>

        <div class="content-wrapper">
            
            <div class="section-header">
                <h3>All Enrolled Students</h3>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Email Address</th>
                        <th>Enrolled Subject</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Fetch the joined enrollment data from the database
                        CourseDAO courseDao = new CourseDAO();
                        List<EnrollmentDetails> enrollments = courseDao.getRecentEnrollments();
                        
                        if (enrollments.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 20px;">No students have enrolled yet.</td>
                        </tr>
                    <%
                        } else {
                            for(EnrollmentDetails ed : enrollments) {
                    %>
                    <tr>
                        <td>STU-<%= ed.studentId %></td>
                        <td><%= ed.studentName %></td>
                        <td><%= ed.email %></td>
                        <td><%= ed.courseName %></td>
                        <td><span style="color: var(--success-green); font-weight: bold;">Verified</span></td>
                    </tr>
                    <%      } 
                        } 
                    %>
                </tbody>
            </table>

        </div>
    </main>

</body>
</html>	