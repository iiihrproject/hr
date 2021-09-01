<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.table .thead-HR th {
  color: #fff;
  background-color: #7973AE;
  border-color: #c0bde2;
}
</style>
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
			setCSS();
		}
		function processData(jsonString) {
			let leaveList = JSON.parse(jsonString);
// 							console.log(leaveList);
			if (leaveList.length == 0) {
				return "<tr><td colspan=6 style='text-align:center'>目前尚無任何申請資料</td></tr>";
			} else {
			let segment = "";
			
			for (let i = 0; i < leaveList.length; i++) {
				let leave = leaveList[i];
				
				segment += `<tr><td><span _empName="${"${leave.empNo}"}"></span><span class="invisible">"${"${leave.empNo}"}"</span></td>`;
				segment += "<td>" + leave.reasonList.desc_zh + "</td>";
				segment += "<td>" + leave.startDate + " "
						+ leave.startTime.slice(0, 5) + "~" + leave.endDate
						+ " " + leave.endTime.slice(0, 5) + "</td>";
				segment += "<td>" + leave.days + "</td>";
				segment += "<td><a href='#Co"+ leave.applicationNo +"' data-toggle='collapse'>" + leave.applicationNo + "</a></td>";
				segment += "<td><span class='btn-sm text-white font-weight-bold'>" + leave.statusList.desc_zh + "</span></td></tr>";
				segment += "<tr class='collapse' id='Co"+ leave.applicationNo +"'>";
				segment += `<td class="pl-4">代理人：<a title="發信給${"${leave.handOffEmail}"}" href="mailto:${"${leave.handOffEmail}"}"><span _pk="${"${leave.handOff}"}"><span class="invisible">"${"${leave.handOff}"}"</span></span></a></td>`;
				segment += "<td colspan='2'>備註：" + leave.comments + "</td>";
				segment += `<td colspan="2">簽核：<span _pk="${"${leave.approval01MGR}"}"></span><span class="invisible">"${"${leave.approval01MGR}"}"</span></td>`;
				segment += "<td><button onclick='seeMore(\"" + leave.applicationNo + "\")' class='btn btn-sm btn-info btn-icon-split' type='button' data-toggle='modal' data-target='#detailModal'>";
				segment += "<span class='icon text-white-50'><i class='fas fa-file-signature'></i></span>";
				segment += "<span class='text'>查看詳情</span></button></td></tr>";
			}
			
			const empNoSet = new Set(leaveList.map(s => s.empNo));
			
			empNoSet.forEach(s => {
				$.get("<c:url value='/G/findEmpByEmpNo' />?empNo="+s,function(empData2,status2){
					if (status2 == "success"){
						$("span[_empName='" +　s + "']").html(empData2.name);
					}
				});
			});
			
			let empPkSet = new Set();
			
			leaveList.forEach(l => {
				empPkSet.add(l.handOff);
				if (l.approval01MGR != '') {
					empPkSet.add(l.approval01MGR)
				}
			});
			empPkSet.forEach(l => {
				$.get("<c:url value='/G/findEmpByPk' />?empId="+l,function(empData3,status3){
					if(status3 == "success"){
						$("span[_pk='" +　l + "']").html(empData3.loginModelInfo.name);
					}
				});
			});
				return segment;
			}
		}
	}
}
function findEmpByEmpNo(empNo, callback){
	$.get("<c:url value='/G/findEmpByEmpNo' />", {empNo:empNo},function(empData,status2){
		if (status2 == "success"){
			callback(empData);
		}
	});
}

