<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<title>Application List</title>
<script>
	window.addEventListener("DOMContentLoaded", function() {
		loadLeaveData()
	});
	
	function loadLeaveData() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/Leave/findLeaveByEmpNo' />?EmpNo=${sessionScope.loginModel.getEmpNo()}", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				document.getElementById("tbodycontent").innerHTML = processData(xhr.responseText);
				// 				let leaveList = JSON.parse(xhr.responseText);
				// 				console.log(leaveList);
			}
			function processData(jsonString) {
				let leaveList = JSON.parse(jsonString);
				if (leaveList.length == 0) {
					return "<tr><td colspan=5 style='text-align:center'>目前尚無任何申請資料</td></tr>";
				} else {
				let segment = "";
				for (let i = 0; i < leaveList.length; i++) {
					let leave = leaveList[i];
					segment += "<tr>";
					segment += "<td>" + leave.requestDate + "</td>";
					segment += "<td>" + leave.applicationNo + "</td>";
					segment += "<td>" + leave.reasonList.desc_zh + "</td>";
					segment += "<td>" + leave.startDate + " "
							+ leave.startTime.slice(0, 5) + "~" + leave.endDate
							+ " " + leave.endTime.slice(0, 5) + "</td>";
					segment += "<td>" + leave.statusList.desc_zh + "</td></tr>";
				}
					return segment
				}
			}
		}
	}
</script>
</head>
<body>
	<!-- 最外層 -->
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">請假申請資訊</h1>
		</div>
		<!-- End of Page Heading -->
		<div class="row">
			<!-- 左半邊 -->
			<div class="col-lg-5">
				<!-- Basic Card Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary d-inline">請假申請表</h6>
						<button id="autofill" type="button" class="btn btn-warning btn-sm text-gray-900">隨機填入</button>
					</div>
					<!-- 表單內容 -->
					<div class="card-body">
						<jsp:include page="InsertLeaveForm.jsp"></jsp:include>
					</div>
					<!-- 表單內容結束 -->
				</div>
			</div>
			<!-- 右半邊 -->
			<div class="col-lg-7">
				<!-- Collapsable Card Example -->
				<div class="card shadow mb-4">
					<!-- Card Header - Accordion -->
					<a href="#collapseCardExample" class="d-block card-header py-3"
						data-toggle="collapse" role="button" aria-expanded="true"
						aria-controls="collapseCardExample">
						<h6 class="m-0 font-weight-bold text-primary">${sessionScope.loginModel.getEmpNo()}的請假申請紀錄</h6>
					</a>
					<!-- Card Content - Collapse (表格內容)-->
					<div class="collapse show" id="collapseCardExample" style="">
						<div class="card-body">
							<table style="width: 100%" class="table table-hover center">
								<thead>
									<tr>
										<th>申請日</th>
										<th>申請單號</th>
										<th>事由</th>
										<th>期間</th>
										<th>申請狀態</th>
									</tr>
								</thead>
								<tbody id="tbodycontent">
								</tbody>
								<tfoot>
									<tr>
										<td colspan=5></td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
					<!-- 表格內容結束 -->
				</div>
			</div>
		</div>
	</div>
	<script>
	$("#autofill").mouseover(function(){
		$("#reasonSelect").val("R"+getRandom2digit(1,11));
		$("#startDate").val("2021-"+getRandom2digit(1,12)+"-"+getRandom2digit(1,30));
		$("#endDate").val($("#startDate").val());
		$("#comments").val("需要請假");
		document.getElementById("handOffSelect").selectedIndex = getRandomNum(1,$("#handOffSelect option").length-1);
	});
	
	function getRandom2digit(min,max){
		let r = Math.floor(Math.random()*(max-min+1))+min;
		if (r<10){
			r = "0"+r;
			return r
		} else {
		return r;}
	};
	function getRandomNum(min,max){
		let r = Math.floor(Math.random()*(max-min+1))+min;
		return r;
	};
	
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
//			//前端把秒移除，後端須加回去
//			if (start.length == 16) {
//				start += ":00"
//			}
//			if (end.length == 16) {
//				end += ":00"
//			}
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
			"handOffEmail" : handOffEmail,
			"statusList" : {"code": "S01"}
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
					messageBox.innerHTML = "<font color='red'>出現錯誤，快去跪求高手</font>";
				} else if (result.success) {
					messageBox.innerHTML = "<font color='Green'>新增成功</font>";
					loadLeaveData()
				}
			}
		}
	});
	</script>
</body>
</html>