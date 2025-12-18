package com.getofficer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/GatOfficerLogin")
public class GatOfficerLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mobile = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "SELECT gatOfficerID, status FROM gatofficer WHERE mobile = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, mobile);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int officerID = rs.getInt("gatOfficerID");
                    int status = rs.getInt("status");

                    if (status == 1) {
                        HttpSession session = request.getSession();
                        session.setAttribute("officerObject", officerID);
                        request.getRequestDispatcher("/gatOfficerDashboard.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("unregisteredUser.html");
                    }
                } else {
                    request.setAttribute("errorMsg", "Invalid mobile or password.");
                    request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
