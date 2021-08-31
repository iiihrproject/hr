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
	function offOrOn(obj){
		if($(obj).css("opacity")  === "1"){
			$(obj).css("opacity", "0.4");
		}
		else{
			$(obj).css("opacity", "1");
		}
	}
	window.onload = function(){
		$("#submit").click(function () {
			let inputRole = $("#inputRole").val();
			let inputPersonalIdNumber = $("#inputPersonalIdNumber").val();
			let inputName = $("#inputName").val();
			let inputGender = $(".inputGender:checked").val();
			if(typeof inputGender === "undefined"){
				inputGender = "";
			}
			let inputEmpNo = $("#inputEmpNo").val();
			let inputDepartmentNumber = $("#inputDepartmentNumber").val();
			let hr_manager = "";
			let hr = "";
			let rd_manager = "";
			let rd = "";
			let sales_manager = "";
			let sales = "";
			let production_manager = "";
			let production = "";
			let edittedLoginModel = {
				"role": inputRole,
				"personalIdNumber": inputPersonalIdNumber,
				"name": inputName,
				"gender": inputGender,
				"empNo": inputEmpNo,
				"departmentDetail": inputDepartmentNumber,
				"hr_manager": hr_manager,
				"hr": hr,
				"rd_manager": rd_manager,
				"rd": rd,
				"sales_manager": sales_manager,
				"sales": sales,
				"production_manager": production_manager,
				"production": production,
			};
			let authorities = $(".button");
			for(let i = 1; i <= authorities.length; i++){
				let id = $("#authorityButton button:nth-child(" + i + ")").attr('id');
				if($("#authorityButton button:nth-child(" + i + ")").css("opacity") === "1"){
					edittedLoginModel[id] = "true";
				}
				else{
					edittedLoginModel[id] = "false";
				}
			}
			//This I can send ajax to the backend
			let json = JSON.stringify(edittedLoginModel);
			console.log(json);
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "<c:url value='/createNewPersonnel'/>", true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");  		
			xhr.send(json);
    		xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let inputRole = $("#inputRole").val("");
					let inputPersonalIdNumber = $("#inputPersonalIdNumber").val("");
					let inputName = $("#inputName").val("");
					let inputGender = $(".inputGender").prop('checked', false);
					let inputEmpNo = $("#inputEmpNo").val("");
					let inputDepartmentNumber = $("#inputDepartmentNumber").val("");
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
							for(i = 0; i < tableInfo.length; i++){
								let id = "#" + tableInfo[i];
								$(id).css("opacity", "1");
							}
						}
		        	}
				}
        	}
		});
	}
	function insertManager(){
		let inputRole = $("#inputRole").val("PU MANAGER");
		let inputPersonalIdNumber = $("#inputPersonalIdNumber").val("G221364789");
		let inputName = $("#inputName").val("驚奇隊長");
		let inputGender = $("#female").prop('checked', true);
		let inputEmpNo = $("#inputEmpNo").val("pumanager");
		let inputDepartmentNumber = $("#inputDepartmentNumber").val("4");
	}
	function insertAgent(){
		let inputRole = $("#inputRole").val("PU");
		let inputPersonalIdNumber = $("#inputPersonalIdNumber").val("K111369859");
		let inputName = $("#inputName").val("奇異博士");
		let inputGender = $("#male").prop('checked', true);
		let inputEmpNo = $("#inputEmpNo").val("pu1");
		let inputDepartmentNumber = $("#inputDepartmentNumber").val("4");
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
				<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>
						<thead>
							<tr><th colspan='2'>員工資料</th><th>新增</th></tr>
						</thead>
						<tbody>
							<tr><td>職位</td><td id='role'></td><td><input type='text' id='inputRole'/></td></tr>
							<tr><td>身分證字號</td><td id='personalIdNumber'></td><td><input type='text' id='inputPersonalIdNumber'/></td></tr>
							<tr><td>姓名</td><td id='name'></td><td><input type='text' id='inputName'/></td></tr>
							<tr><td>性別</td><td id='gender'></td><td>
								<input type='radio' class='inputGender' name='gender' value='male' id='male'/>
								<label for='true'>男性</label>
								<input type='radio' class='inputGender' name='gender' value='female' id='female'/>
								<label for='false'>女性</label>
							</td></tr>
							<tr><td>員工編號</td><td id='empNo'></td><td><input type='text' id='inputEmpNo'/></td></tr>
							<tr><td>部門編號</td><td id='departmentNumber'></td><td><input type='text' id='inputDepartmentNumber'/></td></tr>
							<tr><td colspan='3'><div id='authorityButton'>
								<button id='hr_manager' onclick="offOrOn(this)" class='button'>人資主管</button>
								<button id='hr' onclick="offOrOn(this)" class='button'>人資員工</button>
								<button id='rd_manager' onclick="offOrOn(this)" class='button'>研發部門經理</button>
								<button id='rd' onclick="offOrOn(this)" class='button'>研發部門</button>
								<button id='salse_manager' onclick="offOrOn(this)" class='button'>業務部門經理</button>
								<button id='salse' onclick="offOrOn(this)" class='button'>業務部門</button>
								<button id='production_manager' onclick="offOrOn(this)" class='button'>生產部門經理</button>
								<button id='production' onclick="offOrOn(this)" class='button'>生產部門</button>
							</div></td></tr>
							<tr><td colspan='23'><button id='submit'>新增</button></td></tr>
							<tr><td><div><button onclick='insertManager()'>快速輸入主管</button><button onclick='insertAgent()'>快速輸入職員</button></div></td></tr>
						</tbody>
					</table>
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