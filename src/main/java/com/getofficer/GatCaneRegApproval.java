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

//@WebServlet("/GatCaneRegApproval")
public class GatCaneRegApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] registrationNos = request.getParameterValues("registrationNo");
        if (registrationNos == null || registrationNos.length == 0) {
            response.sendRedirect("errorRegistration.html");
            return;
        }

        String sql = "UPDATE caneregistration SET gatOfficerStatus = 1 WHERE registrationNo = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (String regNo : registrationNos) {
                ps.setInt(1, Integer.parseInt(regNo));
                ps.addBatch();
            }

            ps.executeBatch();
            response.sendRedirect("gatSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
