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
		xhr.open("GET", "<c:url value='/Leave/findEmpsByDept'/>" + "?departmentNumber=" + myDeptNo, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var colleagues = JSON.parse(xhr.responseText);
				//塞一個選擇選項
				var option = new Option("選位" + myDept + "好同事", -1);
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
			xhr.open("GET","<c:url value='/Leave/findEmpByPk'/>?empId=" + handOff, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var emp = JSON.parse(xhr.responseText);
					document.getElementById("handOffEmail").value = emp[0].email;
				}
			}
		});
	}
	
	function loadReasonList() {
		var reason = [];
		var reasonSelect = document.getElementById('reasonSelect');
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/Leave/findListByCAT'/>" + "?category=REASON_ID", true);
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
		$("label").addClass("col-form-label");
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
				<div class="col row form-inline">
					<label style="margin-left: auto">申請日：</label>
					<input class="form-control form-control-plaintext" id="requestDate" name="requestDate">
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
				<div class="form-group col-md-4">
					<label for="handOffSelect">職務代理人</label>
					<select class="form-control form-select" id="handOffSelect" name="handOff" required></select>
				</div>
				<div class="form-group col-md-8">
					<label for="handOff">代理人Email</label>
					<input type="email" class="form-control" id="handOffEmail" name="hand-offemail" readonly placeholder="代理人的Email">
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
		//新增資料
		$("#submitBtn").click(function() {
			var hasError = false;
			var messageBox = document.getElementById("messageBox");
			var empPk = document.getElementById("empPk");
			var requestDate = document.getElementById("requestDate").value;
			var reasonList = document.getElementById("reasonSelect");
			var startDate = document.getElementById("startDate").value;
			var startTime = document.getElementById("startTime").value;
			var endDate = document.getElementById("endDate").value;
			var endTime = document.getElementById("endTime").value;
			var comments = document.getElementById("comments").value;
			var handOffSelect = document.getElementById("handOffSelect");
			var handOffEmail = document.getElementById("handOffEmail").value;
			if (reasonList.selectedIndex == 0) {
				hasError = true;
				$("#reasonSelect").addClass("is-invalid");
				messageBox.innerHTML = "請選擇假別";
			} else if(startDate > endDate) {
				hasError = true;
				$("#startDate").addClass("is-invalid");
				$("#endDate").addClass("is-invalid");
				messageBox.innerHTML = "日期錯誤，結束早於開始";
			} else if(comments == ""){
				hasError = true;
				$("#comments").addClass("is-invalid");
				messageBox.innerHTML = "請大概敘述一下";
			} else if(handOffSelect.selectedIndex == 0){
				hasError = true;
				$("#handOffSelect").addClass("is-invalid");
				messageBox.innerHTML = "請點名職務代理人";
			} else if(handOffSelect.value == empPk.value){
				hasError = true;
				$("#handOffSelect").addClass("is-invalid");
				messageBox.innerHTML = "職務代理人不能是自己";
			}
			if (hasError) {
				$("#messageBox").removeClass("d-none");
				return false;}
// 			//前端把秒移除，後端須加回去
// 			if (start.length == 16) {
// 				start += ":00"
// 			}
// 			if (end.length == 16) {
// 				end += ":00"
// 			}
			var xhr1 = new XMLHttpRequest();
			xhr1.open("POST", "<c:url value='/Leave/Insert' />", true);
			var jsonData = {
				"empNo": '${sessionScope.loginModel.empNo}',
				"requestDate" : requestDate,
				"reasonList" : {"code": reasonList.value},
				"startDate" : startDate,
				"startTime" : startTime,
				"endDate" : endDate,
				"endTime" : endTime,
				"comments" : comments,
				"handOff" : handOffSelect.value,
				"handOffemail" : handOffEmail,
			}
			xhr1.setRequestHeader("Content-Type", "application/json");
			xhr1.send(JSON.stringify(jsonData));
			xhr1.onreadystatechange = function() {
				// 伺服器請求完成
				if (xhr1.readyState == 4
						&& (xhr1.status == 200 || xhr1.status == 201)) {
					result = JSON.parse(xhr1.responseText);
					if (result.fail) {
						console.log("result.fail: " + result.fail)
						messageBox.innerHTML = "<font color='red'>出現錯誤，請詢問相關人員</font>";
					} else if (result.success) {
						messageBox.innerHTML = "<font color='Green'>新增成功</font>";
						loadData();
					}
				}
			}
		});
		
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
// 				handOffemail : handOffemail,
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
		$("#handOffSelect").click(function(){
			$("#days").parent("div").removeClass("d-none");
		});
		//驗證後修改恢復CSS
		$("#reasonSelect").change(function(){
			$(this).removeClass("is-invalid");
		});
		$("#startDate").focus(function(){
			$(this).removeClass("is-invalid");
			$("#endDate").removeClass("is-invalid");
		});
		$("#endDate").focus(function(){
			$(this).removeClass("is-invalid");
			$("#startDate").removeClass("is-invalid");
		});
		$("#comments").focus(function(){
			$(this).removeClass("is-invalid");
		});
		$("#handOffSelect").change(function(){
			$(this).removeClass("is-invalid");
		});
		</script>
	
</body>

</html>