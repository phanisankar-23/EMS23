<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.model.Appointment" %>
<%@ page import="com.dao.AppointmentDAO" %>

<%
    // ✅ Ensure user is logged in
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ Fetch appointments for logged-in user
    List<Appointment> appointments = null;
    try {
        AppointmentDAO dao = new AppointmentDAO();
        appointments = dao.getAppointmentsByUser(userId);  // ✅ corrected method name
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("status", "⚠️ Error fetching appointments: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Appointments | Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #4b6cb7;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .table th {
            background-color: #4b6cb7;
            color: white;
        }
    </style>
</head>
<body>

<!-- ✅ Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="userDashboard.jsp">🏥 Doctor Appointment System</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="viewDoctors.jsp">View Doctors</a></li>
                <li class="nav-item"><a class="nav-link active" href="myAppointments.jsp">My Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Main Content -->
<div class="container mt-5">
    <h2 class="text-center mb-4">My Appointments</h2>

    <% if (request.getAttribute("status") != null) { %>
        <div class="alert alert-warning text-center"><%= request.getAttribute("status") %></div>
    <% } %>

    <%
        if (appointments == null || appointments.isEmpty()) {
    %>
        <div class="alert alert-info text-center">You have no appointments booked yet.</div>
    <%
        } else {
    %>
        <table class="table table-bordered text-center align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Doctor</th>
                <th>Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Appointment app : appointments) { %>
                <tr>
                    <td><%= app.getId() %></td>
                    <td><%= app.getDoctorName() != null ? app.getDoctorName() : ("Doctor #" + app.getDoctorId()) %></td>
                    <td><%= app.getAppointmentDate() %></td>
                    <td>
                        <% if ("Confirmed".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-success">Confirmed</span>
                        <% } else if ("Cancelled".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-danger">Cancelled</span>
                        <% } else if ("Completed".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-primary">Completed</span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark"><%= app.getStatus() %></span>
                        <% } %>
                    </td>
                    <td>
                        <% if (!"Cancelled".equalsIgnoreCase(app.getStatus())) { %>
                            <a href="cancelAppointment?id=<%= app.getId() %>" class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to cancel this appointment?');">Cancel</a>
                        <% } else { %>
                            <button class="btn btn-secondary btn-sm" disabled>Cancelled</button>
                        <% } %>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
