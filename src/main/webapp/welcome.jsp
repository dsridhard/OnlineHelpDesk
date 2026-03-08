<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%
// Security check: Redirect to login if user session is not found
if (session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
}
String userName = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tourist Dashboard | Welcome</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary-color: #2a9d8f;
	--secondary-color: #264653;
}

body {
	background-color: #f4f7f6;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.hero-section {
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');
	background-size: cover;
	background-position: center;
	color: white;
	padding: 60px 0;
	margin-bottom: 40px;
	border-radius: 0 0 30px 30px;
}

.menu-card {
	border: none;
	border-radius: 15px;
	transition: all 0.3s ease;
	cursor: pointer;
	height: 100%;
	background: #fff;
}

.menu-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.icon-box {
	width: 70px;
	height: 70px;
	background-color: rgba(42, 157, 143, 0.1);
	color: var(--primary-color);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	margin-bottom: 20px;
}

.logout-btn {
	border-radius: 20px;
	padding: 8px 25px;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
		<div class="container">
			<a class="navbar-brand fw-bold" href="#">🌍 TouristPortal</a>
			<div class="ms-auto">
				<span class="text-light me-3 small">Welcome, <strong><%=userName%></strong></span>
				<a href="LogoutServlet"
					class="btn btn-outline-danger btn-sm logout-btn">Logout</a>
			</div>
		</div>
	</nav>

	<div class="hero-section text-center">
		<div class="container">
			<h1 class="display-4 fw-bold">Explore the World</h1>
			<p class="lead">Plan your journey, find expert guides, and
				discover hidden gems.</p>
		</div>
	</div>

	<div class="container mb-5">
		<div class="row g-4">
			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='explorePlaces.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-map-location-dot"></i>
					</div>
					<h4 class="fw-bold">Discover Places</h4>
					<p class="text-muted small">Browse top-rated tourist
						destinations and landmarks.</p>
					<div class="text-primary fw-bold small mt-auto">Explore Now
						&rarr;</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='complaint.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-user-tie"></i>
					</div>
					<h4 class="fw-bold">Make Complaint</h4>
					<p class="text-muted small">Report issues or problems you faced
						during your travel. Our support team will review and resolve your
						complaint quickly.</p>
					<div class="text-primary fw-bold small mt-auto">Make
						Complaint &rarr;</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='query.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-circle-question"></i>
					</div>
					<h4 class="fw-bold">Ask Query</h4>
					<p class="text-muted small">Have a question? Ask our support
						team anything.</p>
					<div class="text-primary fw-bold small mt-auto">Get Help
						&rarr;</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='feedback.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-star"></i>
					</div>
					<h4 class="fw-bold">Feedback</h4>
					<p class="text-muted small">Rate your experience and help us
						improve our services.</p>
					<div class="text-primary fw-bold small mt-auto">Rate Us
						&rarr;</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='profile.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-user-gear"></i>
					</div>
					<h4 class="fw-bold">My Profile</h4>
					<p class="text-muted small">Update your personal details and
						travel preferences.</p>
					<div class="text-primary fw-bold small mt-auto">Manage
						Profile &rarr;</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card menu-card p-4 text-center"
					onclick="location.href='viewPlan.jsp'">
					<div class="icon-box mx-auto">
						<i class="fa-solid fa-calendar-check"></i>
					</div>
					<h4 class="fw-bold">My Plans</h4>
					<p class="text-muted small">Check your booked tours and
						upcoming schedules.</p>
					<div class="text-primary fw-bold small mt-auto">Check Status
						&rarr;</div>
				</div>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>