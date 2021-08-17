<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel='stylesheet' href="<c:url value='/css/overTime.css' />"type="text/css" />
<meta charset="UTF-8">
<title>員工補簽申請</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var sendData = document.getElementById("sendData");
	sendData.onclick = function(){
		
		var dateValue = $('#date').val();
		var typeValue = $("select[name='Type']").val();
		var reasonValue = $('#reason').val();
		
		var xhr = new XMLHttpRequest();
		xhr.open("POST","<c:url value='/saveEmpComplementSign' />", true);
		var jsonPendingComplementSign={
			"appliedDate" : dateValue,
			"type" : typeValue,
			"reason" : reasonValue
		}
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.send(JSON.stringify(jsonPendingComplementSign));
  		xhr.onreadystatechange = function() {
  			if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201) ) {
	  			window.location.href = "<c:url value='/xxx'/>";
	  			
  			}
		}
	}		
})




</script>

</head>
<body>
 <fieldset class="f1">
		<legend>員工補簽申請表</legend>
		
		<div class="form-group">
			<label for="date" class="t1">申請補簽日期:</label> <input type="datetime-local"
				class="form-control form1" id="date" name="appliedDate">
		</div>

<!--         <div class="form-group"> -->
<!-- 			<label for="time" class="t1">申請補簽時間:</label> <input type="time" -->
<!-- 				class="form-control form1" id="time" name="appliedTime"> -->
<!-- 		</div> -->

		<div class="form-group">
			<label for="dep" class="t1">補簽類型:</label> 
            <select name = "Type" id = type>
                <option value= "CheckIn" >上班
                </option>  
                <option value= "CheckOut">下班
                </option>  
            </select>  
		</div>
		<div class="form-group">
			<label for="Cause" class="t1">補簽事由:</label> <input type="text"
				class="form-control form1" id="reason" name="reason">
		</div>
	</fieldset>
	<div class="d2">
		<button type="button" class="btn btn-primary" id='sendData'>送出</button>
	</div>
</body>
</html>