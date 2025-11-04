<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Doctor | Admin Dashboard</title>
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
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">🏥 Admin Panel</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="viewDoctors.jsp">View Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="viewAppointments.jsp">View Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Add Doctor Form -->
<div class="form-container">
    <h3 class="text-center mb-4">Add New Doctor</h3>

    <% if (request.getAttribute("status") != null) { %>
        <div class="alert alert-info text-center"><%= request.getAttribute("status") %></div>
    <% } %>

    <form action="addDoctor" method="post">
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" placeholder="Enter doctor's name" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Specialization</label>
            <input type="text" name="specialization" class="form-control" placeholder="e.g., Cardiologist" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" placeholder="doctor@example.com" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control" placeholder="Enter phone number" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Availability</label>
            <input type="text" name="availability" class="form-control" placeholder="e.g., Mon-Fri, 10 AM - 4 PM" required>
        </div>

        <div class="d-flex justify-content-between">
            <a href="viewDoctors.jsp" class="btn btn-secondary">← Back</a>
            <button type="submit" class="btn btn-primary">Add Doctor</button>
        </div>
    </form>
</div>

</body>
</html>
