<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
// 								console.log(leaveList);
				setCSS();
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
					segment += "<td><span class='btn-sm text-white font-weight-bold'>" + leave.statusList.desc_zh + "</span></td></tr>";
				}
					return segment
				}
			}
		}
	}

	// 設定CSS
	function setCSS(){
//	 	狀態結果改變背景色
		$("td span").each(function(index){
			if($(this).text() == "提出申請"){
				$(this).addClass("bg-warning text-dark");
			} else if($(this).text() == "取消"){
				$(this).addClass("bg-secondary").parent($(this)).addClass("text-right");
			} else if($(this).text() == "通過"){
				$(this).addClass("bg-success").parent($(this)).addClass("text-center");
			} else if($(this).text() == "否決"){
				$(this).addClass("bg-danger").parent($(this)).addClass("text-right");
			}
		});
	}
</script>

<div class="container-fluid h-75 pt-4">
	<div class="row">
		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div
								class="text-xs font-weight-bold text-primary text-uppercase mb-1">
								Revisit query</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
								<a href="<c:url value='/EmpSignQuery' />"
									class="text-decoration-none stretched-link">補簽查詢</a>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-history fa-3x text-primary"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-danger shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div
								class="text-xs font-weight-bold text-danger text-uppercase mb-1">
								Overtime query</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
								<a href="<c:url value='/employeeQuery' />"
									class="text-decoration-none stretched-link">加班查詢</a>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-business-time fa-3x text-danger"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-xl-4 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div
								class="text-xs font-weight-bold text-warning text-uppercase mb-1">
								Leave query</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800 text-center">
								<a href="<c:url value='/Leave/MyLeaveApply' />"
									class="text-decoration-none stretched-link">請假查詢</a>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-power-off fa-3x text-warning"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12">
			<div>
				<!-- Collapsable Card Example -->
				<div class="card shadow mb-4">
					<!-- Card Header - Accordion -->
					<h6 class="m-0 font-weight-bold text-primary">
					<a href="#collapseCardExample" class="d-block card-header py-3"
						data-toggle="collapse" role="button" aria-expanded="true"
						aria-controls="collapseCardExample">
						${sessionScope.loginModel.getName()}的請假申請紀錄
					</a></h6>
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

</div>