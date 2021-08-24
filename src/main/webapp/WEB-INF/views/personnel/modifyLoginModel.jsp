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
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    
	<script>
	window.onload = function(){
		$("#search").click(function () {
			let inputEmpNo = $("#inputEmpNo").val();
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "<c:url value='/searchLoginModel' />", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("inputEmpNo=" + inputEmpNo);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let tableInfo = JSON.parse(xhr.responseText);
					for(const key in tableInfo){
						let id = "#" + key;
						if(key === "result"){
							alert(tableInfo[key]);
							return;
						}
						document.querySelector(id).innerHTML = tableInfo[key];
					}
 					$(".button").css("opacity", "0.4");
	        		let innerxhr = new XMLHttpRequest();
					innerxhr.open("POST", "<c:url value='/findAuthorities' />", true);
					innerxhr.send();
					innerxhr.onreadystatechange = function() {
						if (innerxhr.readyState == 4 && innerxhr.status == 200) {
							let tableInfo = JSON.parse(innerxhr.responseText);
							console.log(tableInfo);
							
							for(i = 0; i < tableInfo.length; i++){
								let id = "#" + tableInfo[i];
								$(id).css("opacity", "1");
							}
						}
		        	}
				}
			}
		});
		
		$("#submit").click(function () {
			let inputRole = $("#inputRole").val();
			let inputName = $("#inputName").val();
			let inputDepartmentNumber = $("#inputDepartmentNumber").val();
			let inputIsEnable = $("#inputIsEnable").val();
			let admin = "";
			let hr = "";
			let manager = "";
			let general = "";
			if($("#admin").css("opacity") === 1){
				admin = admin
			}
			let edittedLoginModel = {
				"role": inputRole,
				"name": inputName,
				"departmentDetail": inputDepartmentNumber,
				"isEnable": inputIsEnable
			};
			let xhr = new XMLHttpRequest();
			let json = JSON.stringify(edittedLoginModel);
			xhr.open("POST", "<c:url value='/modify' />", true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xhr.send(json);
			inputRole = $("#inputRole").val() = "";
			inputName = $("#inputName").val() = "";
			inputDepartmentNumber = $("#inputDepartmentNumber").val() = "";
			inputIsEnable = $("#inputIsEnable").val() = "";
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let tableInfo = JSON.parse(xhr.responseText);
					for(const key in tableInfo){
						let id = "#" + key;
						if(key === "result"){
							alert(tableInfo[key]);
							return;
						}
						document.querySelector(id).innerHTML = tableInfo[key];
					}
				}
        	}
			
		});
	}
	function offOrOn(obj){
		if($(obj).css("opacity")  === 1){
			$(obj).css("opacity", "0.4");
		}
		else{
			$(obj).css("opacity", "1");
		}
	}
	</script>
	<style>
		.button{
			opacity: 0.4;
			background-color: #7878FF;
		}
	</style>
</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

	<div id="bgcolor" class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div>
	            	<h4>請輸入欲查詢的員工編號</h4>
	            	<input type="text" id="inputEmpNo" maxlength="20"/><button id='search'>送出</button>
	            </div>
	            <div>
	            	<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>
						<thead>
							<tr><th colspan='2'>員工資料</th><th>修改</th></tr>
						</thead>
						<tbody>
							<tr><td>職位</td><td id='role'></td><td><input type='text' id='inputRole'/></td></tr>
							<tr><td>姓名</td><td id='name'></td><td><input type='text' id='inputName'/></td></tr>
							<tr><td>部門編號</td><td id='departmentNumber'></td><td><input type='text' id='inputDepartmentNumber'/></td></tr>
							<tr><td>部門名稱</td><td id='departmentName'></td><td>不可在此更動</td></tr>
							<tr><td>在職狀態</td><td id='isEnable'></td><td><input type='text' id='inputIsEnable'/></td></tr>
							<tr><td colspan='3'><div id='authorityButton'>
								<button id='admin' onclick="offOrOn(this)" class='button'>管理員</button>
								<button id='hr' onclick="offOrOn(this)" class='button'>人資員工</button>
								<button id='manager' onclick="offOrOn(this)" class='button'>部門經理</button>
								<button id='general' onclick="offOrOn(this)" class='button'>一般員工</button>
<!-- 								  -->
							</div></td></tr>
							<tr><td colspan='3'><button id='submit'>修改</button></td>
						</tbody>
					</table>
					
	            </div>        
	            <div id="result">
	            </div>
			</div>

		</div>

	</div>
	<!-- /.container-fluid -->

	</div>
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