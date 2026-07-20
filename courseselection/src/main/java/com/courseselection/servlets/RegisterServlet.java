package com.courseselection.servlets;

import com.courseselection.dao.CourseDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.html");
            return;
        }

        int studentId = (int) session.getAttribute("loggedInUser");
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        CourseDAO courseDao = new CourseDAO();
        String result = courseDao.registerForCourse(studentId, courseId);

        if (result.equals("Success")) {
            response.sendRedirect("courses.jsp?msg=enrolled");
        } else {
            response.sendRedirect("courses.jsp?err=" + java.net.URLEncoder.encode(result, "UTF-8"));
        }
    }
}