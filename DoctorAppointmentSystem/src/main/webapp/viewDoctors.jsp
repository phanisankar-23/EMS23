<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Doctor" %>
<%@ page import="com.dao.DoctorDAO" %>
<%
    javax.servlet.http.HttpSession currentSession = request.getSession(false);
    String email = (session != null) ? (String) session.getAttribute("email") : null;
    String name = (session != null) ? (String) session.getAttribute("name") : null;
    String role = (session != null) ? (String) session.getAttribute("role") : null;

    List<Doctor> doctors = null;
    try {
        DoctorDAO dao = new DoctorDAO();
        doctors = dao.getAllDoctors();
    } catch(Exception e) {
        e.printStackTrace();
        request.setAttribute("status", "⚠️ Error fetching doctors: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Doctors | Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4b6cb7, #182848);
            color: #fff;
            min-height: 100vh;
        }
        .navbar { background: rgba(0, 0, 0, 0.3); backdrop-filter: blur(8px); }
        .navbar-brand { font-weight: 700; color: #fff !important; font-size: 1.5rem; }
        .nav-link { color: #fff !important; font-weight: 500; transition: 0.3s; }
        .nav-link:hover { color: #ffcc70 !important; }
        .container { margin-top: 100px; }
        .table th { background-color: #4b6cb7; color: #fff; }
        .btn-custom {
            background: linear-gradient(to right, #ff9966, #ff5e62);
            color: white; border: none; border-radius: 30px; padding: 8px 20px; margin: 2px;
            transition: all 0.3s ease-in-out;
        }
        .btn-custom:hover { transform: scale(1.05); box-shadow: 0 5px 20px rgba(255, 94, 98, 0.4); }
        footer { background: #182848; color: #ddd; padding: 20px 0; text-align: center; font-size: 0.9rem; }
        footer a { color: #ff9966; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
        input[type="date"] { border-radius: 20px; padding: 3px 8px; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="<%= "admin".equals(role) ? "adminDashboard.jsp" : "userDashboard.jsp" %>">
            <i class="bi bi-hospital me-2"></i>Doctor Appointment System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <% if (email == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <% } else if ("admin".equals(role)) { %>
                    <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="viewDoctors.jsp">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewAppointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="userDashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="viewDoctors.jsp">View Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="myAppointments.jsp">My Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero text-center mt-5 pt-5">
    <div class="container">
        <h1>Available Doctors</h1>
        <p>Browse through the list of doctors and their specializations.</p>
        <% if ("admin".equals(role)) { %>
            <a href="addDoctor.jsp" class="btn btn-custom"><i class="bi bi-person-plus"></i> Add Doctor</a>
        <% } %>
    </div>
</section>

<!-- Doctors Table -->
<div class="container mt-5">
    <% if(request.getAttribute("status") != null){ %>
        <div class="alert alert-warning text-center"><%= request.getAttribute("status") %></div>
    <% } %>

    <table class="table table-bordered table-striped text-center bg-white text-dark align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Specialization</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Availability</th>
                <% if ("admin".equals(role)) { %>
                    <th>Actions</th>
                <% } else { %>
                    <th>Book Appointment</th>
                <% } %>
            </tr>
        </thead>
        <tbody>
        <% if(doctors != null){
            for(Doctor doc : doctors){ %>
                <tr>
                    <td><%= doc.getId() %></td>
                    <td><%= doc.getName() %></td>
                    <td><%= doc.getSpecialization() %></td>
                    <td><%= doc.getEmail() %></td>
                    <td><%= doc.getPhone() %></td>
                    <td><%= doc.getAvailability() %></td>
                    <% if ("admin".equals(role)) { %>
                        <td>
                            <a href="editDoctor?id=<%=doc.getId()%>" class="btn btn-custom btn-sm"><i class="bi bi-pencil-square"></i> Edit</a>
                            <a href="deleteDoctor?id=<%=doc.getId()%>" class="btn btn-custom btn-sm"
                               onclick="return confirm('Are you sure you want to delete this doctor?');">
                               <i class="bi bi-trash"></i> Delete</a>
                        </td>
                    <% } else { %>
                        <td>
                            <form action="bookAppointment" method="post" class="d-flex justify-content-center align-items-center">
                                <input type="hidden" name="doctorId" value="<%= doc.getId() %>"/>
                                <input type="date" name="appointmentDate" class="form-control form-control-sm me-2" required
                                       min="<%= java.time.LocalDate.now() %>"/>
                                <button type="submit" class="btn btn-custom btn-sm">Book</button>
                            </form>
                        </td>
                    <% } %>
                </tr>
        <%  }
          } else { %>
              <tr><td colspan="<%= "admin".equals(role) ? 7 : 7 %>">No doctors found.</td></tr>
        <% } %>
        </tbody>
    </table>

    <a href="<%= "admin".equals(role) ? "adminDashboard.jsp" : "userDashboard.jsp" %>" 
       class="btn btn-custom mt-3"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Doctor Appointment System | Designed by <a href="#"></a>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
