<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<!--     載入 Bootstrap -->
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!-- checksystem css -->
<link rel='stylesheet' href="<c:url value='/css/checksystem.css' />"
	type="text/css" />

<!--引用SweetAlert2.css-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />

<!--引用SweetAlert2.js-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<!-- .js請從此後寫 -->


</head>

<body id="page-top">

	<jsp:include page="header.jsp"></jsp:include>

	<!-- header刪掉 start-->



	<!-- header刪掉 End-->

	<div class="container-fluid h-75">
		<div class="row">
			<div class="col-xl-4 col-md-6 mb-4">
				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-primary text-uppercase mb-1">
									Revisit query</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
									<a href="<c:url value='/EmpSignQuery' />"
										class="text-decoration-none stretched-link">補簽查詢</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-history fa-3x text-primary"></i>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xl-4 col-md-6 mb-4">
				<div class="card border-left-danger shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-danger text-uppercase mb-1">
									Overtime query</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
									<a href="<c:url value='/employeeQuery' />"
										class="text-decoration-none stretched-link">加班查詢</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-business-time fa-3x text-danger"></i>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xl-4 col-md-6 mb-4">
				<div class="card border-left-warning shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-warning text-uppercase mb-1">
									Leave query</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
									<a href="<c:url value='/Leave/MyLeaveApply' />"
										class="text-decoration-none stretched-link">請假查詢</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-power-off fa-3x text-warning"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div></div>
			</div>

		</div>
	</div>




	<jsp:include page="footer.jsp"></jsp:include>

	<!-- footer刪掉 start -->

	<!-- footer刪掉 end -->

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>


</body>

</html>