<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>HR有限公司 人力資源系統</title>

<!-- Custom fonts for this template-->
<link href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="<c:url value='/css/sb-admin-2.min.css' />" rel="stylesheet">
<link href="<c:url value='/img/favicon.png' />" rel="icon">
<link href="<c:url value='/css/mycss.css' />" rel="stylesheet">
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>

<!-- .js請從此後寫 -->

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<jsp:include page="layout/sidebar.jsp"></jsp:include>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="layout/topbar.jsp"></jsp:include>
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid h-75">
					<!-- 					<div class="row fornone"> -->
					<div class="row">
						<!-- 展示模板用，之後要置換掉，換成有fornone的上面那個 -->
						<div class="col-12 col-md-6 mb-4">
							<div class="card">
								<div class="card-body">
									<a href="<c:url value='module' />">模板一：module(有不同模塊可用標頭搜尋程式碼區塊)</a>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6 mb-4">
							<div class="card">
								<div class="card-body">
									<a href="<c:url value='module-1' />">模板二：module-1(content全空白)</a>
								</div>
							</div>
						</div>
					</div>

					<div class="row h-25">
						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body"
									onclick="location.href='<c:url value="/checkInto" />';">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-primary text-uppercase mb-1">Clock
												In / Clock Out</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/checkInto' />"
													class="text-decoration-none">簽到/簽退</a>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-business-time fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body"
									onclick="location.href='<c:url value="/schedule/MySchedule" />';">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-success text-uppercase mb-1">My
												Roster</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/schedule/MySchedule' />"
													class="text-decoration-none">班表查詢</a>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
					<div class="row h-25">
						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-danger shadow h-100 py-2">
								<div class="card-body"
									onclick="location.href='<c:url value='#' />';">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-danger text-uppercase mb-1">My
												Attendance</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/intoQuery' />" class="text-decoration-none">出勤異常查詢</a>
											</div>

										</div>
										<div class="col-auto">
											<i class="fas fa-calendar-check fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-warning text-uppercase mb-1">Application
												Form</div>
											<div class="h4 mb-0 font-weight-bold text-center nav-item dropdown">
												<a href="#" id="ApplicationForm"
													class="nav-link dropdown-toggle"
													data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false">申請表</a>
												<div class="dropdown-menu dropdown-menu-right animated--grow-in"
													aria-labelledby="ApplicationForm">
													<a class="dropdown-item" href="<c:url value='/Leave/' />">請假</a>
													<a class="dropdown-item" href="<c:url value='/employeeOvertime' />">加班</a>
													<a class="dropdown-item" href="<c:url value='/EmpSignApply' />">補簽</a>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-file-upload fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row h-25">
						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body"
									onclick="location.href='<c:url value="/schedule/TimelineScheduling" />';">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-info text-uppercase mb-1">Scheduling</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/schedule/TableScheduling' />"
													class="text-decoration-none">排班</a>
											</div>
										</div>
										<div class="sidebar-brand-text mx-auto">
											<img src="<c:url value='img/scheduling1.png'/>" width="50" />
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-secondary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-secondary text-uppercase mb-1">
												Application Review</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="#" id="ApplicationReview"
													class="nav-link dropdown-toggle" role="button"
													data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="true"> 簽核管理 </a>
												<div
													class="dropdown-menu animated--grow-in"
													aria-labelledby="ApplicationReview">
													<a class="dropdown-item" href="<c:url value='/Leave/LeaveResult' />">請假</a>
													<a class="dropdown-item" href="<c:url value='/MangerQuery' />">打卡紀錄</a>
													<a class="dropdown-item" href="<c:url value='ManagersystemOvertime' />">加班</a>
													<a class="dropdown-item" href="<c:url value='/ManagerSignAllQuery' />">補簽</a>
												</div>
											</div>
										</div>
										<div class="sidebar-brand-text mx-auto">
											<img src="<c:url value='img/approval.png'/>" width="50" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row fornone">
						<div class="col-12 col-md-6 mb-4">
							<div class="card">
								<div class="card-body"></div>
							</div>
						</div>
						<div class="col-12 col-md-6 mb-4">
							<div class="card">
								<div class="card-body"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<jsp:include page="layout/footer.jsp"></jsp:include>

		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i></a>
</body>
<!-- Bootstrap core JavaScript-->
<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>
<script
	src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin JavaScript-->
<script
	src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Custom scripts for all pages-->
<script src="<c:url value='/js/sb-admin-2.min.js' />"></script>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
</html>