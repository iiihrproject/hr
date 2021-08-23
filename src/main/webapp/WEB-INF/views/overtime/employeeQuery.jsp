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
    <style type="text/css">
	.currentPage{
		background-color: green;
	}
	table{
		text-align: center;
	}

	</style>
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
<script>
    $(document).ready(function(){
	let pending = $('#overtimepending');
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/findEmpOvertime'/>");
	xhr.send();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			pending.html(findEmpOvertimePending(xhr.response));
			
		}
	}
	
	let auditted = $('#overtimeauditted');
	let xhr1 = new XMLHttpRequest();
	xhr1.open("GET","<c:url value='/findEmpOvertime2'/>");
	xhr1.send();
	xhr1.onreadystatechange = function(){
		if(xhr1.readyState == 4 && xhr1.status == 200){
			auditted.html(findEmpOvertimeAuditted(xhr1.response));
		}
	}
	
	$('#search').click(function(){
		
		var depart = $("#depart").val();
		var date = $("#date").val();
		
		callPending(null,depart,date);
		callAutiditted(null,depart,date);
			
	});
	
	
});
	function callPending(page,depart,date){
		
		var url = "<c:url value='/findEmpOvertime'/>";
		
		depart = depart == '' ? null : depart;
		date = date == '' ? null : date;
		page = page == '' ? 1 : page;
		
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/findEmpOvertime'/>?depart=" + depart + "&date=" + date + "&pageNo=" + page);
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				findEmpOvertimePending(xhr.response);
				
			}
		}
		
	}
	
	
	function callAutiditted(page,depart,date){
		
		var url = "<c:url value='/findEmpOvertime'/>";
		
		depart = depart == '' ? null : depart;
		date = date == '' ? null : date;
		page = page == '' ? 1 : page;
		
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET","<c:url value='/findEmpOvertime2'/>?depart=" + depart + "&date=" + date + "&pageNo=" + page);
		xhr1.send();
		xhr1.onreadystatechange = function(){
			if(xhr1.readyState == 4 && xhr1.status == 200){
				findEmpOvertimeAuditted(xhr1.response);
			}
		}
	}
	
	
	function findEmpOvertimePending(jsonString){
		
		let pending = $('#overtimepending');
		
		let result = JSON.parse(jsonString);
		let overtimependings = result.result;
		let segment ="<table border='1'class='table table-bordered' >";
		
		if(overtimependings != null){
			segment += "<tr><th colspan='10'>員工加班查詢系統</th></tr>";
			segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>審核狀態</th>";
			
			for(let n = 0 ; n< overtimependings.length; n++){
				let overtimepending = overtimependings[n];
				segment += "<tr>";
				segment += "<td>"+ overtimepending.dateOfApplication + "</td>";
				segment += "<td>"+ overtimepending.empName + "</td>";
				segment += "<td>"+ overtimepending.department + "</td>";
				segment += "<td>"+ overtimepending.position + "</td>";
				segment += "<td>"+ overtimepending.overtimeCategory + "</td>";
				segment += "<td>"+ overtimepending.overTimeDate + "</td>";
				segment += "<td>"+ overtimepending.startingTime + "</td>";
				segment += "<td>"+ overtimepending.endingTime + "</td>";
				segment += "<td>"+ overtimepending.overTimeHours + "</td>";
				segment += "<td>"+ overtimepending.result + "</td>";
			}
			segment += "</table>";
			
			var totalPage = result.totalPage;
			var currentPage = result.currentPage;
			
			for(let n = 1 ; n<= totalPage; n++){
				
				var isCurrent = "";
				
				if(n == currentPage) isCurrent = "currentPage";
				
				var id = 'page' + n;
				
				segment += "<button onclick='pendPageClick(this)' class='pendPageNo " + isCurrent + "'  id='" + id + "' " + ">" + n + "</button>";
				
			}
		}
		
		pending.html(segment);
		
	}
	
	function findEmpOvertimeAuditted(jsonString){
		
		let auditted = $('#overtimeauditted');
		
		let result = JSON.parse(jsonString);
		
		let overtimeauditteds = result.result;
		let segment ="<table border='1'class='table table-bordered' >";
		if(overtimeauditteds !== null){
			segment += "<tr><th colspan='10'>員工加班查詢系統</th></tr>";
			segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>審核狀態</th>";
			for(let n = 0 ; n< overtimeauditteds.length; n++){
				let overtimeauditted = overtimeauditteds[n];
				segment += "<tr>";
				segment += "<td>"+ overtimeauditted.dateOfApplication + "</td>";
				segment += "<td>"+ overtimeauditted.empName + "</td>";
				segment += "<td>"+ overtimeauditted.department + "</td>";
				segment += "<td>"+ overtimeauditted.position + "</td>";
				segment += "<td>"+ overtimeauditted.overtimeCategory + "</td>";
				segment += "<td>"+ overtimeauditted.overTimeDate + "</td>";
				segment += "<td>"+ overtimeauditted.startingTime + "</td>";
				segment += "<td>"+ overtimeauditted.endingTime + "</td>";
				segment += "<td>"+ overtimeauditted.overTimeHours + "</td>";
				segment += "<td>"+ overtimeauditted.result + "</td>";
			}
			segment += "</table>";
			
			var totalPage = result.totalPage;
			var currentPage = result.currentPage;
			
			for(let n = 1 ; n<= totalPage; n++){
				
				var isCurrent = "";
				
				if(n == currentPage) isCurrent = "currentPage";
				
				var id = 'page' + n;
				
				segment += "<button onclick='audiPageClick(this)' class='audiPageNo " + isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
				
			}
		}
		
		auditted.html(segment);
		
	}
	
	function pendPageClick(e){
		var depart = $("#depart").val();
		var date = $("#date").val();
		var page = e.getAttribute("id");//page1
		
		callPending(page.substring(4,(page.length)),depart,date);
	}
	
	function audiPageClick(e){
		var depart = $("#depart").val();
		var date = $("#date").val();
		var page = e.getAttribute("id");
		
		callAutiditted(page.substring(4,(page.length)),depart,date);
	}
	

</script>
    
	
	

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>
<!-- header刪掉 End-->
	<div id="bgcolor" class="container-fluid h-75">
		<div class="">
			<div class="card shadow mb-4">
				<div class="card-body">
					
						<select  id="depart" >
						    <option value>請選擇部門</option>
						    <option value="行銷部門">行銷部門</option>
						    <option value="行政部門">行政部門</option>
						    <option value="業務部門">業務部門</option>
						</select>
						
						<select  id="date">
						    <option value>請選擇</option>
						    <option value="2021-05">2021-05</option>
						    <option value="2021-06">2021-06</option>
						    <option value="2021-07">2021-07</option>
						    <option value="2021-08">2021-08</option>
						    <option value="2021-09">2021-09</option>
						</select>
						
						<button id="search">搜尋</button>
						
							<div id="overtimepending" data-toggle='table' align=center ></div>
							<br><br>
							<div id="overtimeauditted" data-toggle='table' align=center ></div>
						
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