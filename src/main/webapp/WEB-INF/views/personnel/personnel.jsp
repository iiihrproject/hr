<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
<link rel="icon" href="<c:url value='img/favicon.png' />">
<link rel="stylesheet" href="<c:url value='css/sb-admin-2.min.css' />">
<link rel="stylesheet" href="<c:url value='css/mycss.css' />">
<style>
.myPageLink:hover {
	z-index: 2;
	color: #224abe;
	text-decoration: none;
	background-color: RGBA(121, 115, 174, 0.2);
	border-color: #dddfeb;
}
</style>
<script src="js/jquery-3.6.0.min.js"></script>
<!-- .js請從此後寫 -->
<script>
		window.onload = function(){
			let xhr = new XMLHttpRequest();
			xhr.open("GET", "<c:url value='/personnelAuthorization'/>", true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					let result = JSON.parse(xhr.responseText);
					if(result.result === "false"){
						
						$("#personnel").remove();
						$("#department").remove();
					}
				}
			}	  
		}
	</script>
</head>
<body id="page-top">
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container-fluid h-75">
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
		<div class="row h-25">
			<div class="col-12 col-md-6 mb-4">
				<div class="card border-left-primary shadow h-100 py-2 myPageLink">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-primary text-uppercase mb-1">Account Settings</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/editPersonalInfo' />"
										class="text-decoration-none stretched-link">個人資料修改</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-id-card fa-4x text-primary"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 mb-4">
				<div class="card border-left-danger shadow h-100 py-2 myPageLink">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-danger text-uppercase mb-1">Change password</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/updatePassword' />"
										class="text-decoration-none stretched-link">密碼修改</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-user-lock text-danger fa-4x"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row h-25" id="department">
			<div class="col-12 col-md-6 mb-4">
				<div class="card border-left-light bg-gradient-info text-white border-light shadow h-100 py-2">
					<div class="card-body myPageLink">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-light text-uppercase mb-1">Department Edit</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/department' />"
										class="text-decoration-none stretched-link text-light">部門編輯</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-sitemap fa-4x text-light"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 mb-4">
				<div class="card border-left-light bg-gradient-info text-white border-light shadow h-100 py-2">
					<div class="card-body myPageLink">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-light text-uppercase mb-1">New Department</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/addNewDepartment' />"
										class="text-decoration-none stretched-link text-light">新增部門</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-plus-square fa-4x text-light"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row h-25" id="personnel">
			<div class="col-12 col-md-6 mb-4">
				<div
					class="card border-left-light bg-gradient-secondary text-white border-light shadow h-100 py-2">
					<div class="card-body myPageLink">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-light text-uppercase mb-1">Employee Edit</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/modifyLoginModel' />"
										class="text-decoration-none stretched-link text-light">編輯員工</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-user-edit fa-4x text-light"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 mb-4">
				<div
					class="card border-left-light bg-gradient-secondary text-white border-light shadow h-100 py-2">
					<div class="card-body myPageLink">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-lg font-weight-bold text-light text-uppercase mb-1">New Employee</div>
								<div class="h4 mb-0 font-weight-bold text-center">
									<a href="<c:url value='/addNewPersonnel' />"
										class="text-decoration-none stretched-link text-light">新增員工</a>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-user-plus fa-4x text-light"></i>
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

	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>
</body>
</html>