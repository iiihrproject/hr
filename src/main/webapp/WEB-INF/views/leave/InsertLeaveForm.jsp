<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<title>Leave Of Absence</title>
<script>

	window.addEventListener("DOMContentLoaded", function() {
		initialCSS();
		initialDate();
		loadReasonList();
		loadDeptEmps();
	});
	
	function loadDeptEmps() {
		var empNames = [];
		var handOffSelect = document.getElementById('handOffSelect');
		var xhr = new XMLHttpRequest();
		var myDeptNo = ${sessionScope.loginModel.getDepartmentDetail().getDepartmentNumber()};
		var myDept = "${sessionScope.loginModel.getDepartmentDetail().getName()}";
		xhr.open("GET", "<c:url value='/G/findEmpsByDept'/>" + "?departmentNumber=" + myDeptNo, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var colleagues = JSON.parse(xhr.responseText);
				//塞一個選擇選項
				var option = new Option( myDept + "好同事", -1);
				handOffSelect.options[handOffSelect.options.length] = option;
				handOffSelect.options[0].disabled = true;
				//loop其他選項
				for (let i = 0; i < colleagues.length; i++) {
					var colleague = [ colleagues[i].name, colleagues[i].pk ];
					//先把JSON的資料轉成List
					empNames.push(colleague);
					//用Option物件塞剩下的選項
					var option = new Option(empNames[i][0], empNames[i][1]);
					handOffSelect.options[handOffSelect.options.length] = option;
				}
			}
		}
		//email隨著職代改變
		document.getElementById("handOffSelect").addEventListener("change",function() {
			var handOff = document.getElementById("handOffSelect").value;
			var xhr = new XMLHttpRequest();
			xhr.open("GET","<c:url value='/G/findEmpByPk'/>?empId=" + handOff, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var emp = JSON.parse(xhr.responseText);
					document.getElementById("handOffEmail").value = emp.email;
				}
			}
		});
	}
	
	function loadReasonList() {
		var reason = [];
		var reasonSelect = document.getElementById('reasonSelect');
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/G/findListByCAT'/>" + "?category=REASON_ID", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var reasonList = JSON.parse(xhr.responseText);
				//塞一個選擇選項
				var option = new Option("請選擇", -1);
				reasonSelect.options[reasonSelect.options.length] = option;
				reasonSelect.options[0].disabled = true;
				//loop其他選項
				for (let i = 0; i < reasonList.length; i++) {
					var rList = [ reasonList[i].desc_zh, reasonList[i].code ];
					//先把JSON的資料轉成List
					reason.push(rList);
					//用Option物件塞剩下的選項
					var option = new Option(reason[i][0], reason[i][1]);
					reasonSelect.options[reasonSelect.options.length] = option;
				}
			}
		}
	}

	function initialCSS() {
		// 		$("form :input").addClass("form-control");
		$("label").addClass("col-form-label text-gray-800");
	}
	
	

	function initialDate() {
		const d = new Date();
		let today = d.toISOString().substring(0, 10);
		document.getElementById("requestDate").value = today;
		let startDate = document.getElementById("startDate");
		let endDate = document.getElementById("endDate");
		startDate.value = today;
		endDate.value = today;
		startDate.onchange = function() {
			endDate.value = startDate.value;
		}
	}

	
	

	//嘗試新方法 但失敗
	// 	$("#submitBtn").click(function(sendData){
	// 		sendData.preventDefault();
	// 		var form = $('form')[0];
	// 		var formData = new FormData(form);
	// 		$.ajax({
	// 			url:'/Leave/Insert',
	// 			type:"POST",
	// 			data: formData,
	// 			contentType: false,
	// 			cache: false,
	// 			processData: false,
	// 			success: function(data){
	// 				console.log(data);
	// 			},
	// 			error: function(data){
	// 				console.log('無法送出');
	// 			}
	// 		})
	// 	});
