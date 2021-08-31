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
    	let i = 0;
    	let idController = 0;
    	let name = {};
    	let managerId = {}
    	let departments = {};
    	let json = "";
    	let segment = "";
		function add(){
			i++;
			segment += "<tr><td><input type='text' id='departmentName" + i + "' onchange='onChange()'></td><td><input type='text' id='managerEmpNo" + i + "' onchange='onChange()'></td></tr>";
			$("#tBody").html(segment);
			for(l = 1; l <= i; l++){

				if(typeof name[l] === "undefined" || name[l] === null){
					document.querySelector("#departmentName" + l).value = "";
				}
				else{
					document.querySelector("#departmentName" + l).value = name[l];
				}
				
				if(typeof managerId[l] === "undefined" || managerId[l] === null){
					document.querySelector("#managerEmpNo" + l).value = "";
				}
				else{
					document.querySelector("#managerEmpNo" + l).value = managerId[l];
				}
			}
		}
		
		function onChange(){
			for(k = 1; k <= i; k++){
				name[k] = document.querySelector("#departmentName" + k).value
				managerId[k] = document.querySelector("#managerEmpNo" + k).value
			}
		}
		
		function submit(){
			for(j = 1; j <= i; j++){
				let departmentName = document.getElementById('departmentName' + j).value;
				let managerEmpNo = document.getElementById('managerEmpNo' + j).value;
				if(!(departmentName == "" || managerEmpNo == "")){
					const temp ={
						"name": departmentName,
						"managerEmpNo": managerEmpNo
					};
					if(!(j in departments)){
						departments[j] = temp;
					}
				}
			}
			json = JSON.stringify(departments);
			departments = {};
			$("#tBody").children().remove();
			segment = "";
			
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "<c:url value='/createNewDepartment'/>", true);
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");  		
			xhr.send(json);
			i = 0;
    		managerId = {};
    		name = {};
    		xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let result = JSON.parse(xhr.responseText);
					alert(result.result);
				}
        	}
		}
	</script>

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

	<div id="bgcolor" class="container-fluid h-75">
		<div class="row">
			<div class="col-12">
			<!-- form start -->        
						<table id="table" class="table table-bordered table-hover table-hover-color dataTable no-footer">
							<thead>
								<tr>
									<th>部門名稱</th><th>部門主管員工編號</th>
								</tr>
							</thead>
							<tbody id="tBody">
							</tbody>
							<tfoot>
								<tr>
									<th colspan="2"><button onclick="add()">新增欄位</button></th>	
								</tr>
								<tr>
									<th colspan="2"><button onclick="submit()">送出</button></th>
								</tr>
							</tfoot>
						</table>
                </div>
					<!-- form end -->  
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