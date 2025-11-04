package com.controller;

import com.dao.AppointmentDAO;
import com.dao.DoctorDAO;
import com.model.Appointment;
import com.model.Doctor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        LocalDate appointmentDate = LocalDate.parse(request.getParameter("appointmentDate"));
        String status = "Pending";

        try {
            // Get doctor details
            DoctorDAO doctorDAO = new DoctorDAO();
            Doctor doctor = doctorDAO.getDoctorById(doctorId);

            // Check if doctor is available on selected date
            if (!isDoctorAvailable(doctor, appointmentDate)) {
                request.setAttribute("status", "⚠️ Doctor is not available on " + appointmentDate + ". Please choose another date.");
                request.getRequestDispatcher("viewDoctors.jsp").forward(request, response);
                return;
            }

            // Book appointment
            Appointment appointment = new Appointment();
            appointment.setUserId(userId);
            appointment.setDoctorId(doctorId);
            appointment.setAppointmentDate(appointmentDate);
            appointment.setStatus(status);

            AppointmentDAO appointmentDAO = new AppointmentDAO();
            boolean success = appointmentDAO.bookAppointment(appointment);

            if (success) {
                request.setAttribute("status", "✅ Appointment booked successfully for " + appointmentDate + "!");
            } else {
                request.setAttribute("status", "❌ Failed to book appointment!");
            }

            request.getRequestDispatcher("myAppointments.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "⚠️ Error: " + e.getMessage());
            request.getRequestDispatcher("viewDoctors.jsp").forward(request, response);
        }
    }

    // Check if doctor is available based on availability string, e.g., "Mon-Fri 10AM-4PM"
    private boolean isDoctorAvailable(Doctor doctor, LocalDate date) {
        if (doctor == null || doctor.getAvailability() == null) return false;

        String availability = doctor.getAvailability(); // e.g., "Mon-Fri 10AM-4PM"
        String[] parts = availability.split(" ");   // Split into ["Mon-Fri", "10AM-4PM"]
        String daysPart = parts[0];

        DayOfWeek day = date.getDayOfWeek();

        switch (daysPart) {
            case "Mon-Fri": return day != DayOfWeek.SATURDAY && day != DayOfWeek.SUNDAY;
            case "Mon-Sat": return day != DayOfWeek.SUNDAY;
            case "Sat-Sun": return day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY;
            case "Mon": return day == DayOfWeek.MONDAY;
            case "Tue": return day == DayOfWeek.TUESDAY;
            case "Wed": return day == DayOfWeek.WEDNESDAY;
            case "Thu": return day == DayOfWeek.THURSDAY;
            case "Fri": return day == DayOfWeek.FRIDAY;
            case "Sat": return day == DayOfWeek.SATURDAY;
            case "Sun": return day == DayOfWeek.SUNDAY;
            default: return false;
        }
    }
}
