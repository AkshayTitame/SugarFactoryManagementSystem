package com.farmer;

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

@WebServlet("/FarmerRegisterServlet")
public class FarmerRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isEmpty(String val) {
        return val == null || val.trim().isEmpty();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all form data
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String mobile = request.getParameter("mobile");
        String aadhaar = request.getParameter("aadhaar");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String state = request.getParameter("state");
        String district = request.getParameter("district");
        String taluka = request.getParameter("taluka");
        String village = request.getParameter("village");
        String address = request.getParameter("address");

        String message = "";
        boolean success = false;

        // === Validation ===
        if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(mobile) || isEmpty(password)
                || isEmpty(confirmPassword) || isEmpty(state) || isEmpty(district)
                || isEmpty(taluka) || isEmpty(village) || isEmpty(address)) {
            message = "All required fields must be filled!";
        } else if (!password.equals(confirmPassword)) {
            message = "Password and Confirm Password do not match!";
        } else if (!mobile.matches("\\d{10}")) {
            message = "Invalid mobile number! It must be 10 digits.";
        } else if (aadhaar != null && !aadhaar.isEmpty() && !aadhaar.matches("\\d{12}")) {
            message = "Invalid Aadhaar number! It must be 12 digits.";
        } else {
            try (Connection con = DBConnection.getConnection()) {

                // === Check duplicate mobile ===
                String checkSql = "SELECT COUNT(*) FROM farmer WHERE mobile = ?";
                PreparedStatement checkPs = con.prepareStatement(checkSql);
                checkPs.setString(1, mobile);
                ResultSet rs = checkPs.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    message = "This mobile number is already registered!";
                } else {
                    // === Insert data ===
                    String sql = "INSERT INTO farmer "
                            + "(first_name, middle_name, last_name, mobile, aadhaar_no, password, "
                            + "state, district, taluka, village, address) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, firstName);
                    ps.setString(2, middleName);
                    ps.setString(3, lastName);
                    ps.setString(4, mobile);
                    ps.setString(5, aadhaar);
                    ps.setString(6, password);
                    ps.setString(7, state);
                    ps.setString(8, district);
                    ps.setString(9, taluka);
                    ps.setString(10, village);
                    ps.setString(11, address);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        success = true;
                        message = "Registration successful!";
                    } else {
                        message = "Failed to register! Please try again.";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "Something went wrong! Please try again later.";
            }
        }

        // Send back results
        request.setAttribute("success", success);
        request.setAttribute("message", message);

        // Return form data (optional)
        request.setAttribute("firstName", firstName);
        request.setAttribute("middleName", middleName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("mobile", mobile);
        request.setAttribute("aadhaar", aadhaar);
        request.setAttribute("state", state);
        request.setAttribute("district", district);
        request.setAttribute("taluka", taluka);
        request.setAttribute("village", village);
        request.setAttribute("address", address);

        // Forward back to JSP
        request.getRequestDispatcher("farmerRegistration.jsp").forward(request, response);
    }
}
