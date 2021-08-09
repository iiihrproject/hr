<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員查詢系統</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		let dataArea = $('#dataArea');
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/findAllCheck'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200){
				
				dataArea.html(findAllCheck(xhr.response));
			}
		}
		
	})
	
	function findAllCheck(jsonString){
		let checksystems = JSON.parse(jsonString);
		let segment = "<table border='1'>";
		segment += "<tr><th colspan='6'>員工打卡清單</th></tr>";
		segment += "<tr><th>員工編號</th><th>上班打卡</th><th>下班打卡</th><th>是否遲到</th><th>是否準時</th><th>出勤時數</th>";
		for(let n = 0 ; n< checksystems.length; n++){
			let checksystem = checksystems[n];
			segment += "<tr>";
			segment += "<td>" + checksystem.empNo +"</td>";
			segment += "<td>" + checksystem.checkInTime +"</td>";
			segment += "<td>" + checksystem.checkOutTime +"</td>";
			
			var isLateCheckIn = checksystem.isLateCheckIn;
			var isOnTimeCheckOut = checksystem.isOnTimeCheckOut;
			
			if(isLateCheckIn = 'Y') isLateCheckIn = '是';
			else isLateCheckIn = '否';
			
			if(isOnTimeCheckOut ='Y') isOnTimeCheckOut = '是';
			else isOnTimeCheckOut = '否';
			
			segment += "<td>" + isLateCheckIn +"</td>";
			segment += "<td>" + isOnTimeCheckOut +"</td>";
			segment += "<td>" + checksystem.workingHours +"</td>";
			segment += "</tr>";
		}
		segment += "</table>";
		return segment;
	}
	


</script>

</head>
<body>
	<div id='dataArea' align='center'>

	</div>
</body>
</html>