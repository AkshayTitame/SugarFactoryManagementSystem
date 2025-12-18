package com.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.connection.DBConnection;

@WebServlet("/AddCaneType")
public class AddCaneType extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String FETCH_QUERY = "SELECT caneTypeId, caneTypeName FROM canetype";
    private static final String INSERT_QUERY = "INSERT INTO canetype (caneTypeName) VALUES (?)";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("areaName");
        if (name == null || name.isBlank()) {
            response.sendRedirect("errorRegistration.html");
            return;
        }

        List<Cane> caneList = new ArrayList<>();

        // ✅ Step 1: Fetch existing cane types
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(FETCH_QUERY);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cane cane = new Cane();
                cane.setCaneID(rs.getInt("caneTypeId"));
                cane.setCaneName(rs.getString("caneTypeName"));
                caneList.add(cane);
            }

        } catch (SQLException e) {
            log("Error fetching cane types", e);
            response.sendRedirect("errorRegistration.html");
            return;
        }

        // ✅ Step 2: Insert new cane type
        try (Connection con =  DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_QUERY)) {

            con.setAutoCommit(false);

            ps.setString(1, name);
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                con.commit();

                HttpSession session = request.getSession();
                session.setAttribute("studentObject", name);

                request.getRequestDispatcher("/adminSucess.jsp").forward(request, response);
            } else {
                con.rollback();
                response.sendRedirect("errorRegistration.html");
            }

        } catch (SQLException e) {
            log("Error inserting cane type", e);
            response.sendRedirect("errorRegistration.html");
        }
    }
}
