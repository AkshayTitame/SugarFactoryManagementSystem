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

//@WebServlet("/GatOfficerApproval")
public class GatOfficerApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] farmerIDs = request.getParameterValues("farmerID");
        if (farmerIDs == null || farmerIDs.length == 0) {
            response.sendRedirect("errorRegistration.html");
            return;
        }

        String sql = "UPDATE farmer SET gatOfficerStatus = 1 WHERE farmerID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (String id : farmerIDs) {
                ps.setInt(1, Integer.parseInt(id));
                ps.addBatch();
            }

            ps.executeBatch();
            response.sendRedirect("gatSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminError.jsp");
        }
    }
}
