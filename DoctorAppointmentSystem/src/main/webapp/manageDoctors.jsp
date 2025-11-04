<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.DoctorDAO" %>
<%@ page import="com.model.Doctor" %>
<%
    HttpSession currentSession = request.getSession(false);
    String email = null;
    String role = null;
    if (currentSession != null) {
        email = (String) currentSession.getAttribute("email");
        role = (String) currentSession.getAttribute("role");
    }

    DoctorDAO dao = new DoctorDAO();
    List<Doctor> doctors = null;
    String searchQuery = request.getParameter("search");
    String editIdParam = request.getParameter("editId");
    String statusMessage = request.getParameter("status"); // status from servlet
    Doctor editDoctor = null;

    try {
        doctors = dao.getAllDoctors();

        // Search functionality
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String lowerQuery = searchQuery.toLowerCase();
            List<Doctor> filtered = new java.util.ArrayList<Doctor>();
            for (Doctor d : doctors) {
                if (d.getName().toLowerCase().contains(lowerQuery)
                        || d.getSpecialization().toLowerCase().contains(lowerQuery)) {
                    filtered.add(d);
                }
            }
            doctors = filtered;
        }

        // If editId is present, get doctor details for editing
        if (editIdParam != null && !editIdParam.isEmpty()) {
            int editId = Integer.parseInt(editIdParam);
            editDoctor = dao.getDoctorById(editId);
        }
    } catch (Exception e) {
        e.printStackTrace();
        if (statusMessage == null) {
            statusMessage = "⚠️ Error fetching doctors: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Doctors | Admin - Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #4b6cb7, #182848); color: #fff; min-height:100vh; }
        .navbar { background: rgba(0,0,0,0.3); backdrop-filter: blur(8px); }
        .navbar-brand { font-weight:700; color:#fff !important; font-size:1.5rem; }
        .nav-link { color:#fff !important; font-weight:500; transition:0.3s; }
        .nav-link:hover { color:#ffcc70 !important; }
        .container { margin-top:100px; }
        .table th { background-color: #4b6cb7; color: #fff; }
        .btn-custom { background: linear-gradient(to right,#ff9966,#ff5e62); color:white; border:none; border-radius:30px; padding:5px 15px; margin:2px; }
        .btn-custom:hover { transform:scale(1.05); box-shadow:0 5px 20px rgba(255,94,98,0.4); }
        input[type="text"], input[type="email"] { border-radius: 20px; padding: 5px 10px; }
        footer { background:#182848; color:#ddd; padding:20px 0; text-align:center; font-size:0.9rem; }
        footer a { color:#ff9966; text-decoration:none; }
        footer a:hover { text-decoration:underline; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="adminDashboard.jsp"><i class="bi bi-hospital me-2"></i>Doctor Appointment System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <% if (email == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="manageDoctors.jsp">Manage Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="addDoctor.jsp">Add Doctor</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewAppointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="login">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h2 class="text-center mb-4">Manage Doctors</h2>

    <!-- Status Message -->
    <% if (statusMessage != null) { %>
        <div class="alert alert-info text-center"><%= statusMessage %></div>
    <% } %>

    <!-- Search -->
    <form method="get" class="d-flex justify-content-center mb-3">
        <input type="text" name="search" class="form-control w-50 me-2" placeholder="Search by name or specialization" value="<%= searchQuery != null ? searchQuery : "" %>"/>
        <button type="submit" class="btn btn-custom">Search</button>
    </form>

    <!-- Edit Doctor Form -->
    <% if (editDoctor != null) { %>
    <div class="card p-4 mb-4 text-dark">
        <h4 class="mb-3">Edit Doctor</h4>
        <form action="updateDoctor" method="post">
            <input type="hidden" name="id" value="<%= editDoctor.getId() %>"/>
            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" class="form-control" value="<%= editDoctor.getName() %>" required>
            </div>
            <div class="mb-3">
                <label>Specialization</label>
                <input type="text" name="specialization" class="form-control" value="<%= editDoctor.getSpecialization() %>" required>
            </div>
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" value="<%= editDoctor.getEmail() %>" required>
            </div>
            <div class="mb-3">
                <label>Phone</label>
                <input type="text" name="phone" class="form-control" value="<%= editDoctor.getPhone() %>" required>
            </div>
            <div class="mb-3">
                <label>Availability</label>
                <input type="text" name="availability" class="form-control" value="<%= editDoctor.getAvailability() %>" required>
            </div>
            <button type="submit" class="btn btn-custom">Update Doctor</button>
            <a href="manageDoctors.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    <% } %>

    <!-- Doctor Table -->
    <table class="table table-bordered table-striped text-center text-dark align-middle bg-white">
        <thead>
            <tr>
                <th>Name</th>
                <th>Specialization</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% if (doctors != null && !doctors.isEmpty()) {
            for (Doctor doc : doctors) { %>
                <tr>
                    <td><%= doc.getName() %></td>
                    <td><%= doc.getSpecialization() %></td>
                    <td><%= doc.getEmail() %></td>
                    <td><%= doc.getPhone() %></td>
                    <td><%= doc.getAvailability() %></td>
                    <td>
                        <a href="manageDoctors.jsp?editId=<%=doc.getId()%>" class="btn btn-custom btn-sm"><i class="bi bi-pencil-square"></i> Edit</a>
                        <a href="deleteDoctor?id=<%=doc.getId()%>" class="btn btn-custom btn-sm"
                           onclick="return confirm('Are you sure you want to delete this doctor?');">
                           <i class="bi bi-trash"></i> Delete</a>
                    </td>
                </tr>
        <%   }
          } else { %>
            <tr><td colspan="6">No doctors found.</td></tr>
        <% } %>
        </tbody>
    </table>

    <a href="adminDashboard.jsp" class="btn btn-custom mt-3"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Doctor Appointment System | Designed by <a href="#">Your Name</a>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
