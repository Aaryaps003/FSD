<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.courseselection.dao.CourseDAO" %>
<%@ page import="com.courseselection.model.Course" %>
<%@ page import="java.util.List" %>
<%
    // 1. Session Check: Protect the page from unlogged users
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Courses</title>
</head>
<body style="font-family: Arial; padding: 20px;">
    <h2>Course Selection Dashboard</h2>
    <hr>
    
    <% 
        // 2. Display success or error messages
        String msg = request.getParameter("msg");
        String err = request.getParameter("err");
        if ("enrolled".equals(msg)) out.print("<h4 style='color:green;'>Successfully Enrolled!</h4>");
        if (err != null) out.print("<h4 style='color:red;'>" + err + "</h4>");
    %>

    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>Course Code</th>
            <th>Course Name</th>
            <th>Instructor</th>
            <th>Available Seats</th>
            <th>Action</th>
        </tr>
        <%
            // 3. Fetch courses and generate table rows
            CourseDAO courseDao = new CourseDAO();
            List<Course> courses = courseDao.getAllCourses();
            
            for(Course c : courses) {
        %>
        <tr>
            <td><%= c.courseCode %></td>
            <td><%= c.courseName %></td>
            <td><%= c.instructor %></td>
            <td><%= c.availableSeats %></td>
            <td>
                <% if (c.availableSeats > 0) { %>
                    <form action="register" method="POST" style="margin:0;">
                        <input type="hidden" name="courseId" value="<%= c.courseId %>">
                        <button type="submit">Enroll</button>
                    </form>
                <% } else { %>
                    <span style="color:red;">Full</span>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>