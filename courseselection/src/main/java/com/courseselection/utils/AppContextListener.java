package com.courseselection.utils;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // We don't need to do anything when the app starts
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 1. Manually deregister the JDBC driver to prevent memory leaks
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistered JDBC driver: " + driver);
            } catch (SQLException e) {
                System.err.println("Error deregistering JDBC driver: " + e.getMessage());
            }
        }

        // 2. Safely shut down the rogue MySQL cleanup thread
        AbandonedConnectionCleanupThread.checkedShutdown();
        System.out.println("MySQL abandoned connection cleanup thread shut down.");
    }
}