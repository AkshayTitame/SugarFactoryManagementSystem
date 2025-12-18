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
import jakarta.servlet.http.HttpSession;

//@WebServlet("/GatOfficerRegistration")
public class GatOfficerRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("gatOfficerName");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        int empID = Integer.parseInt(request.getParameter("empID"));
        int areaID = Integer.parseInt(request.getParameter("areaID"));

        GatOfficer officer = new GatOfficer();
        officer.setGatOfficerName(name);
        officer.setMobile(mobile);
        officer.setPassword(password);
        officer.setEmpID(empID);
        officer.setAreaID(areaID);

        String sql = "INSERT INTO gatofficer (empID, areaID, gatOfficerName, mobile, password) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, empID);
            ps.setInt(2, areaID);
            ps.setString(3, name);
            ps.setString(4, mobile);
            ps.setString(5, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("officerObject", officer);
                request.getRequestDispatcher("/success.jsp").forward(request, response);
            } else {
                response.sendRedirect("errorRegistration.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
