<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.3/dist/bootstrap-table.min.css">
<!-- 載入 Jquery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table.min.js"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.3/dist/locale/bootstrap-table-zh-TW.min.js"></script>

<style type="text/css">
	.currentPage{
		background-color: green;
	}
	table{
		text-align: center;
	}

</style>


<script>
$(document).ready(function(){
	let pending = $('#overtimepending');
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/findEmpOvertime'/>");
	xhr.send();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			pending.html(findEmpOvertimePending(xhr.response));
			
		}
	}
	
	let auditted = $('#overtimeauditted');
	let xhr1 = new XMLHttpRequest();
	xhr1.open("GET","<c:url value='/findEmpOvertime2'/>");
	xhr1.send();
	xhr1.onreadystatechange = function(){
		if(xhr1.readyState == 4 && xhr1.status == 200){
			auditted.html(findEmpOvertimeAuditted(xhr1.response));
		}
	}
	
	$('#search').click(function(){
		
		var depart = $("#depart").val();
		var date = $("#date").val();
		
		callPending(null,depart,date);
		callAutiditted(null,depart,date);
			
	});
	
// 	$('.pendPageNo').click(function(){
		
// 		alert("click")
		
// 		var page = this.id;
// 		var depart = $("#depart").val();
// 		var date = $("#date").val();
		
// 		callPending(page.substring(4),depart,date);
		
// 	})
	
	
// 	$('.audiPageNo').click(function(){
		
// 		var page = this.id;
// 		var depart = $("#depart").val();
// 		var date = $("#date").val();
		
// 		callAutiditted(page.substring(4),depart,date);
// 	})
	
	
	
});
	function callPending(page,depart,date){
		
		var url = "<c:url value='/findEmpOvertime'/>";
		
		depart = depart == '' ? null : depart;
		date = date == '' ? null : date;
		page = page == '' ? 1 : page;
		
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/findEmpOvertime'/>?depart=" + depart + "&date=" + date + "&pageNo=" + page);
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				findEmpOvertimePending(xhr.response);
				
			}
		}
		
	}
	
	
	function callAutiditted(page,depart,date){
		
		var url = "<c:url value='/findEmpOvertime'/>";
		
		depart = depart == '' ? null : depart;
		date = date == '' ? null : date;
		page = page == '' ? 1 : page;
		
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET","<c:url value='/findEmpOvertime2'/>?depart=" + depart + "&date=" + date + "&pageNo=" + page);
		xhr1.send();
		xhr1.onreadystatechange = function(){
			if(xhr1.readyState == 4 && xhr1.status == 200){
				findEmpOvertimeAuditted(xhr1.response);
			}
		}
	}
	
	
	function findEmpOvertimePending(jsonString){
		
		let pending = $('#overtimepending');
		
		let result = JSON.parse(jsonString);
		let overtimependings = result.result;
		let segment ="<table border='1' >";
		
		if(overtimependings != null){
			segment += "<tr><th colspan='10'>員工加班查詢系統</th></tr>";
			segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>審核狀態</th>";
			
			for(let n = 0 ; n< overtimependings.length; n++){
				let overtimepending = overtimependings[n];
				segment += "<tr>";
				segment += "<td>"+ overtimepending.dateOfApplication + "</td>";
				segment += "<td>"+ overtimepending.empName + "</td>";
				segment += "<td>"+ overtimepending.department + "</td>";
				segment += "<td>"+ overtimepending.position + "</td>";
				segment += "<td>"+ overtimepending.overtimeCategory + "</td>";
				segment += "<td>"+ overtimepending.overTimeDate + "</td>";
				segment += "<td>"+ overtimepending.startingTime + "</td>";
				segment += "<td>"+ overtimepending.endingTime + "</td>";
				segment += "<td>"+ overtimepending.overTimeHours + "</td>";
				segment += "<td>"+ overtimepending.result + "</td>";
			}
			segment += "</table>";
			
			var totalPage = result.totalPage;
			var currentPage = result.currentPage;
			
			for(let n = 1 ; n<= totalPage; n++){
				
				var isCurrent = "";
				
				if(n == currentPage) isCurrent = "currentPage";
				
				var id = 'page' + n;
				
				segment += "<button onclick='pendPageClick(this)' class='pendPageNo " + isCurrent + "'  id='" + id + "' " + ">" + n + "</button>";
				
			}
		}
		
		pending.html(segment);
		
	}
	
	function findEmpOvertimeAuditted(jsonString){
		
		let auditted = $('#overtimeauditted');
		
		let result = JSON.parse(jsonString);
		
		let overtimeauditteds = result.result;
		let segment ="<table border='1' >";
		
		if(overtimeauditteds != null){
			segment += "<tr><th colspan='10'>員工加班查詢系統</th></tr>";
			segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>審核狀態</th>";
			for(let n = 0 ; n< overtimeauditteds.length; n++){
				let overtimeauditted = overtimeauditteds[n];
				segment += "<tr>";
				segment += "<td>"+ overtimeauditted.dateOfApplication + "</td>";
				segment += "<td>"+ overtimeauditted.empName + "</td>";
				segment += "<td>"+ overtimeauditted.department + "</td>";
				segment += "<td>"+ overtimeauditted.position + "</td>";
				segment += "<td>"+ overtimeauditted.overtimeCategory + "</td>";
				segment += "<td>"+ overtimeauditted.overTimeDate + "</td>";
				segment += "<td>"+ overtimeauditted.startingTime + "</td>";
				segment += "<td>"+ overtimeauditted.endingTime + "</td>";
				segment += "<td>"+ overtimeauditted.overTimeHours + "</td>";
				segment += "<td>"+ overtimeauditted.result + "</td>";
			}
			segment += "</table>";
			
			var totalPage = result.totalPage;
			var currentPage = result.currentPage;
			
			for(let n = 1 ; n<= totalPage; n++){
				
				var isCurrent = "";
				
				if(n == currentPage) isCurrent = "currentPage";
				
				var id = 'page' + n;
				
				segment += "<button onclick='audiPageClick(this)' class='audiPageNo " + isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
				
			}
		}
		
		auditted.html(segment);
		
	}
	
	function pendPageClick(e){
		var depart = $("#depart").val();
		var date = $("#date").val();
		var page = e.getAttribute("id");//page1
		
		callPending(page.substring(4,(page.length)),depart,date);
	}
	
	function audiPageClick(e){
		var depart = $("#depart").val();
		var date = $("#date").val();
		var page = e.getAttribute("id");
		
		callAutiditted(page.substring(4,(page.length)),depart,date);
	}
	

</script>



<title>員工加班查詢系統</title>
</head>
<body>

<div align=center>
<select  id="depart" >
    <option value>請選擇部門</option>
    <option value="行銷部門">行銷部門</option>
    <option value="行政部門">行政部門</option>
    <option value="業務部門">業務部門</option>
</select>

<select  id="date">
    <option value>請選擇</option>
    <option value="2021-05">2021-05</option>
    <option value="2021-06">2021-06</option>
    <option value="2021-07">2021-07</option>
    <option value="2021-08">2021-08</option>
    <option value="2021-09">2021-09</option>
</select>

<button id="search">搜尋</button>

<div id="overtimepending" data-toggle='table' align=center ></div>
<br><br>
<div id="overtimeauditted" data-toggle='table' align=center ></div>
</div>



</body>
</html>