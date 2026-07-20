package com.courseselection.dao;

import com.courseselection.model.Course;
import com.courseselection.model.EnrollmentDetails;
import com.courseselection.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    // 1. Fetches all available courses for the dashboards (Admin & Student)
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM Courses";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Course c = new Course();
                c.courseId = rs.getInt("course_id");
                c.courseCode = rs.getString("course_code");
                c.courseName = rs.getString("course_name");
                c.instructor = rs.getString("instructor");
                c.availableSeats = rs.getInt("available_seats");
                courses.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    // 2. Adds a new course to the database (Used by Admin)
    public boolean addCourse(Course course) {
        String sql = "INSERT INTO Courses (course_code, course_name, instructor, available_seats) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, course.courseCode);
            pstmt.setString(2, course.courseName);
            pstmt.setString(3, course.instructor);
            pstmt.setInt(4, course.availableSeats);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Returns true if the insert was successful
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. Handles the complex transaction of enrolling a student (Used by Student)
    public String registerForCourse(int studentId, int courseId) {
        String checkSeatsSql = "SELECT available_seats FROM Courses WHERE course_id = ? FOR UPDATE";
        String enrollSql = "INSERT INTO Enrollments (user_id, course_id) VALUES (?, ?)";
        String updateSeatsSql = "UPDATE Courses SET available_seats = available_seats - 1 WHERE course_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // Check seats
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSeatsSql)) {
                checkStmt.setInt(1, courseId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("available_seats") <= 0) {
                        conn.rollback();
                        return "Course is full.";
                    }
                }
            }

            // Enroll Student
            try (PreparedStatement enrollStmt = conn.prepareStatement(enrollSql)) {
                enrollStmt.setInt(1, studentId);
                enrollStmt.setInt(2, courseId);
                enrollStmt.executeUpdate();
            } catch (SQLException e) {
                conn.rollback();
                return "You are already enrolled in this course.";
            }

            // Update seat count
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSeatsSql)) {
                updateStmt.setInt(1, courseId);
                updateStmt.executeUpdate();
            }

            conn.commit(); // Commit Transaction
            return "Success";

        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { }
            e.printStackTrace();
            return "A database error occurred.";
        } finally {
            if (conn != null) try { 
                conn.setAutoCommit(true); 
                conn.close(); 
            } catch (SQLException e) { }
        }
    }
    
    // 4. Fetches the list of all student enrollments (Used by Admin)
    public List<EnrollmentDetails> getRecentEnrollments() {
        List<EnrollmentDetails> list = new ArrayList<>();
        
        // This SQL query joins the three tables together
        String sql = "SELECT s.user_id, s.full_name, s.email, c.course_name " +
                     "FROM Students s " +
                     "JOIN Enrollments e ON s.user_id = e.user_id " +
                     "JOIN Courses c ON e.course_id = c.course_id " +
                     "ORDER BY e.enrollment_date DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                EnrollmentDetails ed = new EnrollmentDetails();
                ed.studentId = rs.getInt("user_id");
                ed.studentName = rs.getString("full_name");
                ed.email = rs.getString("email");
                ed.courseName = rs.getString("course_name");
                list.add(ed);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}