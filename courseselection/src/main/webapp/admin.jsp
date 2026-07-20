<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.courseselection.dao.CourseDAO" %>
<%@ page import="com.courseselection.model.Course" %>
<%@ page import="com.courseselection.model.EnrollmentDetails" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Administration Portal</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h3>Admin Portal</h3>
        </div>
        <ul class="nav-links">
            <li class="active"><a href="admin.jsp">Dashboard</a></li>
            <li><a href="add-subject.jsp">Manage Subjects</a></li>
            <!-- Link updated to point to your new enrollments page -->
            <li><a href="enrollments.jsp">Student Enrollments</a></li>
            <li><a href="#">Faculty List</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <header class="top-header">
            <h2>Welcome, Administrator</h2>
            <a href="login.html" class="logout-btn">Logout</a>
        </header>

        <div class="content-wrapper">
            
            <% 
                // Display success message if redirected from AddSubjectServlet
                String msg = request.getParameter("msg");
                if ("SubjectAdded".equals(msg)) {
                    out.print("<h4 style='color:var(--success-green); margin-bottom:15px;'>Successfully Added New Subject!</h4>");
                }
            %>

            <!-- Quick Stats -->
            <section class="dashboard-cards">
                <div class="card">
                    <h4>Total Students</h4>
                    <h2>1,245</h2>
                </div>
                <div class="card">
                    <h4>Active Subjects</h4>
                    <h2>42</h2>
                </div>
                <div class="card">
                    <h4>New Enrollments</h4>
                    <h2>128</h2>
                </div>
            </section>

            <!-- Dynamic Subjects Management Table -->
            <div class="section-header">
                <h3>Course Catalog</h3>
                <a href="add-subject.jsp" class="action-btn" style="text-decoration: none; display: inline-block;">+ Add New Subject</a>
            </div>
            
            <table class="data-table" style="margin-bottom: 40px;">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Subject Name</th>
                        <th>Instructor</th>
                        <th>Available Seats</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Fetch courses from the database dynamically
                        CourseDAO courseDao = new CourseDAO();
                        List<Course> courses = courseDao.getAllCourses();
                        
                        for(Course c : courses) {
                    %>
                    <tr>
                        <td><%= c.courseCode %></td>
                        <td><%= c.courseName %></td>
                        <td><%= c.instructor %></td>
                        <td>
                            <% if (c.availableSeats > 0) { %>
                                <%= c.availableSeats %>
                            <% } else { %>
                                <span style="color:var(--danger-red); font-weight:bold;">Full</span>
                            <% } %>
                        </td>
                        <td>
                            <button class="btn-small btn-edit">Edit</button>
                            <button class="btn-small btn-delete">Drop</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <!-- Dynamic Students List Table (Recent Snapshot for Dashboard) -->
            <div class="section-header">
                <h3>Recently Enrolled Students</h3>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Enrolled Subject</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Fetch the joined enrollment data
                        List<EnrollmentDetails> enrollments = courseDao.getRecentEnrollments();
                        
                        // If no one is enrolled yet, show a clean empty state message
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