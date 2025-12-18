package com.admin;

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

@WebServlet("/AddArea")
public class AddArea extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String name = request.getParameter("areaName");

        // Basic validation
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("errorRegistration.html");
            return;
        }

        String insertSQL = "INSERT INTO area(areaName) VALUES(?)";

        try (Connection con = DBConnection.getConnection();  // Use a proper connection method
             PreparedStatement ps = con.prepareStatement(insertSQL)) {

            con.setAutoCommit(false);  // Start transaction

            ps.setString(1, name);
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                con.commit();
                HttpSession session = request.getSession();
                session.setAttribute("studentObject", name);
                request.getRequestDispatcher("/adminSucess.jsp").forward(request, response);
            } else {
                con.rollback();
                response.sendRedirect("errorRegistration.html");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
