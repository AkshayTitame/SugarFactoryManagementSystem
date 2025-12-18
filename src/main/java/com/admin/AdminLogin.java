package com.admin;  // In Above code is Well Modify so Check the Code Read the Code Perfectly

import com.connection.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;    
import java.sql.ResultSet;
import java.sql.SQLException;

//@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    

    // ✅ SQL query for checking admin login
    private static final String LOGIN_QUERY =
            "SELECT * FROM admin WHERE username = ? AND password = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("uname");
        String password = request.getParameter("psw");

        // ✅ Basic validation
        if (username == null || username.isBlank() ||
            password == null || password.isBlank()) {
            response.sendRedirect("invalid.html");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(LOGIN_QUERY)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // ✅ Login success → create session
                    HttpSession session = request.getSession(true);
                    session.setAttribute("Admin", username);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // ❌ Invalid credentials
                    response.sendRedirect("invalid.html");
                }
            }

        } catch (SQLException e) {
            log("Database error during admin login", e);
            response.sendRedirect("invalid.html");
        }
    }
}
