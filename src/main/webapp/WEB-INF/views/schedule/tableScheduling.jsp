<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Scheduling</title>
<script>
	window.onload = function() {
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/schedule/schedulingAjax'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processScheduleData(xhr.responseText);
			}
		}

	}

	function processScheduleData(jsonString) {
		let schedule = JSON.parse(jsonString);
		console.log(schedule);
		let segment = "<table>";
		segment += "<tr><th colspan='6'>班表</th></tr>"
		segment += "<tr><th>人員</th><th>開始</th><th>結束</th><th>職務</th></tr>"
		segment += "<tr><td><input type='text' name='empno' id='empno' onfocus='setToday (this.id)'/></td>"
				+ "<td><input type='datetime-local' name='start' id='start' onchange='setEnd (this.id)'/></td>"
				+ "<td><input type='datetime-local' name='end' id='end'/></td>"
				+ "<td><input type='text' name='title' id='title'/></td><td><button id='sendData' onclick='sendForm'>新增</button></td></tr>"

		for (let i = 0; i < schedule.length; i++) {
			let sche = schedule[i];
			segment += "<tr>";
			segment += "<td>" + sche.empNo + "</td>";
			segment += "<td>" + sche.start + "</td>";
			segment += "<td>" + sche.end + "</td>";
			segment += "<td>" + sche.title + "</td>";
			segment += "<td></td></tr>"
		}
		segment += "</table>";
		return segment;
	} //end of processScheduleData;

	function setToday() {
		const d = new Date();
		let today = d.toISOString().substring(0, 19);
		var start = document.getElementById("start");
		let end = document.getElementById("end");
		start.value = today;
		end.value = today;
	}
	function setEnd() {
		end.value = start.value;
	}
	var sendData = document.getElementById("sendData");
	function sendForm(){
			hasError = false;
			var empno = document.getElementById("empno");
			var start = document.getElementById("start");
			var end = document.getElementById("end");
			var title = document.getElementById("title");
			var xhr1 = new XMLHttpRequest();
			xhr1.open("POST","<c:url value='/schedule/addSchedule'/>",true);
			var jsonSchedule = {
					"empno": empno,
					"start": start,
					"end": end,
					"title": title,
			}
			xhr1.setRequestHeader("Content-Type","application/json");
			xhr1.send(JSON.stringify(jsonSchedule));
			
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