</script>
</head>
<body>
<!-- enctype="multipart/form-data"  -->
	<div class="containerform">
		<form method="POST" id="uploadForm">
			<div class="form-row">
				<div class="col">
					<div class="form-control-plaintext">申請人：${sessionScope.loginModel.name}</div>
					<input class="d-none" id="empPk" value="${sessionScope.loginModel.pk}">
				</div>
				<div class="col form-row">
					<div class="form-control-plaintext" style="text-align:right">申請日：</div>
				</div>
				<div class="col form-row">
					<input type="text" readonly class="form-control-plaintext" id="requestDate" name="requestDate">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="reasonSelect">請假事由</label>
					<select class="form-control form-select" autofocus id="reasonSelect" name="reason"></select>
				</div>
				<div class="form-group col-md-6 d-none">
					<label for="days">請假天數</label>
					<input type="text" class="form-control" id="days" name="days" readonly>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="startDate">起始日期</label>
					<input type="date" class="form-control" id="startDate" name="startDate" required>
				</div>
				<div class="form-group col-md-6">
					<label for="startTime">起始時間</label>
					<input type="time" class="form-control" id="startTime" name="startTime" required 
					    value="09:00" step="1800">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="endDate">結束日期</label>
					<input type="date" class="form-control" id="endDate" name="endDate" required>
				</div>
				<div class="form-group col-md-6">
					<label for="endTime">結束時間</label>
					<input type="time" class="form-control" id="endTime" name="endTime" required
						value="18:00" step="1800">
				</div>
			</div>
			<div class="form-group">
				<label for="comments">備註</label>
				<textarea class="form-control" id="comments" name="comments"
					rows="2" placeholder="請輸入相關內容" required></textarea>
			</div>
			<div class="form-row">
				<div class="form-group col-md-5">
					<label for="handOffSelect">職務代理人</label>
					<select class="form-control form-select" id="handOffSelect" name="handOff" required></select>
				</div>
				<div class="form-group col-md-7">
					<label for="handOffSelect">代理人Email</label>
					<input type="email" class="form-control" id="handOffEmail" name="hand-offEmail" readonly placeholder="代理人的Email">
				</div>
			</div>
			<div class="form-group form-inline">
				<label for="supportingDoc">相關檔案上傳</label>
				<input type="file" class="form-inline col-md-10" id="supportingDoc" name="supportingDoc" multiple>
			</div>
			<div id="messageBox" class="alert alert-danger d-none" role="alert"></div>
			<input type="button" class="btn btn-primary btn-user btn-block" id="submitBtn" value="送出">
		</form>
	</div>
	<script>
// 		//新增資料 練習新法 失敗
// 		$("#submitBtn").click(function() {
// 			var requestDate = document.getElementById("requestDate").value;
// 			var reason = document.getElementById("reasonSelect").value;
// 			var startDate = document.getElementById("startDate").value;
// 			var startTime = document.getElementById("startTime").value;
// 			var endDate = document.getElementById("endDate").value;
// 			var endTime = document.getElementById("endTime").value;
// 			var comments = document.getElementById("comments").value;
// 			var handOff = document.getElementById("handOffSelect").value;
// 			var handOffEmail = document.getElementById("handOffEmail").value;
			
// 			$.post("/Leave/Insert",
// 				{
// 				applicationNo : "L1234567",
// 				typeOfForm : "Leave",
// 				emp : {empNo: ${sessionScope.loginModel.getEmpNo()}},
// 				requestDate : requestDate,
// 				reasonList : {code: reason},
// 				startDate : startDate,
// 				startTime : startTime,
// 				endDate : endDate,
// 				endTime : endTime,
// 				comments : comments,
// 				handOff : handOff,
// 				handOffEmail : handOffEmail,
// 				status : "pending"
// 				},
// 				function(responseTxt, statusTxt, xhr) {
// 				if (statusTxt == "success")
// 					alert("External content loaded successfully!");
// 				if (statusTxt == "error")
// 					alert("Error: " + xhr.status + ": " + xhr.statusText);
// 			});
// 		});
		
		//Testing
	 	$("#submitBtn").mouseover(function(){
			var requestDate = document.getElementById("requestDate").value;
			var startTime = document.getElementById("startTime").value;
			var endTime = document.getElementById("endTime").value;
			var handOffSelect = document.getElementById("handOffSelect");
	 	});
		//跳出計算天數
		$("#endDate").blur(function(){
			let startDate = new Date(document.getElementById("startDate").value);
			let endDate = new Date(document.getElementById("endDate").value);
			var dayDiff = Math.round((endDate.getTime() - startDate.getTime()) / 1000 /60/60/24)+1;
			console.log(startDate,endDate,dayDiff);
			if (dayDiff == 1){
				let startTime = new Date(2000,00,01,document.getElementById("startTime").value.slice(0,2),document.getElementById("startTime").value.slice(3,5));
				let endTime = new Date(2000,00,01,document.getElementById("endTime").value.slice(0,2),document.getElementById("endTime").value.slice(3,5));
				var clockDiff  = Math.round((endTime.getTime() - startTime.getTime()) / 1000 /60/60);
				let restH = 1;
				let timeDiff = 0;
				if(document.getElementById("endTime").value.slice(0,2)>13){
					timeDiff = clockDiff- restH;
				} else {timeDiff =clockDiff;
				}	if(timeDiff < 8){
					$("#days").val(timeDiff+"小時").parent("div").removeClass("d-none");
				} else{
					$("#days").val(dayDiff+"日").parent("div").removeClass("d-none");
				}
			} else{
				$("#days").val(dayDiff+"日").parent("div").removeClass("d-none");
			}
		});
		//驗證後修改恢復CSS
		$("#reasonSelect").change(function(){
			$(this).removeClass("is-invalid");
		});
		$("#startDate").change(function(){
			$(this).removeClass("is-invalid");
			$("#endDate").removeClass("is-invalid");
		});
		$("#endDate").change(function(){
			$(this).removeClass("is-invalid");
			$("#startDate").removeClass("is-invalid");
		});
		$("#comments").change(function(){
			$(this).removeClass("is-invalid");
		});
		$("#handOffSelect").change(function(){
			$(this).removeClass("is-invalid");
		});
		</script>
	
</body>

</html>