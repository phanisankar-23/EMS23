<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    javax.servlet.http.HttpSession currentSession = request.getSession(false);
    String email = null;
    String role = null;
    if (currentSession != null) {
        email = (String) currentSession.getAttribute("email");
        role = (String) currentSession.getAttribute("role"); // optional for future use
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4b6cb7, #182848);
            color: #fff;
            min-height: 100vh;
        }

        /* Navbar */
        .navbar {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(8px);
        }
        .navbar-brand { font-weight: 700; color: #fff !important; font-size: 1.5rem; }
        .nav-link { color: #fff !important; font-weight: 500; transition: 0.3s; }
        .nav-link:hover { color: #ffcc70 !important; }

        /* Login box */
        .login-box {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            width: 400px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            margin: 100px auto 0 auto;
        }
        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 700;
        }
        .form-control { border-radius: 30px; }
        .btn-custom {
            background: linear-gradient(to right, #ff9966, #ff5e62);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 30px;
            width: 100%;
            padding: 12px;
            transition: all 0.3s ease-in-out;
        }
        .btn-custom:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(255, 94, 98, 0.4);
        }
        .status {
            margin-bottom: 15px;
            color: #ffcc70;
            text-align: center;
            font-weight: 500;
        }
        a { color: #ffcc70; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-heart-pulse me-2"></i>Doctor Appointment System </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <% if (email == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="login-box">
    <h2><i class="bi bi-person-circle me-2"></i>Login</h2>
    <% if(request.getAttribute("status") != null) { %>
        <div class="status"><%= request.getAttribute("status") %></div>
    <% } %>
    <form action="login" method="post">
        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-custom">Login</button>
        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register</a></p>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
