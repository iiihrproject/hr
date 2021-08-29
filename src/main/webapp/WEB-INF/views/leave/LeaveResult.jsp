<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
<title>Preview</title>
<script>
window.addEventListener("DOMContentLoaded", function() {
	loadLeaveData()
	
});

function loadLeaveData() {
	var xhr = new XMLHttpRequest();
	var myDeptNo = ${sessionScope.loginModel.getDepartmentDetail().getDepartmentNumber()};
	xhr.open("GET", "<c:url value='/Leave/findLeaveByDeptNo' />?departmentNumber=" + myDeptNo, true);
// 	xhr.open("GET", "<c:url value='/Leave/findAllLeave' />", true);
	xhr.send();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			document.getElementById("tbodycontent").innerHTML = processData(xhr.responseText);
			// 				let leaveList = JSON.parse(xhr.responseText);
			setCSS();
		}
		function processData(jsonString) {
			let leaveList = JSON.parse(jsonString);
							console.log(leaveList);
			if (leaveList.length == 0) {
				return "<tr><td colspan=6 style='text-align:center'>目前尚無任何申請資料</td></tr>";
			} else {
			let segment = "";
			for (let i = 0; i < leaveList.length; i++) {
				let leave = leaveList[i];
				$.get("<c:url value='/G/findEmpByEmpNo' />?empNo="+leave.empNo,function(empData,status2){
					if (status2 == "success"){
						callback(empData);
					}
				});
				segment += "<tr><td>" + leave.empNo + "</td>";
				segment += "<td>" + leave.reasonList.desc_zh + "</td>";
				segment += "<td>" + leave.startDate + " "
						+ leave.startTime.slice(0, 5) + "~" + leave.endDate
						+ " " + leave.endTime.slice(0, 5) + "</td>";
				segment += "<td>" + leave.days + "</td>";
				segment += "<td><a href='#Co"+ leave.applicationNo +"' data-toggle='collapse'>" + leave.applicationNo + "</a></td>";
				segment += "<td><span class='btn-sm text-white font-weight-bold'>" + leave.statusList.desc_zh + "</span></td></tr>";
				segment += "<tr class='collapse' id='Co"+ leave.applicationNo +"'>";
				segment += "<td>代理人：<a title='發信給"+leave.handOffEmail+"' href='mailto:" + leave.handOffEmail + "'>"+leave.handOff+"</a></td>";
				segment += "<td colspan='2'>備註：" + leave.comments + "</td>";
				segment += "<td colspan='2'>簽核：" + leave.approval01Name + "</td>";
				segment += "<td><button onclick='seeMore(\"" + leave.applicationNo + "\")' class='btn btn-sm btn-info btn-icon-split' type='button' data-toggle='modal' data-target='#detailModal'>";
				segment += "<span class='icon text-white-50'><i class='fas fa-file-signature'></i></span>";
				segment += "<span class='text'>查看詳情</span></button></td></tr>";
			}
				return segment
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
					
			findEmpByEmpNo(data[0].empNo, function(empData) {
				$("#m_name").text(empData.name);
			})
			
			$.get("<c:url value='/G/findEmpByPk' />,{empId=pk}?empId="+data[0].handOff,function(empData2,status3){
				if(status3 == "success"){
					$("#m_handOff").text(empData2[0].loginModelInfo.name);
// 					console.log(empData2);
				}
			});
		$("#m_AppNo").text(data[0].applicationNo);
		$("#m_requestDate").text(data[0].requestDate);
		$("#m_dept").text("部門："+data[0].dept.name);
		$("#m_empNo").text("工號："+data[0].empNo);
		$("#m_reason").text(data[0].reasonList.desc_zh);
		$("#m_start").html(data[0].startDate+"<br />"+data[0].startTime.slice(0,5));
		$("#m_end").html(data[0].endDate+'<br>'+data[0].endTime.slice(0,5));
		$("#m_days").text(data[0].days);
		$("#m_comments").text(data[0].comments);
		$("#m_supportingDoc").text(data[0].supportingDoc);
		
		var sigCanvas = document.getElementById("sig-canvas");
		var sigText = document.getElementById("sig-dataUrl");
		var sigImage = document.getElementById("sig-image");
		var clearBtn = document.getElementById("sig-clearBtn");
		var submitBtn = document.getElementById("sig-submitBtn");
		
// 		sigText.innerHtml = data[0].approval01Signature;
// 		sigImage.setAttribute("src", data[0].approval01Signature);
// 		sigImage.style.display = "inline";
// 		sigImage.setAttribute("src", "");
// 		clearBtn.style.display = "inline";
// 		submitBtn.style.display = "inline";
// 		sigCanvas.style.display = "inline";
// 		sigCanvas.width = sigCanvas.width;
// 		sigText.innerHTML = "Data URL for your signature will go here!";
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
// //DataTable setting
// $(document).ready( function () {
//     $("#mainTable").DataTable({
//   	    //屬性區塊:
//   	    searching: true,
//   	    sPaginationType: "full_numbers", 
//   	    lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]], 
//   	    processing: true, 
//   	    serverSide: false, 
//   	    stateSave: true,
//   	    destroy: true, 
//   	    info: true,
//   	    autoWidth: true, 
//   	    ordering: true, 
//   	    scrollCollapse: false, 
//   	    scrollX: "500px",
//   	    scrollY: "200px",    
//   	    paging: true, 
//   	    dom: '<"top">rt<"bottom"><"clear">',
//   	    //ajax區塊:
// 		ajax : {
// 			url : "<c:url value='/Leave/findAllLeave' />",
// 			type : "POST",
// 			},
// 		//資料欄位區塊(columns):
// 		columns : [ {
// 			data : "empNo",		}, {
// 			data : "startDate",		}, {
// 			data : "startDate",		}, {
// 			data : "days",		}, {
// 			data : "applicationNo",		}, {
// 			data : "startDate",	}, ],
// 		//語言區塊(language):
// 		 language: {
// 		    lengthMenu: "顯示 _MENU_ 筆資料",
// 		    sProcessing: "處理中...",
// 		    sZeroRecords: "没有匹配结果",
// 		    sInfo: "目前有 _MAX_ 筆資料",
// 		    sInfoEmpty: "目前共有 0 筆紀錄",
// 		    sInfoFiltered: " ",
// 		    sInfoPostFix: "",
// 		    sSearch: "尋找:",
// 		    sUrl: "",
// 		    sEmptyTable: "尚未有資料紀錄存在",
// 		    sLoadingRecords: "載入資料中...",
// 		    sInfoThousands: ",",
// 		    oPaginate: {
// 		      sFirst: "首頁",
// 		      sPrevious: "上一頁",
// 		      sNext: "下一頁",
// 		      sLast: "末頁",
// 	    },
// 		    order: [[0, "desc"]],
// 		    oAria: {
// 		      sSortAscending: ": 以升序排列此列",
// 		      sSortDescending: ": 以降序排列此列",
// 		    },
// 	  },
// 		//欄位元素定義區塊(columnDefs):
// 	  columnDefs: [
// 	    {
// 	      targets: [2, 3],
// 	      render: function (data) {
// 	        if (data != "無更新") {
// 	          //https://momentjs.com/
// 	          return moment(data).format("YYYY-MM-DD");
// 	        } else {
// 	          return data;
// 	        }
// 	      },
// 	    },
// 	    {
// 	      className: "text-center",
// 	      targets: [0, 1, 2, 3],
// 	    },
// 	    {
// 	      targets: [0],
// 	      createdCell: function (td, cellData, rowData, row, col) {
// 	        $(td).css("word-break", "break-all");
// 	        $(td).css("width", "0.5%");
// 	      },
// 	    },
// 	    {
// 	      targets: [1],
// 	      createdCell: function (td, cellData, rowData, row, col) {
// 	        $(td).css("word-break", "break-all", "text-center");
// 	        $(td).css("width", "1%");
// 	      },
// 	    },
// 	    {
// 	      targets: [2],
// 	      createdCell: function (td, cellData, rowData, row, col) {
// 	        $(td).css("word-break", "break-all");
// 	        $(td).css("width", "5%");
// 	      },
// 	    },
// 	    {
// 	      targets: [3],
// 	      createdCell: function (td, cellData, rowData, row, col) {
// 	        $(td).css("word-break", "break-all");
// 	        $(td).css("width", "1%");
// 	      },
// 	    },
// 	  ],
// 		//列元素區塊(rowCallback):
// 	  rowCallback: function (row, data) {
// 		    if (data["Status"] == "未完成") {
// 		      $(row).addClass("danger");
// 		    } else {
// 		      $(row).addClass("warning");
// 		    }
// 		  },
// 		});
// 	});//end of DataTable Setting
</script>
</head>
<body>
<div class="container-fluid h-75 pt-4">
	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">${sessionScope.loginModel.departmentDetail.name}的請假簽核</h1>
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3 d-none">
			<h6 class="m-0 font-weight-bold text-primary">
				DataTables Example
				<button class="btn btn-info btn-icon-split btn-sm"
					data-toggle="modal" data-target="#detailModal">按我跳出</button>
			</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive-sm">
				<div id="dataTable_wrapper"
					class="dataTables_wrapper dt-bootstrap4">
					<div class="row">
						<div class="col-sm-12">
							<table class="table dataTable table-hover table-striped text-dark" id="mainTable"
								 role="grid" aria-describedby="dataTable_info">
								<thead class="thead-dark">
									<tr role="row">
										<th class="sorting sorting_asc col-md-3" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-sort="ascending"
											aria-label="Name: activate to sort column descending">申請人</th>
										<th class="sorting col-md-1" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-label="Reason: activate to sort column ascending">假別</th>
										<th class="sorting col-md-4" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-label="Duration: activate to sort column ascending">期間</th>
										<th class="sorting col-md-1" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-label="Day: activate to sort column ascending">天數</th>
										<th class="sorting col-md-1" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-label="AppNo: activate to sort column ascending">申請單號</th>
										<th class="sorting col-md-2" tabindex="0"
											aria-controls="dataTable" rowspan="1" colspan="1"
											aria-label="Status: activate to sort column ascending">狀態</th>
									</tr>
								</thead>
								<tfoot class="thead-dark">
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
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script>

	</script>
	<!-- Detail Modal -->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
		aria-labelledby="detailModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document" id="modalControl">
			<div class="modal-content">
				<div class="modal-header">
					<a href="javascript:"
						class="btn btn-light btn-icon-split" id="printTable"> <span
						class="icon"><i class="fas fa-print"></i></span> <span
						class="text">按之前請想想「森林」</span>
					</a>
					<button class="close" type="button" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive" id="printArea">
								<h5 class="modal-title mx-auto text-center"
									id="detailModalLabel">請假申請單</h5>
								<table
									class="table table-bordered thead-dark"
									id="modalTable">
									<tr>
										<td class="col-auto" style="text-align: left; margin-right: 8px; border: none;">申請單號 
											<span id="m_AppNo"></span>
										</td>
										<td class="col-auto" style="text-align: right; margin-right: 8px; border: none;">申請日
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
										<th>主管簽核</th>
										<td>
											<div class="row align-items-center">
												<div>
													<canvas id="sig-canvas" class="form-inline"
														style="display: inline">Get a better browser, bro.</canvas>
													<img id="sig-image" src="" style="display: none" />
												</div>
												<div>
													<button class="btn btn-primary d-print-none d-block my-2"
														id="sig-submitBtn">簽名完成</button>
													<button class="btn btn-secondary d-print-none d-block"
														id="sig-clearBtn">重簽</button>
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
					<div class="invalid-feedback">請記得簽名</div>
					<button class="btn btn-success" id="approveBtn">核准</button>
					<button class="btn btn-danger" id="rejectBtn">否決</button>

				</div>
			</div>
		</div>
	</div>
	<!-- End of Detail Modal -->
	<script>
// 		彈出視窗的CSS
		$("#modalTable th").addClass("table-secondary");
		$("#sig-canvas").css("cursor", "crosshair").css("border",
				"2px dotted #CCCCCC");

// 		列印按鈕的功能
		$("#printTable").click(function() {
// 			document.getElementById("sig-clearBtn").style.display = "none";
// 			document.getElementById("sig-submitBtn").style.display = "none";
							
			var body = $("#printArea").html();
 			var mywindow = window.open("", "", "left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0");
 			mywindow.document.write('<link href="<c:url value='/css/sb-admin-2.min.css' />" rel="stylesheet">');
 			mywindow.document.write(body);
 			mywindow.document.close(); // necessary for IE >= 10'</html>'
 			mywindow.focus(); // necessary for IE >= 10
 			mywindow.print();
// 			mywindow.close();
			
// 			document.getElementById("sig-clearBtn").style.display = "inline";
// 			document.getElementById("sig-submitBtn").style.display = "inline";
			return true;
		});
		
		//set a canvas
		(function() {
			window.requestAnimFrame = (function(callback) {
				return window.requestAnimationFrame
						|| window.webkitRequestAnimationFrame
						|| window.mozRequestAnimationFrame
						|| window.oRequestAnimationFrame
						|| window.msRequestAnimaitonFrame
						|| function(callback) {
							window.setTimeout(callback, 1000 / 60);
						};
			})();

			var canvas = document.getElementById("sig-canvas");
			var ctx = canvas.getContext("2d");
			ctx.strokeStyle = "#222222";
			ctx.lineWidth = 4;

			var drawing = false;
			var mousePos = {
				x : 0,
				y : 0
			};
			var lastPos = mousePos;

			canvas.addEventListener("mousedown", function(e) {
				drawing = true;
				lastPos = getMousePos(canvas, e);
			}, false);

			canvas.addEventListener("mouseup", function(e) {
				drawing = false;
			}, false);

			canvas.addEventListener("mousemove", function(e) {
				mousePos = getMousePos(canvas, e);
			}, false);

			// Add touch event support for mobile
			canvas.addEventListener("touchstart", function(e) {

			}, false);

			canvas.addEventListener("touchmove", function(e) {
				var touch = e.touches[0];
				var me = new MouseEvent("mousemove", {
					clientX : touch.clientX,
					clientY : touch.clientY
				});
				canvas.dispatchEvent(me);
			}, false);

			canvas.addEventListener("touchstart", function(e) {
				mousePos = getTouchPos(canvas, e);
				var touch = e.touches[0];
				var me = new MouseEvent("mousedown", {
					clientX : touch.clientX,
					clientY : touch.clientY
				});
				canvas.dispatchEvent(me);
			}, false);

			canvas.addEventListener("touchend", function(e) {
				var me = new MouseEvent("mouseup", {});
				canvas.dispatchEvent(me);
			}, false);

			function getMousePos(canvasDom, mouseEvent) {
				var rect = canvasDom.getBoundingClientRect();
				return {
					x : mouseEvent.clientX - rect.left,
					y : mouseEvent.clientY - rect.top
				}
			}

			function getTouchPos(canvasDom, touchEvent) {
				var rect = canvasDom.getBoundingClientRect();
				return {
					x : touchEvent.touches[0].clientX - rect.left,
					y : touchEvent.touches[0].clientY - rect.top
				}
			}

			function renderCanvas() {
				if (drawing) {
					ctx.moveTo(lastPos.x, lastPos.y);
					ctx.lineTo(mousePos.x, mousePos.y);
					ctx.stroke();
					lastPos = mousePos;
				}
			}

			// Prevent scrolling when touching the canvas
			document.body.addEventListener("touchstart", function(e) {
				if (e.target == canvas) {
					e.preventDefault();
				}
			}, false);
			document.body.addEventListener("touchend", function(e) {
				if (e.target == canvas) {
					e.preventDefault();
				}
			}, false);
			document.body.addEventListener("touchmove", function(e) {
				if (e.target == canvas) {
					e.preventDefault();
				}
			}, false);

			(function drawLoop() {
				requestAnimFrame(drawLoop);
				renderCanvas();
			})();

			function clearCanvas() {
				canvas.width = canvas.width;
			}

			// Set up the UI
			var sigCanvas = document.getElementById("sig-canvas");
			var sigText = document.getElementById("sig-dataUrl");
			var sigImage = document.getElementById("sig-image");
			var clearBtn = document.getElementById("sig-clearBtn");
			var submitBtn = document.getElementById("sig-submitBtn");
			clearBtn.addEventListener("click",function(e) {
				clearCanvas();
				sigText.innerHTML = "Data URL for your signature will go here!";
				sigImage.setAttribute("src", "");
				sigCanvas.style.display = "inline";
				sigImage.style.display = "none";
			}, false);
			submitBtn.addEventListener("click", function(e) {
				var dataUrl = canvas.toDataURL();
				sigText.innerHTML = dataUrl;
				sigImage.setAttribute("src", dataUrl);
				sigCanvas.style.display = "none";
				sigImage.style.display = "inline";
				clearBtn.style.display = "none";
				submitBtn.style.display = "none";
			}, false);
		})();

//驗證的開始
(function() {'use strict';window.addEventListener('load',function() {
	var forms = document.getElementsByClassName('needs-validation');
	// Loop over them and prevent submission
	var validation = Array.prototype.filter.call(forms,
			function(form) {form.addEventListener('submit', function(event) {
				if (form.checkValidity() === false) {
					event.preventDefault();
					event.stopPropagation();
				}
					form.classList.add('was-validated');
				}, false);
	});
	}, false);
})();
//驗證的結束
	</script>
</body>
</html>