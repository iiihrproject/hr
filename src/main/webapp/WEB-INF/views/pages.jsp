<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<link href="<c:url value='vendor/fontawesome-free/css/all.min.css' />"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->

<link href="<c:url value='css/sb-admin-2.min.css' />" rel="stylesheet">
<link rel="icon" href="<c:url value='img/favicon.png' />">
<link rel="stylesheet" href="<c:url value='css/mycss.css' />">
<script src="js/jquery-3.6.0.min.js"></script>
<script>
<!-- .js請從此後寫 -->
	window.addEventListener("load", function() {
		isAuthMoreThanGEN();
	});

	//判斷AUTH是否不只General
	function isAuthMoreThanGEN() {
		var isAuthMoreThanGEN = false;
		$.get("<c:url value='/G/findAUTHByEmpNo' />", function(isAuthMoreThanGEN, status) {
// 			console.log("isAuthMoreThanGen = " + isAuthMoreThanGEN);
			if (isAuthMoreThanGEN) {
				$("#managerCard").removeClass("invisible");
			}
		})
	}
</script>
</head>

<body id="page-top">
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Begin Page Content -->
				<div class="container-fluid h-75">
				
<!-- 					<div class="row fornone"> -->
<!-- 					<div class="row"> -->
<!-- 						展示模板用，之後要置換掉，換成有fornone的上面那個 -->
<!-- 						<div class="col-12 col-md-6 mb-4"> -->
<!-- 							<div class="card"> -->
<!-- 								<div class="card-body"> -->
<%-- 									<a href="<c:url value='module' />">模板一：module(有不同模塊可用標頭搜尋程式碼區塊)</a> --%>
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-12 col-md-6 mb-4"> -->
<!-- 							<div class="card"> -->
<!-- 								<div class="card-body"> -->
<%-- 									<a href="<c:url value='module-1' />">模板二：module-1(content全空白)</a> --%>
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->

					<div class="row h-25">
						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-primary text-uppercase mb-1">Clock
												In / Clock Out</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/checkInto' />"
													class="text-decoration-none stretched-link">簽到/簽退</a>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-business-time fa-3x text-primary"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-danger shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-danger text-uppercase mb-1">My
												Attendance</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/intoQuery' />" class="text-decoration-none stretched-link">出勤異常查詢</a>
											</div>

										</div>
										<div class="col-auto">
											<i class="fas fa-exclamation-triangle fa-4x text-danger"></i>
										</div>
									</div>
								</div>
							</div>
						</div>


					</div>
					<div class="row h-25">
						<div class="col-12 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-lg font-weight-bold text-success text-uppercase mb-1">My
												Roster</div>
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="<c:url value='/schedule/MySchedule' />"
													class="text-decoration-none stretched-link">班表查詢</a>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-calendar-week fa-4x text-success"></i>
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
											<div class="h4 mb-0 font-weight-bold text-center">
												<a href="#" id="ApplicationForm"
													class="text-decoration-none dropdown-toggle"
													data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false">申請表</a>
												<div class="dropdown-menu dropdown-menu-right"
													aria-labelledby="ApplicationForm">
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/Leave/' />">請假</a>
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/employeeOvertime' />">加班</a>
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/EmpSignApply' />">補簽</a>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-file-upload fa-4x text-warning"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row h-25 invisible" id="managerCard">
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
											<i class="fas fa-calendar-plus fa-4x text-info"></i>
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
													class="text-decoration-none dropdown-toggle" role="button"
													data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="true"> 簽核管理 </a>
												<div
													class="dropdown-menu dropdown-menu-right"
													aria-labelledby="ApplicationReview">
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/Leave/LeaveResult' />">請假</a>
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/mangerCheckQuery' />">打卡紀錄</a>
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/ManagersystemOvertime' />">加班</a>
													<a class="dropdown-item h5 mb-0 text-gray-800" href="<c:url value='/ManagerSignAllQuery' />">補簽</a>
												</div>
											</div>
										</div>
										<div class="sidebar-brand-text mx-auto">
											<i class="fas fa-stamp fa-4x text-secondary"></i>
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
	<!-- /.container-fluid -->

	<!-- End of Main Content -->

	<jsp:include page="footer.jsp"></jsp:include>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>
</html>