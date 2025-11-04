package com.dao;

import com.connection.ConnectionManager;
import com.model.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO2 {

    // ✅ Book a new appointment
    public boolean bookAppointment(Appointment appointment) throws ClassNotFoundException, SQLException {
        String query = "INSERT INTO appointments (user_id, doctor_id, appointment_date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, appointment.getUserId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setDate(3, Date.valueOf(appointment.getAppointmentDate()));
            ps.setString(4, appointment.getStatus()); // default 'Pending'
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Get appointments by user (for user dashboard)
    public List<Appointment> getAppointmentsByUser(int userId) throws ClassNotFoundException, SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String query = "SELECT a.id, a.appointment_date, a.status, d.name AS doctor_name, d.specialization " +
                       "FROM appointments a JOIN doctors d ON a.doctor_id = d.id WHERE a.user_id = ? ORDER BY a.appointment_date DESC";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setId(rs.getInt("id"));
                appointment.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
                appointment.setStatus(rs.getString("status"));
                appointment.setDoctorName(rs.getString("doctor_name"));
                appointment.setDoctorSpecialization(rs.getString("specialization"));
                appointments.add(appointment);
            }
        }
        return appointments;
    }

    // ✅ Get all appointments (for admin)
    public List<Appointment> getAllAppointments() throws ClassNotFoundException, SQLException {
        List<Appointment> appointments = new ArrayList<>();
        String query = "SELECT a.id, a.appointment_date, a.status, " +
                       "u.name AS user_name, u.email AS user_email, " +
                       "d.name AS doctor_name, d.specialization AS doctor_specialization " +
                       "FROM appointments a " +
                       "JOIN users u ON a.user_id = u.id " +
                       "JOIN doctors d ON a.doctor_id = d.id " +
                       "ORDER BY a.appointment_date DESC";
        try (Connection conn = ConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setId(rs.getInt("id"));
                appointment.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
                appointment.setStatus(rs.getString("status"));
                appointment.setUserName(rs.getString("user_name"));
                appointment.setUserEmail(rs.getString("user_email"));
                appointment.setDoctorName(rs.getString("doctor_name"));
                appointment.setDoctorSpecialization(rs.getString("doctor_specialization"));
                appointments.add(appointment);
            }
        }
        return appointments;
    }

    // ✅ Update appointment status (admin)
    public boolean updateAppointmentStatus(int appointmentId, String status) throws ClassNotFoundException, SQLException {
        String query = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Cancel appointment (user)
    public boolean cancelAppointment(int appointmentId) throws ClassNotFoundException, SQLException {
        String query = "DELETE FROM appointments WHERE id = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        }
    }
}
