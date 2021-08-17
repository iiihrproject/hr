<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員審核系統</title>
<!-- 引入bootstrap css  and table -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">
<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css">
<!-- <!-- 載入jquery --> -->
<script src="js/jquery-3.6.0.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script> -->
<!-- 引入bootstrap js  and table -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
<!--引用SweetAlert2.css-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />

<!--引用SweetAlert2.js-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>


<script type="text/javascript">
$(document).ready(function(){
	let managequery = $('#managequery');
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/manageQuery'/>");
	xhr.send();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			managequery.html(managequeryPending(xhr.responseText));
		}
	}
	
	$('#pass').click(function(){
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

	        	let managequerys = JSON.parse(jsonString);
	        	let id = managequerys[n];
	        	let type = $(this).val;
	        	let xhr1 = new XMLHttpRequest();
	        	xhr1.open("POST","<c:url value='/manageAudit'/>");
	        	xhr1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	        	xhr1.send("id=" + id.id & "type" + type);
	        	xhr1.onreadystatechange = function(){
	        		if(xhr1.readyState == 4 && xhr1.status == 200){
	        			swal("Thank!", "完成審核", "success");
	        		}
	        	}
	     } else if (result.dismiss === "cancel"){
	          //使用者按下「取消」要做的事
	         swal("取消審核", "尚未審核該筆資料", "error");
	     }//end else  
	  });//end then 	
		})
	

	$('#deny').click(function(){
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

	        	let managequerys2 = JSON.parse(jsonString);
	        	let id2 = managequerys[n];
	        	let type2 = $(this).val;
	        	let xhr2 = new XMLHttpRequest();
	        	xhr2.open("POST","<c:url value='/manageAudit'/>");
	        	xhr2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	        	xhr2.send("id=" + id2.id & "type" + type2);
	        	xhr2.onreadystatechange = function(){
	        		if(xhr2.readyState == 4 && xhr2.status == 200){
	        			swal("Thank!", "完成審核", "success");
	        		}
	        	}
	     } else if (result.dismiss === "cancel"){
	          //使用者按下「取消」要做的事
	         swal("取消審核", "尚未審核該筆資料", "error");
	     }//end else  
	  });//end then 	
	})
	
// 	let managequerys = JSON.parse(jsonString);
// 	let id = managequerys[n];
// 	let type = $(this).val;
// 	let xhr1 = new XMLHttpRequest();
// 	xhr.open("POST","<c:url value='/manageQuery'/>");
// 	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
// 	xhr.send("id=" + id.id & "type" + type);
// 	xhr.onreadystatechange = function(){
// 		if(xhr.readyState == 4 && xhr.status == 200){
			
// 		}
// 	}
});

function managequeryPending(jsonString){
	let managequerys = JSON.parse(jsonString);
	let segment ="<table border='1' >";
	segment += "<tr><th colspan='11'>管理員審核系統</th></tr>";
	segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>加班原因</th><th>審核狀態</th>";
	for(let n = 0 ; n< managequerys.length; n++){
		let managequery = managequerys[n];
		segment += "<tr>";
		segment += "<td>"+ managequery.dateOfApplication + "</td>";
		segment += "<td>"+ managequery.empName + "</td>";
		segment += "<td>"+ managequery.department + "</td>";
		segment += "<td>"+ managequery.position + "</td>";
		segment += "<td>"+ managequery.overtimeCategory + "</td>";
		segment += "<td>"+ managequery.overTimeDate + "</td>";
		segment += "<td>"+ managequery.startingTime + "</td>";
		segment += "<td>"+ managequery.endingTime + "</td>";
		segment += "<td>"+ managequery.overTimeHours + "</td>";
		segment += "<td>"+ managequery.reason + "</td>";
		segment += "<td>"+ managequery.result + "</td>";
		segment += "<td>"+"<button type='button' id='pass' class='btn btn-primary btn-lg b1'>"+"Pass"+"</button>"+" "+"<button type='button' id='deny' class='btn btn-primary btn-lg b1'>"+"Deny"+"</button>"+"</td>";
	}
	segment += "</table>";
	return segment;
	


	
	
	
}


</script>


</head>
<body>
<div id="managequery" data-toggle='table' align=center ></div>
</body>
</html>