package com.dao;

import com.connection.ConnectionManager;
import com.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // ✅ Register new user
    public boolean registerUser(User user) throws ClassNotFoundException, SQLException {
        String query = "INSERT INTO users (name, email, password, address, phone) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhone());

            return ps.executeUpdate() > 0;
        }
    }

    // ✅ User login method
    public User login(String email, String password) throws ClassNotFoundException, SQLException {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                return user;
            } else {
                return null; // login failed
            }
        }
    }

    // ✅ Admin login check
    public boolean isAdmin(String username, String password) throws ClassNotFoundException, SQLException {
        String query = "SELECT * FROM admin WHERE username=? AND password=?";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            return rs.next(); // true if admin exists
        }
    }
}
