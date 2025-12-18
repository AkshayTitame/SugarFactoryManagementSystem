package com.farmer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/DeleteRegistration")
public class DeleteRegistration extends HttpServlet {
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

        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
        System.out.println("Delete request received at: " + now);

        String sql = "DELETE FROM farmer WHERE mobile = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            con.setAutoCommit(false);
            ps.setString(1, mobile);
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                con.commit();
                HttpSession session = request.getSession(false);
                if (session != null) session.invalidate();
                response.sendRedirect("index.jsp");
            } else {
                con.rollback();
                request.setAttribute("errorMsg", "No record found.");
                request.getRequestDispatcher("registrationConfirm.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
        }
    }
}
