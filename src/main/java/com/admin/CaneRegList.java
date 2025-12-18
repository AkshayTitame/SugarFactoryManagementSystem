package com.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

//@WebServlet("/CaneWeightRegistration")
public class CaneRegList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CaneRegList.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String areaParam = request.getParameter("areaID");
        int areaID;

        // ✅ Validate and parse areaID
        try {
            areaID = Integer.parseInt(areaParam);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid areaID: " + areaParam, e);
            response.sendRedirect("errorRegistration.html"); // or show proper error page
            return;
        }

        // ✅ Log the areaID for debugging
        LOGGER.info("Selected AREA ID: " + areaID);

        // ✅ Set the areaID in session (as Integer, not String)
        HttpSession session = request.getSession();
        session.setAttribute("farmerList", areaID);

        // ✅ Forward to the upload weight page
        request.getRequestDispatcher("/adminUploadWeight.jsp").forward(request, response);
    }
}
