package com.courseselection.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Update the password to match your MySQL root password
    private static final String URL = "jdbc:mysql://localhost:3306/fsd";
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; 

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }
}