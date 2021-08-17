<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shift List</title>
<%-- <script src="<c:url value='/webjars/jquery/3.1.1-1/jquery.min.js' />"></script> --%>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<script>
	window.onload = function() {
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/schedule/shifts/findAll'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processShiftData(xhr.responseText);
			}
		}
	}

	function processShiftData(jsonString) {
		let shifts = JSON.parse(jsonString);
		let segment = "<table>";
		segment += "<tr><th colspan='6'>班別列表</th></tr>"
		segment += "<tr><th>班別編號</th><th>班別</th><th>開始時間</th><th>結束時間</th><th>時數</th><th>職務</th></tr>"
		segment += "<tr><td><input type='text' name='keyShift' id='keyShift'/></td>"+
				       "<td><input type='text' name='shift' id='shift'/></td>"+
				       "<td><input type='time' name='startTime' id='startTime' value='09:00' step='1800'/></td>"+
				   	   "<td><input type='time' name='endTime' id='endTime' value='00:00' step='1800' onchange='valueChanged(this.value)'/></td>"+
					   "<td><input type='text' name='hours' id='hours' readOnly/></td>"+
					   "<td><input type='text' name='position' id='position' /></td><td><button id='sendData' onclick='sendData(this.id)'>新增</button></td></tr>"
		for (let i = 0; i < shifts.length; i++) {
			let shift = shifts[i];
			segment += "<tr>";
			segment += "<td>" + shift.keyShift + "</td>";
			segment += "<td>" + shift.shift + "</td>";
			segment += "<td>" + shift.startTime + "</td>";
			segment += "<td>" + shift.endTime + "</td>";
			segment += "<td>" + shift.hours + "</td>";
			segment += "<td>" + shift.position + "</td>";
			segment += "<td></td></tr>"
		}
		segment += "</table>";
		return segment;
	}
	
	function valueChanged(endTime){
		var workHours = document.getElementById("hours");
		var startTime = document.getElementById("startTime").value;
		
		var eTime = new Date('endTime');
		var sTime = new Date('startTime');
		
		console.log(parseInt(eTime-sTime)/1000/60/60);
		workHours.innerHTML = parseInt(eTime-sTime)/1000/60/60;
// 		var date = new Date(endTime);
// 		date.setMinutes(date.getMinutes()-15);
// 		console.log(`realTime = ${date.getHours()}:${date.getMinutes()}`)
	}
	var sendData = document.getElementById("sendData");
function sendData(){
		hasError = false;
		var keyShift = document.getElementById("keyShift");
		var shift = document.getElementById("shift");
		var startTime = document.getElementById("startTime");
		var endTime = document.getElementById("endTime");
		var hours = document.getElementById("hours");
		var position = document.getElementById("position");
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST","<c:url value='/schedule/shifts/addShift'/>",true);
		var jsonShift = {
				"keyShift": keyShift,
				"shift": shift,
				"startTime": startTime,
				"endTime": endTime,
				"hours": hours,
				"position": position,
		}
		xhr1.setRequestHeader("Content-Type","application/json");
		xhr1.send(JSON.stringify(jsonShift));
		
		xhr1.onreadystatechange = function() {
			// 伺服器請求完成
		if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201) ) {
  		result = JSON.parse(xhr1.responseText);
  		if (result.fail) {
	 		alert("<font color='red' >"
				+ result.fail + "</font>");
  		} else if (result.success) {
  			dataArea.innerHTML = "<font color='GREEN'>"
				+ result.success + "</font>";
	}}}}
</script>
</head>
<body>
	<div id="dataArea"></div>
</body>
</html>