// 查看詳情
function seeMore(appNo){
	$.get("<c:url value='/Leave/findLeaveByAppNo' />", {applicationNo:appNo},function(data,status){
		if(status == "success"){
			findEmpByEmpNo(data.empNo, function(empData) {
				$("#m_name").text(empData.name);
			})
			$.get("<c:url value='/G/findEmpByPk' />?empId="+data.handOff,function(empData2,status2){
				if(status2 == "success"){
					$("#m_handOff").text(empData2.loginModelInfo.name);
				}
			});
			var d = new Date(data.approval01Date);
			$("#m_AppNo").text(data.applicationNo);
			$("#m_requestDate").text(data.requestDate);
			$("#m_dept").text("部門："+data.dept.name);
			$("#m_empNo").text("工號："+data.empNo);
			$("#m_reason").text(data.reasonList.desc_zh);
			$("#m_start").html(data.startDate+"<br />"+data.startTime.slice(0,5));
			$("#m_end").html(data.endDate+'<br>'+data.endTime.slice(0,5));
			$("#m_days").text(data.days);
			$("#m_comments").text(data.comments);
			$("#m_supportingDoc").text(data.supportingDoc);
			$("#m_date").text(d.toDateString().slice(4));
			$("#m_status").text(data.statusList.desc_zh);
			if(data.statusList.desc_zh == "通過"){
				$("#m_status").addClass("text-success").removeClass("text-danger");
			} else if(data.statusList.desc_zh == "否決"){
				$("#m_status").addClass("text-danger").removeClass("text-success");
			} else {
				$("#m_status").removeClass("text-danger").removeClass("text-success");
			}
			var sigCanvas = document.getElementById("sig-canvas");
			var sigText = document.getElementById("sig-dataUrl");
	// 		待審核就要清空資料 留按鈕 隱藏結果 
			if(data.statusList.code==("S01")){
				sigCanvas.width = sigCanvas.width;
				$("#sig-canvas").css("display","inline");
				$("#sig-dataUrl").text("");
				$("#sig-image").attr("src","").css("display","inline");
				$("#detailModal button").css("display","inline");
				$("#m_MGR").css("visibility","hidden");
				$("#m_date").css("visibility","hidden");
			} else{
				sigText.innerHTML = data.approval01Sig;
				$("#sig-image").attr("src",data.approval01Sig).css("display","inline");
				$("#sig-canvas").css("display","none");
				$("#detailModal button").css("display","none");
				$("#m_MGR").css("visibility","visible");
				$("#m_date").css("visibility","visible");
				$.get("<c:url value='/G/findEmpByPk' />?empId="+data.approval01MGR,function(empData3,status3){
					if(status3 == "success"){
						$("#m_MGR").text(empData3.loginModelInfo.name);
					}
				});
			}
		}
	});
}

