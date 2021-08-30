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
			background-color: #008F8F;
		}
		table{
			text-align: center;
		}
		.btn{
			margin-right: 5px;
			margin-top: 10px;
			margin-bottom: 10px;
		}

	</style>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    <script type="text/javascript">
    $(document).ready(function(){
		let dataArea = $('#managerCheck');
		let searchMonth =$('#date');
		searchMonth.html(getYearMonth());
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/findAllCheck'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200){
				
				dataArea.html(findAllCheck(xhr.response));
			}
		}
		
		$('#search').click(function(){
			
			var depName = $("#depName").val();
			var date = $("#date").val();
			
			callAjax(null,date,depName);
				
		});
		
		
	})
	
	function findAllCheck(jsonString){
    	let checksystemresult = JSON.parse(jsonString);
		let checksystems = checksystemresult.result;
		let segment = "<table border='1' class='table table-bordered' width='100%'>";
		segment += "<tr><th colspan='6'>員工打卡清單</th></tr>";
		segment += "<tr><th>員工編號</th><th>員工部門</th><th>上班打卡</th><th>下班打卡</th><th>是否遲到</th><th>是否準時</th><th>出勤時數</th>";
		for(let n = 0 ; n< checksystems.length; n++){
			let checksystem = checksystems[n];
			segment += "<tr>";
			segment += "<td>" + checksystem.empNo +"</td>";
			segment += "<td>" + checksystem.depName +"</td>";
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
		
		var totalPage = checksystemresult.totalPage;
		var currentPage = checksystemresult.currentPage;
		
		for(let n = 1 ; n<= totalPage; n++){
			
			var isCurrent = "";
			
			if(n == currentPage) isCurrent = "currentPage";
			
			var id = 'page' + n;
			
			segment += "<button onclick='pageClick(this)' class='pageNo " +'btn btn-outline-secondary '+ isCurrent +"'  id='" + id + "' " +">" + n + "</button>";
			
		}
		
		return segment;
	}
    
    function pageClick(e){
    	
    	var depName = $("#depName").val();
    	var date = $("#date").val();
    	var page = e.getAttribute("id");
    	
    	callAjax(page.substring(4,(page.length)),date,depName);
    }

    function callAjax(page,date,depName){
    	
    	depName = depName == '' ? null : depName;
    	date = date == '' ? null : date;
    	page = page == '' ? 1 : page;
    	
    	let managequery = $('#managerCheck');
    	let searchMonth =$('#date');
    	let xhr = new XMLHttpRequest();
    	xhr.open("GET","<c:url value='/findAllCheck'/>?date=" + date + "&pageNo=" + page +"&depName="+depName);
    	xhr.send();
    	xhr.onreadystatechange = function(){
    		if(xhr.readyState == 4 && xhr.status == 200){
    			managequery.html(findAllCheck(xhr.responseText));
    		}
    	}
    }
    
    
    function getYearMonth(){
    	var date = new Date();
    	var year = date.getFullYear();
    	let option = "<option value>請選擇</option>";
    	for (let n = 1 ; n<=12 ;n++){
    		if(n.toString().length == 1 ){
    			option += "<option value='"+year + "-"+"0"+ n +"'>"+year + "-"+"0"+ n +"</option>";
    		}else{
    			option += "<option value='"+year + "-"+ n +"'>"+year + "-"+ n +"</option>"; 
    		}
    		
    	}
    	return option;
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
					 <div>
						<select class="btn btn-outline-primary" id="date">
							<option value>請選擇月份</option>
						</select>
						<select  class="btn btn-outline-primary" id="depName" >
						    <option value>請選擇部門</option>
						    <option value="HR">HR</option>
						    <option value="RD">RD</option>
						    <option value="SALES">SALES</option>
						</select>
						
						<button id="search" class="btn btn-secondary">搜尋</button>
                             
                    </div>
				
					<div id='managerCheck' align='center' data-toggle="table" ></div>
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