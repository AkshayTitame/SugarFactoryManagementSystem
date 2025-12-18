package com.admin;   // the entire code is more improved and add the SMS to the Farmer so Read the Code Proper and Modify

import com.connection.DBConnection;
import com.sms.SendSMS;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;
import java.util.logging.Level;
import java.util.logging.Logger;

//@WebServlet("/CaneWeightRegistration")
public class CaneWeightRegistration extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CaneWeightRegistration.class.getName());

    // ✅ Thread pool for sending SMS concurrently
    private static final ExecutorService SMS_EXECUTOR = Executors.newFixedThreadPool(10);

    // ✅ Retry settings
    private static final int MAX_SMS_RETRIES = 3;
    private static final long RETRY_DELAY_MS = 2000;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] registrationNos = request.getParameterValues("registrationNo");
        String[] weights = request.getParameterValues("caneweight");
        String areaParam = request.getParameter("areaID");

        int areaID;

        try {
            areaID = Integer.parseInt(areaParam);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid areaID: " + areaParam, e);
            response.sendRedirect("errorRegistration.html");
            return;
        }

        if (registrationNos == null || weights == null || registrationNos.length != weights.length) {
            LOGGER.warning("Mismatch in registration numbers and weights");
            response.sendRedirect("errorRegistration.html");
            return;
        }

        String fetchQuery = "SELECT c.registrationNo, f.farmerName, f.mobile " +
                "FROM caneregistration c JOIN farmer f ON c.farmerID = f.farmerID " +
                "WHERE c.registrationNo = ?";

        String updateQuery = "UPDATE caneregistration SET weight = ? WHERE registrationNo = ?";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement fetchStmt = con.prepareStatement(fetchQuery);
                 PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {

                List<String[]> smsList = new ArrayList<>();

                for (int i = 0; i < registrationNos.length; i++) {
                    int regID;
                    float weight;
                    try {
                        regID = Integer.parseInt(registrationNos[i]);
                        weight = Float.parseFloat(weights[i]);
                    } catch (NumberFormatException e) {
                        LOGGER.log(Level.WARNING, "Invalid registrationNo or weight at index " + i, e);
                        continue;
                    }

                    // Fetch farmer info
                    fetchStmt.setInt(1, regID);
                    try (ResultSet rs = fetchStmt.executeQuery()) {
                        if (rs.next()) {
                            String mobile = rs.getString("mobile");
                            String msg = "Dear " + rs.getString("farmerName") +
                                    ", your cane weight is " + weight + " Tone for registration No: " +
                                    rs.getString("registrationNo");
                            smsList.add(new String[]{mobile, msg});
                        }
                    }

                    // Prepare weight update
                    updateStmt.setFloat(1, weight);
                    updateStmt.setInt(2, regID);
                    updateStmt.addBatch();
                }

                // Execute all updates
                int[] results = updateStmt.executeBatch();
                con.commit();

                // ✅ Send SMS concurrently with retry
                SendSMS smsSender = new SendSMS();
                for (String[] sms : smsList) {
                    SMS_EXECUTOR.submit(() -> sendSMSWithRetry(smsSender, sms[0], sms[1]));
                }

                // Set session and forward
                HttpSession session = request.getSession();
                session.setAttribute("farmerList", areaID);
                request.getRequestDispatcher("/adminUploadWeight.jsp").forward(request, response);

            } catch (SQLException e) {
                con.rollback();
                LOGGER.log(Level.SEVERE, "Error updating weights", e);
                response.sendRedirect("errorRegistration.html");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
            response.sendRedirect("errorRegistration.html");
        }
    }

    /**
     * Sends SMS with retry mechanism
     */
    private void sendSMSWithRetry(SendSMS smsSender, String mobile, String message) {
        int attempts = 0;
        boolean success = false;

        while (!success && attempts < MAX_SMS_RETRIES) {
            try {
                smsSender.sendSms(mobile, message);
                success = true;
            } catch (Exception e) {
                attempts++;
                LOGGER.log(Level.WARNING, "Failed to send SMS to " + mobile + " attempt " + attempts, e);
                try {
                    Thread.sleep(RETRY_DELAY_MS);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        if (!success) {
            LOGGER.severe("Failed to send SMS to " + mobile + " after " + MAX_SMS_RETRIES + " attempts.");
        }
    }

    @Override
    public void destroy() {
        SMS_EXECUTOR.shutdown();
        try {
            if (!SMS_EXECUTOR.awaitTermination(5, TimeUnit.SECONDS)) {
                SMS_EXECUTOR.shutdownNow();
            }
        } catch (InterruptedException e) {
            SMS_EXECUTOR.shutdownNow();
        }
        super.destroy();
    }
}
