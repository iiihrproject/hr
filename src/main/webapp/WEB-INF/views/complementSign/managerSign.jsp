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
<!-- 載入 Bootstrap -->
<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">

<!--引用SweetAlert2.css-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />

<!--引用SweetAlert2.js-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<!-- .js請從此後寫 -->
<script type="text/javascript">
$(document).ready(function(){
	let managequery = $('#managerSignQuery');
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/ManagerSignQuery'/>");
	xhr.send();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			managequery.html(manageQuerySign(xhr.responseText));
		}
	}
	
})


function manageQuerySign(jsonString){
	let managequerysigns = JSON.parse(jsonString);
	let segment ="<table border='1' class='table table-bordered'>";
	segment += "<tr><th colspan='7'>管理員審核系統</th></tr>";
	segment += "<tr><th>申請日期</th><th>姓名</th><th>補簽日期</th><th>補簽時間</th><th>審核狀態</th><th>原由</th></tr>";
	for(let n = 0 ; n< managequerysigns.length; n++){
		let managequerysign = managequerysigns[n];
		var passid = 'pass' + managequerysign.serialNumber;
		segment += "<tr>";
		segment += "<td>"+ (managequerysign.date).substring(0,10) + "</td>";
		segment += "<td>"+ managequerysign.empName + "</td>";
		segment += "<td>"+ (managequerysign.appliedDate).substring(0,10) + "</td>";
		segment += "<td>"+ (managequerysign.appliedDate).substring(11,16) + "</td>";
		segment += "<td>"+ managequerysign.status + "</td>";
		segment += "<td>"+ managequerysign.reason + "</td>";
		segment += "<td>"+"<button type='button' onclick='passAnDdenyClick(this)' id='" + passid + "' class='btn btn-primary btn-lg b1' value='Pass'>"+"Pass"+"</button>"+" ";
		segment += "<button type='button' onclick='passAnDdenyClick(this)' id='" + passid + "' class='btn btn-primary btn-lg b2' value='Deny'>"+"Deny"+"</button>"+"</td>";
	}
	segment += "</table>";
	return segment;
}

function passAnDdenyClick(e){
	var pass = e.getAttribute('id');
	var passnum = pass.substring(4,(pass.length))
	var type = e.getAttribute('value');
	if (type === "Pass"){
		swal({
	        title: "審核確定通過嗎?",
	        html: "請再次確認!",
	        type: "question",
	        confirmButtonText: "確定",
	      	cancelButtonText: "取消",
	        showCancelButton: true//顯示取消按鈕
	    }).then(function (result) {
	        if (result.value) {
	            //使用者按下「確定」要做的事
	        	
	        	alert(type)
	        	let xhr1 = new XMLHttpRequest();
	        	xhr1.open("POST","<c:url value='/ManagerSignAudit'/>");
	        	xhr1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	        	xhr1.send("id=" + passnum + "&type=" + type);
	        	xhr1.onreadystatechange = function(){
	        		if(xhr1.readyState == 4 && xhr1.status == 200){
	        			swal("Thank!", "完成審核", "success");
	        			refresh();
	        		}
	        	}
	     } else if (result.dismiss === "cancel"){
	          //使用者按下「取消」要做的事
	         swal("取消審核", "尚未審核該筆資料", "error");
	     }//end else  
	  });//end then 	
	}else{
	swal({
        title: "是否確定退件?",
        html: "請再次確認!",
        type: "question",
        confirmButtonText: "確定",
      	cancelButtonText: "取消",
        showCancelButton: true//顯示取消按鈕
    }).then(function (result) {
        if (result.value) {
            //使用者按下「確定」要做的事
        	
        	alert(type)
        	let xhr1 = new XMLHttpRequest();
        	xhr1.open("POST","<c:url value='/ManagerSignAudit'/>");
        	xhr1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        	xhr1.send("id=" + passnum + "&type=" + type);
        	xhr1.onreadystatechange = function(){
        		if(xhr1.readyState == 4 && xhr1.status == 200){
        			swal("Thank!", "完成審核", "success");
        			refresh();
        		}
        	}
     } else if (result.dismiss === "cancel"){
          //使用者按下「取消」要做的事
         swal("取消審核", "尚未審核該筆資料", "error");
     }//end else  
  });//end then 	
	}
}


</script>

</head>

<body id="page-top" >

    <jsp:include page="../header.jsp"></jsp:include>
    
    <!-- header刪掉 start-->

    

                <!-- header刪掉 End-->
                
             <div id="bgcolor" class="container-fluid">
				<div class="">
					<div class="card shadow mb-4">
						<div class="card-body">
								
							<div id="managerSignQuery" data-toggle='table' align=center ></div>
								
						</div>
					 </div>
				</div>

			</div>
                    
                    
             			

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