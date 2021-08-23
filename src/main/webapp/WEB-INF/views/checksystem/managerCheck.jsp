<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    
    <link href="<c:url value='vendor/fontawesome-free/css/all.min.css' />" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    
    <link href="<c:url value='css/sb-admin-2.min.css' />" rel="stylesheet">
    <link rel="icon" href="<c:url value='img/favicon.png' />">
    <link rel="stylesheet" href="<c:url value='css/mycss.css' />">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    <script type="text/javascript">
    $(document).ready(function(){
		let dataArea = $('#tb_departments');
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/findAllCheck'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200){
				
				dataArea.html(findAllCheck(xhr.response));
			}
		}
		
	})
	
	function findAllCheck(jsonString){
		let checksystems = JSON.parse(jsonString);
		let segment = "<table border='1' class='table table-bordered' width='100%'>";
		segment += "<tr><th colspan='6'>員工打卡清單</th></tr>";
		segment += "<tr><th>員工編號</th><th>上班打卡</th><th>下班打卡</th><th>是否遲到</th><th>是否準時</th><th>出勤時數</th>";
		for(let n = 0 ; n< checksystems.length; n++){
			let checksystem = checksystems[n];
			segment += "<tr>";
			segment += "<td>" + checksystem.empNo +"</td>";
			segment += "<td>" + checksystem.checkInTime +"</td>";
			segment += "<td>" + checksystem.checkOutTime +"</td>";
			
			var isLateCheckIn = checksystem.isLateCheckIn;
			var isOnTimeCheckOut = checksystem.isOnTimeCheckOut;
			
			if(isLateCheckIn = 'Y') isLateCheckIn = '是';
			else isLateCheckIn = '否';
			
			if(isOnTimeCheckOut ='Y') isOnTimeCheckOut = '是';
			else isOnTimeCheckOut = '否';
			
			segment += "<td>" + isLateCheckIn +"</td>";
			segment += "<td>" + isOnTimeCheckOut +"</td>";
			segment += "<td>" + checksystem.workingHours +"</td>";
			segment += "</tr>";
		}
		segment += "</table>";
		return segment;
	}
    
    
    </script>
    
	
	

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>
<!-- header刪掉 End-->
	<div id="bgcolor" class="container-fluid">
		<div class="">
			<div class="card shadow mb-4">
				<div class="card-body">
					<div id='tb_departments' align='center' data-toggle="table" >
					</div>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>


</body>

</html>