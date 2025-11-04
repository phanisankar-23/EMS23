<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    javax.servlet.http.HttpSession currentSession = request.getSession(false);
    String email = null;
    String role = null;
    if (currentSession != null) {
        email = (String) currentSession.getAttribute("email");
        role = (String) currentSession.getAttribute("role");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Doctor Appointment System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4b6cb7, #182848);
            color: #fff;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(8px);
        }

        .navbar-brand {
            font-weight: 700;
            color: #fff !important;
            font-size: 1.5rem;
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
            transition: 0.3s;
        }

        .nav-link:hover {
            color: #ffcc70 !important;
        }

        .hero {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            height: 90vh;
            padding: 20px;
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.4);
        }

        .hero p {
            font-size: 1.2rem;
            color: #e2e2e2;
            margin-bottom: 30px;
        }

        .btn-custom {
            background: linear-gradient(to right, #ff9966, #ff5e62);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 30px;
            padding: 12px 30px;
            margin: 8px;
            transition: all 0.3s ease-in-out;
        }

        .btn-custom:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(255, 94, 98, 0.4);
        }

        .features {
            background-color: #fff;
            color: #333;
            padding: 80px 0;
            border-top-left-radius: 50px;
            border-top-right-radius: 50px;
            margin-top: -60px;
        }

        .feature-box {
            background: #f9f9f9;
            border-radius: 20px;
            padding: 30px;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .feature-box:hover {
            transform: translateY(-8px);
            background: linear-gradient(145deg, #fdfbfb, #ebedee);
        }

        .feature-box i {
            font-size: 40px;
            color: #4b6cb7;
            margin-bottom: 15px;
        }

        .feature-box h5 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        footer {
            background: #182848;
            color: #ddd;
            padding: 20px 0;
            margin-top: 80px;
            text-align: center;
            font-size: 0.9rem;
        }

        footer a {
            color: #ff9966;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-hospital me-2"></i>Doctor Appointment System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <% if (email == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="adminDashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="addDoctor.jsp">Add Doctor</a></li>
                    <li class="nav-item"><a class="nav-link" href="manageDoctors.jsp">Manage Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="viewAppointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="login">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container mt-5 pt-5">
        <h1>Welcome Admin!</h1>
        <p>Manage doctors, appointments, and users efficiently from here.</p>

        <a href="addDoctor.jsp" class="btn btn-custom"><i class="bi bi-person-plus"></i> Add Doctor</a>
        <a href="manageDoctors.jsp" class="btn btn-custom"><i class="bi bi-pencil-square"></i> Manage Doctors</a>
        <a href="viewAppointments.jsp" class="btn btn-custom"><i class="bi bi-calendar-check"></i> View Appointments</a>
        <a href="login" class="btn btn-custom"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container text-center">
        <h2 class="mb-5 fw-bold text-dark">Admin Controls</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="bi bi-person-plus"></i>
                    <h5>Add Doctor</h5>
                    <p>Register new doctors into the system with specialization and contact info.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="bi bi-pencil-square"></i>
                    <h5>Manage Doctors</h5>
                    <p>Edit or remove doctor information, ensuring accurate scheduling.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="bi bi-calendar-check"></i>
                    <h5>Appointments</h5>
                    <p>View and monitor all appointments booked by users efficiently.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    &copy; 2025 Doctor Appointment Booking System | Designed by <a href="#"></a>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
