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
    		//let submit = $("#edit");
    		let segment="";
    		let xhr = new XMLHttpRequest();
    		xhr.open("GET", "<c:url value='/departmentDetail'/>", true);
    		xhr.send();	
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let tableInfo = JSON.parse(xhr.responseText);

					for(const key in tableInfo){
						segment += "<tr><td id='departmentNumberKey" + key + "'>" + tableInfo[key].departmentNumber + "</td><td>" + tableInfo[key].name + "</td><td><input type='text' maxlength='15'id='departmentNameKey" + key + "'</td><td>" + tableInfo[key].managerEmpNo + "</td><td >" + tableInfo[key].managerName + "</td><td><input type='text' maxlength='15' id='managerEmpNoKey" + key + "'/></td><td><button onclick='edit(" + key + ")'>確認</button></td></tr>";
					}
					$("#tablediv").html(segment);
				}
        	}
		}
		/*
		This responds the change immediately solidly without doublechecking
		*/
		function edit(key){
			let departmentNumber = document.getElementById("departmentNumberKey" + key).innerHTML;
			let newdepartmentName = document.getElementById("departmentNameKey" + key).value;
			let newManagerNo = document.getElementById("managerEmpNoKey" + key).value;
			let newSegment="";
			let obj = {
    				'departmentNumber': departmentNumber,	
    				'name': newdepartmentName,	
    				'managerEmpNo': newManagerNo
    			}
    		let json = JSON.stringify(obj);
			let xhrInner = new XMLHttpRequest();
			xhrInner.open("PUT", "<c:url value='/departmentManagerNoUpdate'/>", true);
			xhrInner.setRequestHeader("Content-Type", "application/json;charset=UTF-8"); 		
    		xhrInner.send(json);
    		xhrInner.onreadystatechange = function() {
				if (xhrInner.readyState == 4 && xhrInner.status == 200) {	
					let tableInfo = JSON.parse(xhrInner.responseText);
					
					for(const key in tableInfo){
						newSegment += "<tr><td id='departmentNumberKey" + key + "'>" + tableInfo[key].departmentNumber + "</td><td>" + tableInfo[key].name + "</td><td><input type='text' maxlength='15'id='departmentNameKey" + key + "'</td><td>" + tableInfo[key].managerEmpNo + "</td><td >" + tableInfo[key].managerName + "</td><td><input type='text' maxlength='15' id='managerEmpNoKey" + key + "'/></td><td><button onclick='edit(" + key + ")'>確認</button></td></tr>";
					}					
					$("#tablediv").html(newSegment);
				}
        	}
		}
		

    </script>

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

	<div id="bgcolor" class="container-fluid">
		<div class="row">
			<div class="col-12">
 <!-- form start -->        
				<span>
					<a href="<c:url value='/addNewDepartment'/>">
						<button>新增部門連結</button>
					</a>
				</span>            
				<div>
					<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>
						<thead>
							<tr><th>部門編號</th><th>部門名稱</th><th>更換部門名稱(請輸新名稱)</th><th>部門主管編號</th><th>部門主管名稱</th><th>更換部門主管(請輸入員工編號)</th><th>確認修改</th></tr>
						</thead>
						<tbody  id='tablediv'>
						</tbody>
					</table>
				</div>
<!-- form end -->  
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