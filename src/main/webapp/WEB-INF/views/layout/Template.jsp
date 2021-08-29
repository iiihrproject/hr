<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>HR有限公司 人力資源系統</title>

<!-- Custom fonts for this template-->
<link href="<c:url value='/vendor/fontawesome-free/css/all.min.css' />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="<c:url value='/css/sb-admin-2.min.css' />" rel="stylesheet">
<link href="<c:url value='/img/favicon.png' />" rel="icon" > 
<link href="<c:url value='/css/mycss.css' />" rel="stylesheet" > 


<!-- .js請從此後寫 -->

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<jsp:include page="L_sidebar.jsp"></jsp:include>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<jsp:include page="L_topbar.jsp"></jsp:include>
				
				<!-- Begin Page Content -->
				<jsp:include page="../${body }"></jsp:include>
			</div>
			<!-- End of Main Content -->
			
			<!-- Footer -->
			<jsp:include page="L_footer.jsp"></jsp:include>

		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i></a>
</body>
<!-- Bootstrap core JavaScript-->
<script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>
<script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin JavaScript-->
<script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Custom scripts for all pages-->
<script src="<c:url value='/js/sb-admin-2.min.js' />"></script>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
</html>