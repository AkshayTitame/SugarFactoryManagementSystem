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


//@WebServlet("/ApproveGatOfficer")
public class ApproveGatOfficer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Use parameterized query
    private static final String UPDATE_QUERY =
            "UPDATE gatofficer SET status = 1 WHERE gatofficerID = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] officerIds = request.getParameterValues("gatofficerID");

        // ✅ Handle null or empty selection
        if (officerIds == null || officerIds.length == 0) {
            response.sendRedirect("adminError.jsp");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_QUERY)) {

            // ✅ Batch update for efficiency
            for (String id : officerIds) {
                ps.setString(1, id);
                ps.addBatch();
            }

            int[] results = ps.executeBatch();

            // ✅ Count successful updates
            int successCount = 0;
            for (int result : results) {
                if (result > 0) successCount++;
            }

            if (successCount > 0) {
                response.sendRedirect("adminSucess.jsp");
            } else {
                response.sendRedirect("adminError.jsp");
            }

        } catch (SQLException e) {
            log("Database error while approving Gat Officers", e);
            response.sendRedirect("adminError.jsp");
        }
    }
}
