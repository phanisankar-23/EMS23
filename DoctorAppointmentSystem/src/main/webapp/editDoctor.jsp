<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Doctor" %>
<%
    Doctor doctor = (Doctor) request.getAttribute("doctor");

    if (doctor == null) {
        response.sendRedirect("viewDoctors.jsp?status=Doctor+not+found");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Doctor | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4b6cb7, #182848);
            color: #fff;
            min-height: 100vh;
        }
        .container {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            margin-top: 100px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.2);
        }
        .form-label { font-weight: 600; color: #fff; }
        .form-control {
            border-radius: 10px;
            border: none;
            padding: 10px;
            background-color: rgba(255,255,255,0.9);
        }
        .btn-custom {
            background: linear-gradient(to right,#ff9966,#ff5e62);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover { transform: scale(1.05); box-shadow: 0 5px 20px rgba(255,94,98,0.4); }
        .btn-secondary {
            border-radius: 30px;
            padding: 10px 25px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><i class="bi bi-pencil-square me-2"></i>Edit Doctor Details</h2>

    <% if(request.getAttribute("status") != null){ %>
        <div class="alert alert-info text-center"><%= request.getAttribute("status") %></div>
    <% } %>

    <form action="updateDoctor" method="post">
        <input type="hidden" name="id" value="<%= doctor.getId() %>">

        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" value="<%= doctor.getName() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Specialization</label>
            <input type="text" name="specialization" class="form-control" value="<%= doctor.getSpecialization() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="<%= doctor.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control" value="<%= doctor.getPhone() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Availability</label>
            <input type="text" name="availability" class="form-control" value="<%= doctor.getAvailability() %>" required>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-custom me-2">
                <i class="bi bi-save"></i> Update Doctor
            </button>
            <a href="viewDoctors.jsp" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Back
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
