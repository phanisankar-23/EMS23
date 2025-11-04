<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f1f1f1; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .container { background: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.2); width: 400px; }
        .btn-custom { background: #4b6cb7; color: #fff; border-radius: 30px; width: 100%; }
        .status { margin-bottom: 15px; color: green; text-align: center; font-weight: 500; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center">User Registration</h2>
    <% if(request.getAttribute("status") != null) { %>
        <div class="status"><%= request.getAttribute("status") %></div>
    <% } %>
    <form action="register" method="post">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Address</label>
            <input type="text" name="address" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-custom">Register</button>
        <p class="mt-2 text-center"><a href="login.jsp">Already have an account? Login</a></p>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
