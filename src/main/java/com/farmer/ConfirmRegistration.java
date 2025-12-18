package com.farmer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/ConfirmRegistration")
public class ConfirmRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String mobile = request.getParameter("mobile");
        if (mobile == null || mobile.isBlank()) {
            request.setAttribute("errorMsg", "Mobile required.");
            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
            return;
        }

        String sql = "UPDATE farmer SET adminStatus = 1 WHERE mobile = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            con.setAutoCommit(false);
            ps.setString(1, mobile);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                con.commit();
                HttpSession session = request.getSession(false);
                if (session != null) session.invalidate();
                response.sendRedirect("success.jsp");
            } else {
                con.rollback();
                request.setAttribute("errorMsg", "Mobile not found.");
                request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
        }
    }
}
