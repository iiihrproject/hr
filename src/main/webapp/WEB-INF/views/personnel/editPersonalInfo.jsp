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
    		let phoneNumber = $("#phoneNumber");
    		let email = $("#email");
    		let address = $("#address");
    		let submit = $("#submit");
    		let xhr = new XMLHttpRequest();
    		xhr.open("GET", "<c:url value='/personalInformation'/>", true);
    		xhr.send();	
			xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {	
						let personnel = JSON.parse(xhr.responseText);
						phoneNumber.text(personnel.phoneNumber);
						email.text(personnel.email);
						address.text(personnel.address);
					}
        		
        	}
			  
			submit.click(function(){
				phoneNumberInput = $("#phoneNumberInput").val();
				emailInput = $("#emailInput").val();
				addressInput = $("#addressInput").val();
				
				let obj = {
	    				'phoneNumber': phoneNumberInput,	
	    				'email': emailInput,	
	    				'address': addressInput,	
	    			}
	    		let json = JSON.stringify(obj);		
	    		let xhrInner = new XMLHttpRequest();
	    		xhrInner.open("PUT", "<c:url value='/personalInformationUpdate'/>", true);		
	    		xhrInner.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	    		
	    		xhrInner.send(json);	
	    		xhrInner.onreadystatechange = function() {
						if (xhrInner.readyState == 4 && xhrInner.status == 200) {	
							let personnel = JSON.parse(xhrInner.responseText);
							phoneNumber.text(personnel.phoneNumber);
							email.text(personnel.email);
							address.text(personnel.address);
							document.querySelector("#phoneNumberInput").value = "";
							document.querySelector("#emailInput").value = "";
							document.querySelector("#addressInput").value = "";
							alert(personnel.result);
						}
	    		}
				
			});
		}

    		

    </script>


</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

	<div id="bgcolor" class="container-fluid">
		<div class="row">
			<div class="col-12">
			<!-- form start -->        
            	<table border='solid' witdh='1' class="table table-bordered table-hover table-hover-color dataTable no-footer">
            	<thead>
            		<tr height='50px'><th>欄位</th><th>現有資料</th><th>修改</th></tr>
            	</thead>
            	<tbody>
            		<tr height='50px'><td>電話</td><td id="phoneNumber"></td><td><input type='text' id="phoneNumberInput"></input></td></tr>
            		<tr height='50px'><td>Email</td><td id="email"></td><td><input type='text' id="emailInput"></input></td></tr>
            		<tr height='50px'><td>住址</td><td id="address"></td><td><input type='text' id="addressInput"></input></td></tr>
            		<tr height='50px'><td colspan='3' align='center'><button id="submit">送出</button></td></tr>
            	</tbody>
            	</table>
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