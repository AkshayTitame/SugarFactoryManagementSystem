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

@WebServlet("/CaneRegistration")
public class CaneRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isEmpty(String val) {
        return val == null || val.trim().isEmpty();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String fatherFirstName = request.getParameter("fatherFirstName");
        String fatherMiddleName = request.getParameter("fatherMiddleName");
        String fatherLastName = request.getParameter("fatherLastName");
        String mobile = request.getParameter("mobile");
        String aadhaarNo = request.getParameter("aadhaarNo");
        String address = request.getParameter("address");
        String uttraNo = request.getParameter("uttraNo");
        String areaStr = request.getParameter("area");
        String soilType = request.getParameter("soilType");
        String caneTypeID = request.getParameter("caneTypeID");
        String regdate = request.getParameter("regdate");
        String expectedHarvest = request.getParameter("expectedHarvest");
        String irrigationType = request.getParameter("irrigationType");
        String gatName = request.getParameter("gatName");
        String village = request.getParameter("village");

        String message = ""; // to store success or duplicate message
        boolean success = false;

        if(isEmpty(firstName) || isEmpty(lastName) || isEmpty(fatherFirstName) || isEmpty(mobile) ||
           isEmpty(address) || isEmpty(uttraNo) || isEmpty(areaStr) || isEmpty(caneTypeID) ||
           isEmpty(regdate) || isEmpty(gatName) || isEmpty(village)) {
            message = "Something is missing! Please fill all required fields.";
        } else {
            try (Connection con = DBConnection.getConnection()) {
                // Check for duplicate uttraNo
                String checkSql = "SELECT COUNT(*) FROM sugarcane_farm_registration WHERE uttra_no = ?";
                PreparedStatement checkPs = con.prepareStatement(checkSql);
                checkPs.setString(1, uttraNo);
                ResultSet rs = checkPs.executeQuery();
                if(rs.next() && rs.getInt(1) > 0) {
                    message = "The Survey / Uttra No. is duplicate!";
                } else {
                    // Insert new record
                    String sql = "INSERT INTO sugarcane_farm_registration "
                               + "(first_name, middle_name, last_name, father_first_name, father_middle_name, father_last_name, "
                               + "mobile, aadhaar_no, address, uttra_no, area, soil_type_id, cane_type_id, reg_date, "
                               + "expected_harvest, irrigation_type_id, gat_office_id, village_id) "
                               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, firstName);
                    ps.setString(2, middleName != null ? middleName : "");
                    ps.setString(3, lastName);
                    ps.setString(4, fatherFirstName);
                    ps.setString(5, fatherMiddleName != null ? fatherMiddleName : "");
                    ps.setString(6, fatherLastName);
                    ps.setString(7, mobile);
                    ps.setString(8, aadhaarNo != null ? aadhaarNo : "");
                    ps.setString(9, address);
                    ps.setString(10, uttraNo);
                    ps.setDouble(11, Double.parseDouble(areaStr));
                    ps.setInt(12, isEmpty(soilType) ? 0 : Integer.parseInt(soilType));
                    ps.setInt(13, Integer.parseInt(caneTypeID));
                    ps.setString(14, regdate);
                    ps.setString(15, !isEmpty(expectedHarvest) ? expectedHarvest : null);
                    ps.setInt(16, !isEmpty(irrigationType) ? Integer.parseInt(irrigationType) : 0);
                    ps.setInt(17, Integer.parseInt(gatName));
                    ps.setInt(18, Integer.parseInt(village));

                    int rows = ps.executeUpdate();
                    if(rows > 0) {
                        success = true;
                        message = "Registration Successful!";
                    } else {
                        message = "Failed to register! Please try again.";
                    }
                }
            } catch(Exception e) {
                e.printStackTrace();
                message = "Something went wrong! Please try again.";
            }
        }

        // Send back form data and message
        request.setAttribute("success", success);
        request.setAttribute("message", message);
        request.setAttribute("firstName", firstName);
        request.setAttribute("middleName", middleName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("fatherFirstName", fatherFirstName);
        request.setAttribute("fatherMiddleName", fatherMiddleName);
        request.setAttribute("fatherLastName", fatherLastName);
        request.setAttribute("mobile", mobile);
        request.setAttribute("aadhaarNo", aadhaarNo);
        request.setAttribute("address", address);
        request.setAttribute("uttraNo", uttraNo);
        request.setAttribute("area", areaStr);
        request.setAttribute("soilType", soilType);
        request.setAttribute("caneTypeID", caneTypeID);
        request.setAttribute("regdate", regdate);
        request.setAttribute("expectedHarvest", expectedHarvest);
        request.setAttribute("irrigationType", irrigationType);
        request.setAttribute("gatName", gatName);
        request.setAttribute("village", village);

        request.getRequestDispatcher("caneRegistration.jsp").forward(request, response);
    }
}
