<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
$(document).ready(function(){
	let pending = $('#overtimepending');
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/empPendoingQuery'/>");
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
	
	
	
	
});

function findEmpSignPending(jsonString){
	
	let pending = $('#signpending');
	
	let result = JSON.parse(jsonString);
	let signpendings = result.result;
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
		
// 		var totalPage = result.totalPage;
// 		var currentPage = result.currentPage;
		
// 		for(let n = 1 ; n<= totalPage; n++){
			
// 			var isCurrent = "";
			
// 			if(n == currentPage) isCurrent = "currentPage";
			
// 			var id = 'page' + n;
			
// 			segment += "<button onclick='pendPageClick(this)' class='pendPageNo " + isCurrent + "'  id='" + id + "' " + ">" + n + "</button>";
			
// 		}
	}
	
	pending.html(segment);
	
}


function findEmpSignAuditted(jsonString){
	
	let auditted = $('#signauditted');
	
	let result = JSON.parse(jsonString);
	
	let signauditteds = result.result;
	let segment ="<table border='1'class='table table-bordered' >";
	if(signauditteds !== null){
		segment += "<tr><th colspan='6'>員工加班查詢系統(已審核)</th></tr>";
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
// 		segment += "</table>";
		
// 		var totalPage = result.totalPage;
// 		var currentPage = result.currentPage;
		
// 		for(let n = 1 ; n<= totalPage; n++){
			
// 			var isCurrent = "";
			
// 			if(n == currentPage) isCurrent = "currentPage";
			
// 			var id = 'page' + n;
			
// 			segment += "<button onclick='audiPageClick(this)' class='audiPageNo " + isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
			
// 		}
	}
	
	auditted.html(segment);
	
}

</script>

</head>
<body>

</body>
</html>