package com.controller;

import com.dao.DoctorDAO;
import com.model.Doctor;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addDoctor")
public class AddDoctorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Check if admin is logged in (based on your hardcoded login system)
        HttpSession session = request.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("email") : null;

        if (email == null || !email.equalsIgnoreCase("admin@cg.com")) {
            response.sendRedirect("login.jsp"); // ✅ changed from adminLogin.jsp
            return;
        }

        // ✅ Read doctor details from the form
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String doctorEmail = request.getParameter("email");
        String phone = request.getParameter("phone");
        String availability = request.getParameter("availability");

        // ✅ Create Doctor object
        Doctor doctor = new Doctor();
        doctor.setName(name);
        doctor.setSpecialization(specialization);
        doctor.setEmail(doctorEmail);
        doctor.setPhone(phone);
        doctor.setAvailability(availability);

        DoctorDAO dao = new DoctorDAO();

        try {
            boolean added = dao.addDoctor(doctor);

            if (added) {
                // ✅ Redirect to View Doctors page with a success message
                response.sendRedirect("viewDoctors.jsp?status=Doctor+added+successfully");
            } else {
                request.setAttribute("status", "❌ Failed to add doctor!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("addDoctor.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("status", "⚠️ Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("addDoctor.jsp");
            dispatcher.forward(request, response);
        }
    }
}
