package com.courseselection.servlets;

import com.courseselection.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UserDAO userDao = new UserDAO();
        int userId = userDao.loginUser(email, password);
        
        if (userId != -1) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", userId);
            response.sendRedirect("courses.jsp"); 
        } else {
            response.sendRedirect("login.html?error=invalid");
        }
    }
}