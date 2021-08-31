<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <!-- complementSignForEmp css -->
    <link rel='stylesheet' href="<c:url value='/css/complementSignForEmp.css' />" type="text/css" />
    <!-- 載入 Bootstrap -->
	<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
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
	<script type="text/javascript">
	$(document).ready(function(){
		let pending = $('#overtimepending');
		let searchMonth =$('#date');
		searchMonth.html(getYearMonth());
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/empPendingQuery'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				pending.html(findEmpSignPending(xhr.response));
				
			}
		}
		
		let auditted = $('#overtimeauditted');
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET","<c:url value='/empAudittedQuery'/>");
		xhr1.send();
		xhr1.onreadystatechange = function(){
			if(xhr1.readyState == 4 && xhr1.status == 200){
				auditted.html(findEmpSignAuditted(xhr1.response));
			}
		}
		
		$('#search').click(function(){
			
			var date = $("#date").val();
			
			callPending(null,date);
			callAutiditted(null,date);
				
		});
		
		
		
		
	});
// 	再次呼叫以條件查詢兩個資料表
	function callPending(page,date){
			
			var url = "<c:url value='/empPendingQuery'/>";
			
// 			depart = depart == '' ? null : depart;
			date = date == '' ? null : date;
			page = page == '' ? 1 : page;
			
			let xhr = new XMLHttpRequest();
			xhr.open("GET","<c:url value='/empPendingQuery'/>?date=" + date + "&pageNo=" + page);
			xhr.send();
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					findEmpSignPending(xhr.response);
					
				}
			}
			
		}
	
	function callAutiditted(page,date){
			
			var url = "<c:url value='/empAudittedQuery'/>";
			
			date = date == '' ? null : date;
			page = page == '' ? 1 : page;
			
			let xhr1 = new XMLHttpRequest();
			xhr1.open("GET","<c:url value='/empAudittedQuery'/>?date=" + date + "&pageNo=" + page);
			xhr1.send();
			xhr1.onreadystatechange = function(){
				if(xhr1.readyState == 4 && xhr1.status == 200){
					findEmpSignAuditted(xhr1.response);
				}
			}
		}
// 查詢資料列印表格
	function findEmpSignPending(jsonString){
		
		let pending = $('#signpending');
		let pendingresult = JSON.parse(jsonString);
		let signpendings = pendingresult.result;
		let segment ="<table border='1'class='table table-bordered' >";
		
		if(signpendings != null){
			segment += "<tr><th colspan='6'>員工補簽查詢系統(待審核)</th></tr>";
			segment += "<tr><th>申請日期</th><th>員編</th><th>補簽日期</th><th>補簽時間</th><th>審核狀態</th><th>原由</th></tr>";
			
			for(let n = 0 ; n< signpendings.length; n++){
				let signpending = signpendings[n];
				segment += "<tr>";
				segment += "<td>"+ (signpending.date).substring(0,10) + "</td>";
				segment += "<td>"+ signpending.empNo + "</td>";
				segment += "<td>"+ (signpending.appliedDate).substring(0,10) + "</td>";
				segment += "<td>"+ (signpending.appliedDate).substring(11,16) + "</td>";
				segment += "<td>"+ signpending.status + "</td>";
				segment += "<td>"+ signpending.reason + "</td>";
			}
			segment += "</table>";
			
	 		var totalPage = pendingresult.totalPage;
	 		var currentPage = pendingresult.currentPage;
			
	 		for(let n = 1 ; n<= totalPage; n++){
				
	 			var isCurrent = "";
				
	 			if(n == currentPage) isCurrent = "currentPage";
				
	 			var id = 'page' + n;
				
	 			segment += "<button onclick='pendPageClick(this)' class='pendPageNo " + 'btn btn-outline-secondary '+ isCurrent + "'  id='" + id + "' " + ">" + n + "</button>";
				
	 		}
		}
		
		pending.html(segment);
		
	}


	function findEmpSignAuditted(jsonString){
		
		let auditted = $('#signauditted');
		let audittedresult = JSON.parse(jsonString);
		
		let signauditteds = audittedresult.result;
		let segment ="<table border='1'class='table table-bordered' >";
		if(signauditteds !== null){
			segment += "<tr><th colspan='6'>員工補簽查詢系統(已審核)</th></tr>";
			segment += "<tr><th>申請日期</th><th>員編</th><th>補簽日期</th><th>補簽時間</th><th>審核狀態</th><th>原由</th></tr>";
			for(let n = 0 ; n< signauditteds.length; n++){
				let signauditted = signauditteds[n];
				segment += "<tr>";
				segment += "<td>"+ (signauditted.date).substring(0,10) + "</td>";
				segment += "<td>"+ signauditted.empNo + "</td>";
				segment += "<td>"+ (signauditted.appliedDate).substring(0,10) + "</td>";
				segment += "<td>"+ (signauditted.appliedDate).substring(11,16) + "</td>";
				segment += "<td>"+ signauditted.status + "</td>";
				segment += "<td>"+ signauditted.reason + "</td>";
			}
			segment += "</table>";
			
			var totalPage = audittedresult.totalPage;
			var currentPage = audittedresult.currentPage;
			
			for(let n = 1 ; n<= totalPage; n++){
				
				var isCurrent = "";
				
				if(n == currentPage) isCurrent = "currentPage";
				
				var id = 'page' + n;
				
				segment += "<button onclick='audiPageClick(this)' class='audiPageNo " + 'btn btn-outline-secondary '+ isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
				
			}
			
		}
		
		auditted.html(segment);
		
	}
	
	function pendPageClick(e){
		var date = $("#date").val();
		var page = e.getAttribute("id");//page1
		
		callPending(page.substring(4,(page.length)),date);
	}
	
	function audiPageClick(e){
		var date = $("#date").val();
		var page = e.getAttribute("id");
		
		callAutiditted(page.substring(4,(page.length)),date);
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

<body id="page-top" >

    <jsp:include page="../header.jsp"></jsp:include>
    
                <!-- header刪掉 End-->
                
             <div id="bgcolor" class="container-fluid h-80">
             	<div class="row">
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Revisit query</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
                                            <a href="<c:url value='/EmpSignQuery' />" class="text-decoration-none">補簽查詢</a></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-primary"></i>
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
                                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                Overtime query</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
                                            <a href="<c:url value='/employeeQuery' />" class="text-decoration-none">加班查詢</a></div>
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
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Leave query</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
                                            <a href="<c:url value='/checkInto' />" class="text-decoration-none">請假查詢</a></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-power-off fa-3x text-warning"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
				<div class="">
					<div class="card shadow mb-4">
						<div class="card-body">
							<select  id="date" class="btn btn-outline-primary">
								<option value>請選擇月份</option>
							</select>
							
							<button id="search" class="btn btn-secondary">搜尋</button>
							
							<div id="signpending" data-toggle='table' align=center ></div>
							<br><br>
							<div id="signauditted" data-toggle='table' align=center ></div>
							
						</div>
					 </div>
				</div>

			</div>
                    
             <!-- /.container-fluid -->

	
			<!-- End of Main Content -->       
             			

            <jsp:include page="../footer.jsp"></jsp:include>
            
            <!-- footer刪掉 start -->

               

            

    <!-- footer刪掉 end -->

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