package com.admin;

import com.connection.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

//@WebServlet("/FarmerApproval")
public class FarmerApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(FarmerApproval.class.getName());

    // ✅ Parameterized query for updating farmer status
    private static final String UPDATE_QUERY = 
            "UPDATE farmer SET adminStatus = 1 WHERE farmerID = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] farmerIds = request.getParameterValues("farmerID");

        // ✅ Handle null or empty selection
        if (farmerIds == null || farmerIds.length == 0) {
            response.sendRedirect("adminError.jsp");
            return;
        }

        int updatedCount = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_QUERY)) {

            con.setAutoCommit(false); // start transaction

            // ✅ Add all updates to batch
            for (String id : farmerIds) {
                ps.setString(1, id);
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            con.commit();

            // ✅ Count successful updates
            for (int result : results) {
                if (result > 0) updatedCount++;
            }

            if (updatedCount > 0) {
                response.sendRedirect("adminSucess.jsp");
            } else {
                response.sendRedirect("adminError.jsp");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error approving farmers", e);
            response.sendRedirect("adminError.jsp");
        }
    }
}
