package com.farmer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.connection.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/FarmerLogin")
public class FarmerLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, String> resp = new HashMap<>();

        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");

        if (mobile == null || mobile.isBlank() || password == null || password.isBlank()) {
            resp.put("status", "error");
            resp.put("message", "Mobile and password are required.");
            out.print(new Gson().toJson(resp));
            return;
        }

        String sql = "SELECT farmerID, status FROM farmer WHERE mobile = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, mobile);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int farmerID = rs.getInt("farmerID");
                    int status = rs.getInt("status");

                    if (status == 1) {
                        HttpSession session = request.getSession();
                        session.setAttribute("farmer", farmerID);

                        resp.put("status", "success");
                        resp.put("message", "Login successful!");
                    } else {
                        resp.put("status", "error");
                        resp.put("message", "Your account is not approved yet.");
                    }
                } else {
                    resp.put("status", "error");
                    resp.put("message", "Invalid mobile or password.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.put("status", "error");
            resp.put("message", "Invalid User Name or Password ");
        }

        out.print(new Gson().toJson(resp));
    }
}
