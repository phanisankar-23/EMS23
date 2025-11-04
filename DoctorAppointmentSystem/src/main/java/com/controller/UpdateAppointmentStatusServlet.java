package com.controller;

import com.dao.AppointmentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateAppointmentStatus")
public class UpdateAppointmentStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Only admin can update
        HttpSession session = request.getSession(false);
        String email = session != null ? (String) session.getAttribute("email") : null;
        if (email == null || !"admin@cg.com".equals(email)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String status = request.getParameter("status");

        if (idParam != null && !idParam.isEmpty() && status != null && !status.isEmpty()) {
            try {
                int appointmentId = Integer.parseInt(idParam);
                AppointmentDAO dao = new AppointmentDAO();
                boolean updated = dao.updateAppointmentStatus(appointmentId, status);
                if (updated) {
                    response.sendRedirect("viewAppointments.jsp?status=Appointment+updated+successfully");
                } else {
                    response.sendRedirect("viewAppointments.jsp?status=Failed+to+update+appointment");
                }
            } catch (NumberFormatException | ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("viewAppointments.jsp?status=Error+updating+appointment");
            }
        } else {
            response.sendRedirect("viewAppointments.jsp?status=Invalid+appointment+data");
        }
    }

    // Optional: redirect GET to admin page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("viewAppointments.jsp");
    }
}
