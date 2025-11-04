package com.controller;

import com.dao.DoctorDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.net.URLEncoder;

@WebServlet("/deleteDoctor")
public class DeleteDoctorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin@cg.com".equals(session.getAttribute("email"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);

                DoctorDAO dao = new DoctorDAO();
                boolean deleted = dao.deleteDoctor(id);

                if (deleted) {
                    response.sendRedirect("manageDoctors.jsp?status=" + URLEncoder.encode("Doctor deleted successfully", "UTF-8"));
                } else {
                    response.sendRedirect("manageDoctors.jsp?status=" + URLEncoder.encode("Failed to delete doctor", "UTF-8"));
                }
            } else {
                response.sendRedirect("manageDoctors.jsp?status=" + URLEncoder.encode("Invalid doctor ID", "UTF-8"));
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("manageDoctors.jsp?status=" + URLEncoder.encode("Invalid doctor ID", "UTF-8"));
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // log full error in server console
            response.sendRedirect("manageDoctors.jsp?status=" + URLEncoder.encode("Error deleting doctor: " + e.getMessage(), "UTF-8"));
        }
    }
}