// 設定CSS
function setCSS(){
// 	狀態結果改變背景色
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
			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3 d-none">
					<h6 class="m-0 font-weight-bold text-primary">
						DataTables Example
					</h6>
				</div>
				<div id="cardBody" class="card-body navbar-nav-scroll">
					<div class="table-responsive-sm">
						<div id="dataTable_wrapper"
							class="dataTables_wrapper dt-bootstrap4">
							<div class="row">
								<div class="col-sm-12">
									<table
										class="table dataTable table-hover table-striped text-dark"
										id="mainTable" role="grid" aria-describedby="dataTable_info">
										<thead class="thead-HR">
											<tr role="row">
												<th class="col-md-3" tabindex="0" aria-controls="dataTable"
													rowspan="1" colspan="1" aria-sort="ascending"
													aria-label="Name: activate to sort column descending">申請人</th>
												<th class="col-md-1" tabindex="0" aria-controls="dataTable"
													rowspan="1" colspan="1"
													aria-label="Reason: activate to sort column ascending">假別</th>
												<th class="col-md-4" tabindex="0" aria-controls="dataTable"
													rowspan="1" colspan="1"
													aria-label="Duration: activate to sort column ascending">期間</th>
												<th class="col-md-1" tabindex="0" aria-controls="dataTable"
													rowspan="1" colspan="1"
													aria-label="Day: activate to sort column ascending">天數</th>
												<th class="sorting_desc col-md-1" tabindex="0"
													aria-controls="dataTable" rowspan="1" colspan="1"
													aria-label="AppNo: activate to sort column ascending">申請單號</th>
												<th class="col-md-2" tabindex="0" aria-controls="dataTable"
													rowspan="1" colspan="1"
													aria-label="Status: activate to sort column ascending">狀態</th>
											</tr>
										</thead>
										<tfoot class="thead-HR">
											<tr>
												<th rowspan="1" colspan="1">申請人</th>
												<th rowspan="1" colspan="1">假別</th>
												<th rowspan="1" colspan="1">期間</th>
												<th rowspan="1" colspan="1">天數</th>
												<th rowspan="1" colspan="1">申請單號</th>
												<th rowspan="1" colspan="1">狀態</th>
											</tr>
										</tfoot>
										<tbody id="tbodycontent">
<!-- ajax 產生資料 -->
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Detail Modal -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
	aria-labelledby="detailModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document" id="modalControl">
		<div class="modal-content">
			<div class="modal-header">
				<a href="javascript:" class="btn btn-light btn-icon-split"
					id="printTable"> <span class="icon"><i
						class="fas fa-print"></i></span> <span class="text">按之前請想想「<i
						class="fas fa-tree text-success"></i>」
				</span>
				</a> <a class="close" role="button" data-dismiss="modal">&times;</a>
			</div>
			<div class="modal-body">
				<div class="card shadow">
					<div class="card-body">
						<div id="printArea">
							<h5 class="modal-title mx-auto text-center" id="detailModalLabel">請假申請單</h5>
							<table class="table table-bordered thead-dark" id="modalTable">
								<tr>
									<td class="col-auto"
										style="text-align: left; margin-right: 8px; border: none;">申請單號
										<span id="m_AppNo"></span>
									</td>
									<td class="col-auto"
										style="text-align: right; margin-right: 8px; border: none;">申請日
										<span id="m_requestDate"></span>
									</td>
								</tr>
								<tr>
									<th>申請人</th>
									<td><div class="row align-items-center">
											<div class="col" id="m_name"></div>
											<div class="col" id="m_dept"></div>
											<div class="col" id="m_empNo"></div>
										</div></td>
								</tr>
								<tr>
									<th>請假事由</th>
									<td><span id="m_reason"></span></td>
								</tr>
								<tr>
									<th>請假期間</th>
									<td><div class="row align-items-center">
											<div class="col-auto text-center" id="m_start"></div>
											<div class="col-auto text-center">~</div>
											<div class="col-auto text-center" id="m_end"></div>
											<div class="col-auto text-center">
												共計<span id="m_days"></span>天
											</div>
										</div></td>
								</tr>
								<tr>
									<th>備註</th>
									<td><span id="m_comments"></span></td>
								</tr>
								<tr>
									<th>職務代理人</th>
									<td><span id="m_handOff"></span></td>
								</tr>
								<tr>
									<th>相關檔案上傳</th>
									<td><span id="m_supportingDoc"></span></td>
								</tr>
								<tr>
									<th>主管簽核
										<div id="m_status" class="h1 font-weight-bolder text-center"></div>
									</th>
									<td>
										<div class="row align-items-center">
											<div class="col-auto">
												<canvas id="sig-canvas" class="form-inline"
													style="display: inline">Get a better browser, bro.</canvas>
												<img id="sig-image" src="" style="display: inline" />
											</div>
											<div>
												<button class="btn btn-primary d-print-none my-2"
													id="sig-submitBtn">簽名完成</button>
												<br />
												<button class="btn btn-secondary d-print-none"
													id="sig-clearBtn">重簽</button>
												<br /> <span id="m_MGR" style="visibility: hidden"></span><br />
												<span id="m_date" style="visibility: hidden"></span>
											</div>
										</div> <textarea id="sig-dataUrl" style="display: none"
											class="form-control" rows="5">Data URL will go here!</textarea>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-success col-md-2 ml-md-auto"
					id="approveBtn" data-dismiss="modal">核准</button>
				<button type="button" class="btn btn-danger col-md-2 mr-md-auto"
					id="rejectBtn" data-dismiss="modal">否決</button>
			</div>
		</div>
	</div>
</div>
<!-- End of Detail Modal -->
<script>
//	固定高度
	$(window).resize(function() {
	    var winH = $(this).height();
	    $("#cardBody").height(winH*0.6);
	}).resize();
	
// 	彈出視窗的CSS
	$("#modalTable th").addClass("table-secondary");
	$("#sig-canvas").css("cursor", "crosshair").css("border","2px dotted #CCCCCC");

// 	列印按鈕的功能
	$("#printTable").click(function() {
		var body = $("#printArea").html();
 		var mywindow = window.open("", "", "left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0");
 		mywindow.document.write('<link href="<c:url value='/css/sb-admin-2.min.css' />" rel="stylesheet">');
 		mywindow.document.write(body);
 		mywindow.document.close(); // necessary for IE >= 10'</html>'
 		mywindow.focus(); // necessary for IE >= 10
 		mywindow.print();
// 		mywindow.close();
		return true;
	});
	
	//隱藏主管按鈕
	$("#detailModal button").addClass("d-none");
</script>