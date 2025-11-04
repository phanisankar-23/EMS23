package com.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.UserDAO;
import com.model.User;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession(true);

        // ✅ Hardcoded admin login check
        if (email.equalsIgnoreCase("admin@cg.com") && password.equals("admin@123")) {
            session.setAttribute("email", email);
            response.sendRedirect("adminDashboard.jsp"); // redirect to admin page
        } else {
            UserDAO dao = new UserDAO();
            try {
                User user = dao.login(email, password);
                if (user != null) {
                    session.setAttribute("userId", user.getId());
                    session.setAttribute("name", user.getName());
                    session.setAttribute("email", user.getEmail());
                    response.sendRedirect("userDashboard.jsp"); // redirect to user page
                } else {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    request.setAttribute("status", "❌ Invalid Credentials");
                    dispatcher.forward(request, response);
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                request.setAttribute("status", "⚠️ Error: " + e.getMessage());
                dispatcher.forward(request, response);
            }
        }
    }

    // Optional: allow GET to redirect to login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
