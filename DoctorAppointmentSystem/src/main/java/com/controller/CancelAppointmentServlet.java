package com.controller;

import com.dao.AppointmentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cancelAppointment")
public class CancelAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(request.getParameter("id"));
        AppointmentDAO dao = new AppointmentDAO();

        try {
            boolean cancelled = dao.cancelAppointment(appointmentId);
            if (cancelled) {
                request.setAttribute("status", "✅ Appointment cancelled successfully!");
            } else {
                request.setAttribute("status", "❌ Unable to cancel appointment.");
            }
            request.getRequestDispatcher("myAppointments.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "⚠️ Error: " + e.getMessage());
            request.getRequestDispatcher("myAppointments.jsp").forward(request, response);
        }
    }
}
