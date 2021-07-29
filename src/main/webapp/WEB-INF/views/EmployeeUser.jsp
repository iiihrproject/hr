<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel='stylesheet' href="<c:url value='/css/overTime.css' />"
	type="text/css" />
<meta charset="UTF-8">
<title>員工加班系統</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
    

	var sendData = document.getElementById("sendData");
	sendData.onclick = function(){
		
		alert($('#empname').val());
		
		var empnameValue = $('#empname').val();  
		var dateValue = $('#date').val();
		var depValue = $('#dep').val();
		var posValue = $('#pos').val();
		var otCategoryValue = $('input[name=Overtime_category]:checked').val()
		var overtimeDateValue = $('#OvertimeDate').val();
		var stimeValue = $('#stime').val();
		var endtimeValue = $('#endtime').val();
		var causeValue = $('#Cause').val();
		var remarksValue = $('#Remarks').val();
		
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST", "<c:url value='/EmployeeInserContrallerAction' />", true);
		var jsonOverTimePending = {
				"empName": empnameValue, 	
				"dateOfApplication": dateValue,
				"department": depValue,
				"position": posValue,
				"overtimeCategory": otCategoryValue,
				"overTimeDate": overtimeDateValue,
				"startingTime": stimeValue,
				"endingTime": endtimeValue,
				"reason": causeValue,
				"remarks": remarksValue
	   		}
		xhr1.setRequestHeader("Content-Type", "application/json");
  		xhr1.send(JSON.stringify(jsonOverTimePending));
		
		
	}
	

});
</script>


</head>
<body>
	<fieldset class="f1">
		<legend>員工請假申請表</legend>
		<div class="form-group">
			<label for="empname" class="t1">申請人:</label> <input type="text"
				class="form-control form1" id="empname" name="EmpName">
		</div>
		<div class="form-group">
			<label for="date" class="t1">申請日期:</label> <input type="date"
				class="form-control form1" id="date" name="Date of Application">
		</div>

		<div class="form-group">
			<label for="dep" class="t1">申請部門:</label> <input type="text"
				class="form-control form1" id="dep" name="department">
		</div>
		<div class="form-group">
			<label for="dep" class="t1">職稱:</label> <input type="text"
				class="form-control form1" id="pos" name="position">
		</div>


		<div class="form-group">
			<label class="t1">加班類型:</label>
		</div>

		<div class="form-group d1 ">
			<input type="radio" class="form-check-input" name="Overtime_category"
				value="平日加班"> <label class="form-check-label radio_1">
				平日加班</label> <input type="radio" class="form-check-input"
				name="Overtime_category" value="假日加班"> <label
				class="form-check-label radio_1">假日加班</label> <input type="radio"
				class="form-check-input" name="Overtime_category" value="休假加班">
			<label class="form-check-label radio_1">休假加班</label>
		</div>
		<div class="form-group">
			<label for="Overtime" class="t1">加班日期:</label> <input type="date"
				class="form-control form1" id="OvertimeDate" name="OvertimeDate">
		</div>
		<div class="form-group">
			<label for="stime" class="t1">開始時間:</label> <input type="time"
				class="form-control form1" id="stime" name="Starting time">
		</div>
		<div class="form-group">
			<label for="endtime" class="t1">結束時間:</label> <input type="time"
				class="form-control form1" id="endtime" name="Ending time">
		</div>
		<div class="form-group">
			<label for="Cause" class="t1">加班事由:</label> <input type="text"
				class="form-control form1" id="Cause" name="reason">
		</div>
	</fieldset>
	<fieldset class="f2">
		<div class="form-group">
			<label for="Remarks" class="t1">備註:</label> <input type="text"
				class="form-control form2" id="Remarks" name="Remarks">
		</div>
	</fieldset>
	<br>
	<div class="d2">
		<button type="button" class="btn btn-primary" id='sendData'>送出</button>
	</div>

</body>
</html>