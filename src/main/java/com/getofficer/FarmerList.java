package com.getofficer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.farmer.Farmer;
import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/FarmerList")
public class FarmerList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int areaID = Integer.parseInt(request.getParameter("area"));
        String sql = "SELECT * FROM farmer WHERE areaID = ?";

        List<Farmer> farmerList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, areaID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Farmer f = new Farmer();
                    f.setFarmerID(rs.getInt("farmerID"));
                    f.setFarmerName(rs.getString("farmerName"));
                    f.setMobile(rs.getString("mobile"));
                    f.setAddress(rs.getString("address"));
                    f.setAdharNo(rs.getString("adharNo"));
                    f.setAreaID(rs.getInt("areaID"));
                    f.setPassword(rs.getString("password"));
                    farmerList.add(f);
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("farmerList", farmerList);
            request.getRequestDispatcher("/farmerList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorRegistration.html");
        }
    }
}
