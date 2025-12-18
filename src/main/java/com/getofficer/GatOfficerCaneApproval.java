package com.getofficer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/GatOfficerCaneApproval")
public class GatOfficerCaneApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] regNumbers = request.getParameterValues("registrationNo");
        if (regNumbers == null || regNumbers.length == 0) {
            response.sendRedirect("errorRegistration.html");
            return;
        }

        String sql = "UPDATE caneregistration SET gatOfficerStatus = 1 WHERE registrationNo = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (String regNo : regNumbers) {
                ps.setInt(1, Integer.parseInt(regNo));
                ps.addBatch();
            }

            ps.executeBatch();
            response.sendRedirect("gatOfficerDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
