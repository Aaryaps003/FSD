package com.courseselection.dao;

import com.courseselection.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    
    // This is the method Eclipse is looking for!
    public int loginUser(String email, String password) {
    	String sql = "SELECT user_id FROM Students WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, password); 
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id"); // Login successful
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Login failed
    }
}