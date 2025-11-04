package com.controller;

import com.connection.ConnectionManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (validateAdmin(username, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("adminUsername", username);
                response.sendRedirect("adminDashboard.jsp"); // create this page for admin
            } else {
                request.setAttribute("status", "❌ Invalid username or password!");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "⚠️ Error: " + e.getMessage());
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }

    // Check admin credentials from database
    private boolean validateAdmin(String username, String password) throws ClassNotFoundException, SQLException {
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
