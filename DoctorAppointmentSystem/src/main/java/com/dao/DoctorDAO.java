package com.dao;

import com.connection.ConnectionManager;
import com.model.Doctor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    // Add a new doctor
    public boolean addDoctor(Doctor doctor) throws ClassNotFoundException, SQLException {
        String query = "INSERT INTO doctors (name, specialization, email, phone, availability) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getEmail());
            ps.setString(4, doctor.getPhone());
            ps.setString(5, doctor.getAvailability());
            return ps.executeUpdate() > 0;
        }
    }

    // Get all doctors
    public List<Doctor> getAllDoctors() throws ClassNotFoundException, SQLException {
        List<Doctor> doctors = new ArrayList<>();
        String query = "SELECT * FROM doctors";
        try (Connection conn = ConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setName(rs.getString("name"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setAvailability(rs.getString("availability"));
                doctors.add(doctor);
            }
        }
        return doctors;
    }

    // Update doctor
    public boolean updateDoctor(Doctor doctor) throws ClassNotFoundException, SQLException {
        String query = "UPDATE doctors SET name=?, specialization=?, email=?, phone=?, availability=? WHERE id=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getEmail());
            ps.setString(4, doctor.getPhone());
            ps.setString(5, doctor.getAvailability());
            ps.setInt(6, doctor.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete doctor
    public boolean deleteDoctor(int id) throws ClassNotFoundException, SQLException {
        String query = "DELETE FROM doctors WHERE id=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Get doctor by ID (for edit)
    public Doctor getDoctorById(int id) throws ClassNotFoundException, SQLException {
        String query = "SELECT * FROM doctors WHERE id=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setName(rs.getString("name"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setAvailability(rs.getString("availability"));
                return doctor;
            }
        }
        return null;
    }

    // ✅ New: Admin login check (optional if using DAO for validation)
    public boolean checkAdminLogin(String username, String password) throws ClassNotFoundException, SQLException {
        String query = "SELECT * FROM admin WHERE username=? AND password=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
}
