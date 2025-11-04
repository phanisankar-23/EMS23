package com.controller;

import com.dao.DoctorDAO;
import com.model.Doctor;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateDoctor")
public class UpdateDoctorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Correct session check for admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin@cg.com".equals(session.getAttribute("email"))) {
            // Admin not logged in
            response.sendRedirect("login.jsp"); // you can redirect to your user login page
            return;
        }

        try {
            // Collect updated data from form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String availability = request.getParameter("availability");

            // Create Doctor object
            Doctor doctor = new Doctor();
            doctor.setId(id);
            doctor.setName(name);
            doctor.setSpecialization(specialization);
            doctor.setEmail(email);
            doctor.setPhone(phone);
            doctor.setAvailability(availability);

            // Update in database
            DoctorDAO dao = new DoctorDAO();
            boolean updated = dao.updateDoctor(doctor);

            if (updated) {
                response.sendRedirect("manageDoctors.jsp?status=Doctor+updated+successfully");
            } else {
                response.sendRedirect("manageDoctors.jsp?editId=" + id + "&status=Failed+to+update+doctor");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("manageDoctors.jsp?status=Invalid+doctor+ID");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("manageDoctors.jsp?status=Error+updating+doctor");
        }
    }
}
