<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.AppointmentDAO" %>
<%@ page import="com.model.Appointment" %>

<%
    // ✅ Ensure admin is logged in
    String email = (String) session.getAttribute("email");
    if (email == null || !"admin@cg.com".equals(email)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ Fetch all appointments
    List<Appointment> appointments = null;
    String statusMessage = request.getParameter("status");
    try {
        AppointmentDAO dao = new AppointmentDAO();
        appointments = dao.getAllAppointments();
    } catch (Exception e) {
        e.printStackTrace();
        statusMessage = "⚠️ Error fetching appointments: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Appointments | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
        .navbar { background-color: #4b6cb7; }
        .navbar-brand, .nav-link { color: white !important; }
        .table th { background-color: #4b6cb7; color: white; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">🏥 Doctor Appointment</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a class="nav-link active" href="viewAppointments.jsp">View Appointments</a></li>
            <li class="nav-item"><a class="nav-link" href="manageDoctors.jsp">Manage Doctors</a></li>
            <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">All Appointments</h2>

    <% if (statusMessage != null) { %>
        <div class="alert alert-warning text-center"><%= statusMessage %></div>
    <% } %>

    <% if (appointments == null || appointments.isEmpty()) { %>
        <div class="alert alert-info text-center">No appointments found.</div>
    <% } else { %>
        <table class="table table-bordered text-center align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Email</th>
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
                    <td><%= app.getUserName() %></td>
                    <td><%= app.getUserEmail() %></td>
                    <td><%= app.getDoctorName() %> (<%= app.getDoctorSpecialization() %>)</td>
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
                            <form action="updateAppointmentStatus" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%= app.getId() %>"/>
                                <select name="status" class="form-select form-select-sm d-inline w-auto">
                                    <option value="Confirmed" <%= "Confirmed".equalsIgnoreCase(app.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                    <option value="Completed" <%= "Completed".equalsIgnoreCase(app.getStatus()) ? "selected" : "" %>>Completed</option>
                                    <option value="Cancelled">Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Update</button>
                            </form>
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
