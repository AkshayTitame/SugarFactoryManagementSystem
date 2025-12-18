package com.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.connection.DBConnection;

@WebServlet("/AdminCaneRegApproval")
public class AdminCaneRegApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPDATE_SQL =
            "UPDATE caneregistration SET adminStatus = 1 WHERE registrationNo = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] enrollNos = request.getParameterValues("registrationNo");

        // ✅ If no values selected
        if (enrollNos == null || enrollNos.length == 0) {
            response.sendRedirect("adminError.jsp");
            return;
        }

        int updatedCount = 0;

        try (Connection con = DBConnection.getConnection();   // 🔹 use your utility
             PreparedStatement ps = con.prepareStatement(UPDATE_SQL)) {

            con.setAutoCommit(false); // start transaction

            // 🔹 Add all updates to batch
            for (String enrollNo : enrollNos) {
                ps.setString(1, enrollNo);
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            con.commit();

            // 🔹 Count how many records updated
            for (int result : results) {
                if (result >= 0) {
                    updatedCount++;
                }
            }

            if (updatedCount > 0) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("adminError.jsp");
            }

        } catch (SQLException e) {
            log("Error updating cane registrations", e);
            response.sendRedirect("adminError.jsp");
        }
    }
}
