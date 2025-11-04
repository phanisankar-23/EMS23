package com.controller;

import com.dao.DoctorDAO;
import com.model.Doctor;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editDoctor")
public class EditDoctorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUsername") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("viewDoctors.jsp?status=Invalid+doctor+ID");
            return;
        }

        int id = Integer.parseInt(idParam);
        DoctorDAO dao = new DoctorDAO();

        try {
            Doctor doctor = dao.getDoctorById(id);

            if (doctor != null) {
                request.setAttribute("doctor", doctor);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editDoctor.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("viewDoctors.jsp?status=Doctor+not+found");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("viewDoctors.jsp?status=Error+loading+doctor");
        }
    }
}
