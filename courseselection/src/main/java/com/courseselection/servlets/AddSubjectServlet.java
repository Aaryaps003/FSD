package com.courseselection.servlets;

import com.courseselection.dao.CourseDAO;
import com.courseselection.model.Course;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add-subject")
public class AddSubjectServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Gather data from the HTML form
        Course newCourse = new Course();
        newCourse.courseCode = request.getParameter("courseCode");
        newCourse.courseName = request.getParameter("courseName");
        newCourse.instructor = request.getParameter("instructor");
        
        try {
            newCourse.availableSeats = Integer.parseInt(request.getParameter("availableSeats"));
        } catch (NumberFormatException e) {
            response.sendRedirect("add-subject.jsp?err=InvalidSeatNumber");
            return;
        }
        
        // 2. Save to database
        CourseDAO courseDao = new CourseDAO();
        boolean success = courseDao.addCourse(newCourse);
        
        // 3. Redirect back to admin dashboard with a success or error message
        if (success) {
            response.sendRedirect("admin.jsp?msg=SubjectAdded");
        } else {
            response.sendRedirect("add-subject.jsp?err=DatabaseError");
        }
    }
}