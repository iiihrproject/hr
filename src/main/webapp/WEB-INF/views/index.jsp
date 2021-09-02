<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.hr.login.model.LoginModel"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>HR有限公司 人力資源系統</title>

    <!-- Custom fonts for this template-->
    
    <link href="<c:url value='vendor/fontawesome-free/css/all.min.css' />" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    
    <link href="<c:url value='css/sb-admin-2.min.css' />" rel="stylesheet">
    <link rel="icon" href="<c:url value='img/favicon.png' />">
    <link rel="stylesheet" href="<c:url value='css/mycss.css' />">
    <link rel="stylesheet" href="<c:url value='css/bulcss.css' />">    
    <script src="<c:url value='js/jquery-3.6.0.min.js' />"></script>
    <!-- .js請從此後寫 -->
    
    <!-- 行事曆載入 -->
    <link href="<c:url value='css/main.css' />" rel='stylesheet' />
    <link href="<c:url value='css/mymain.css' /> "rel="stylesheet" />
    <script src="<c:url value='js/main.js' />"></script>
    <script src="<c:url value='js/locales-all.js' />"></script>

	<script>
	var calendar
	
	var shifeCheck = true;
	var shiftsAry = [];
	var eventsAry = [];
		
	function modalInit(){
		startInput = document.getElementById("start_");
		endInput = document.getElementById("end_");
		colorInput = document.getElementById("color_");
		titleInput = document.getElementById("title_");
		textInput = document.getElementById("message_");
		startArea = document.getElementById("startArea_");
		endArea = document.getElementById("endArea_");
		titleArea = document.getElementById("titleArea_");
		textArea = document.getElementById("messageArea_");
		startArea.innerHTML = "";
		endArea.innerHTML = "";
		titleArea.innerHTML = "";
		textArea.innerHTML = "";
		
	}
	
	function newCalendar(eventDatas, eventDatas2) {
		var calendarEl = document.getElementById('calendar');
		 	calendar = new FullCalendar.Calendar(calendarEl, {
			themeSystem : "bootstrap4",
			initialView : 'dayGridMonth',
// 			initialDate: '2021-09-01',
			locale : "zh-tw",
			height : "100%",
			headerToolbar : {
				start : "prevYear,today,nextYear",
				center : "prev,title,next",
				end : "dayGridMonth,custom,listWeek",
			},
// 			讀取user班表
			customButtons: {
				custom: {
			      click: function initCalendar(){		    	  
			    	  	console.log("--*");
			    	  	if(shifeCheck){
				    	 	let xhrLoad = new XMLHttpRequest();
							xhrLoad.open("GET", "<c:url value='/shiftsforcalendar' />");
							xhrLoad.send();
							xhrLoad.onreadystatechange = function(){
								if(xhrLoad.readyState == 4 && xhrLoad.status == 200){
// 				 					console.log(xhrLoad.responseText);    //original table
				 					let userShifts = JSON.parse(xhrLoad.responseText);
// 				 					console.log(userShifts);    //parse_shiftData
				 					if(userShifts.length == 0){
				 						document.getElementById("taskAlertTitle").innerHTML = "班表查詢";
				 	 					document.getElementById("alertBox_").innerHTML = "【通知】：班表資料查詢結果0筆<br/>如有疑問，請與班表維護人員聯絡";
				 	 					$("#taskAlert").modal("show");
				 					}else{
				 						shiftsAry = [];
				 						for(let n = 0; n < userShifts.length; n++){
				 							let shiftsAryObj = {};	
				 							shiftsAryObj["no"] = "shift";
				 							shiftsAryObj["start"] = userShifts[n].start;
				 							shiftsAryObj["end"] = userShifts[n].end;
				 							shiftsAryObj["title"] = userShifts[n].title;	
				 							shiftsAryObj["color"] = "#7973AE";
				 							shiftsAryObj["description"] = userShifts[n].title;
				 	 						
				 	 						shiftsAry.push(shiftsAryObj);
				 						}
// 				 						console.log(shiftsAry);
				 						calendar.addEventSource(shiftsAry);				 			
				 						document.getElementsByClassName("fc-custom-button")[0].innerHTML = "隱藏班表";
				 						$(".fc-custom-button").css("opacity","0.5");
				 						$(".fc-custom-button").mouseenter(function(){
				 							$(this).addClass("shift-btn-hover")
				 						})
				 						shifeCheck = false;
				 						console.log(shifeCheck);
				 					}
	
								}
							}
						}else{
							calendar.removeAllEvents();
							calendar.addEventSource(eventsAry);							
							document.getElementsByClassName("fc-custom-button")[0].innerHTML = "顯示班表";
							$(".fc-custom-button").css("opacity","0.9");
							shifeCheck = true;	
							console.log(shifeCheck);
						}
			    	  	
					}		//end of click						
			    }
			  },

			views : {
				dayGridMonth : {
					dayMaxEventRows : 3,
				}
			},
			
// 				click for new
				dateClick : function(info) {
					$("#taskSumbit_").css("display","block");
					document.getElementById("backSumbit_").innerHTML = "送出";
					$("#backSumbit_").css("background","#858796");
					document.getElementById("backSumbit_").innerHTML = "取消";
					document.getElementById("AddEventTitle").innerHTML = "編輯行程";
					
					modalInit();	
					$("#deleteSumbit_").css("display","none");
					startInput.value = ((info.dateStr).toString().substr(0, 10) + "T00:00");
					endInput.value = ((info.dateStr).toString().substr(0, 10) + "T23:59");
					colorInput.value = "#7973ae";
					titleInput.value = "";
					textInput.value = "";
					document.getElementById("taskNo_").value = "";

					console.log("sumbit");
					$("#AddEvent").modal("show");				
					
				},	
				
// 				click for existEvent
				eventClick : function(info) {
					modalInit();					
					console.log(info);
			

					let monthStr = "00,01,02,03,04,05,06,07,08,09,10,11,12".split(",");
					let realStMon = monthStr[(info.event.start).toLocaleDateString().split("/")[1]]
					let realEdMon = monthStr[(info.event.end).toLocaleDateString().split("/")[1]]
// 					console.log("realMon: " + realMon);
					let dayStr = "00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31".split(",");
					let realStDay = dayStr[(info.event.start).toLocaleDateString().split("/")[2]]
					let realEdDay = dayStr[(info.event.end).toLocaleDateString().split("/")[2]]

					let sDateStr = (info.event.start).toLocaleDateString().split("/");
					let sTimeStr = (info.event.start).toTimeString();
					let sTime1 = sDateStr[0] + "-" + realStMon + "-" + realStDay + "T" + sTimeStr.substr(0,8);
					console.log("**st " + sTime1);
					let eDateStr = (info.event.end).toLocaleDateString().split("/");
					let eTimeStr = (info.event.end).toTimeString();
					let eTime1 = eDateStr[0] + "-" + realEdMon + "-" + realEdDay + "T" + eTimeStr.substr(0,8);
					console.log("**ed " + eTime1);
					
					
					startInput.value = sTime1;
					endInput.value = eTime1;
// 					startInput.value = "2021-08-26T13:27";    //test_format
					colorInput.value = info.event.backgroundColor;
					titleInput.value = info.event.title;
					textInput.value = info.event.extendedProps.description;
					let taskNo = document.getElementById("taskNo_");
					taskNo.value = info.event.extendedProps.no;
					console.log(taskNo.value);

					console.log("edit");
					$("#AddEvent").modal("show");
	
					
					if(taskNo.value == "shift"){
						document.getElementById("AddEventTitle").innerHTML = "班別查詢";
						$("#deleteSumbit_").css("display","none");
						$("#taskSumbit_").css("display","none");
						$("#backSumbit_").css("background","#7973AE");
						document.getElementById("backSumbit_").innerHTML = "知道了";
					}else{
						document.getElementById("AddEventTitle").innerHTML = "編輯行程";
						$("#deleteSumbit_").css("display","block");
						$("#taskSumbit_").css("display","block");
						$("#backSumbit_").css("background","#858796");
						document.getElementById("backSumbit_").innerHTML = "取消";
					}
					
				},	
				
				
				
			//事件			
		eventSources : [ 
			eventDatas ,
			eventDatas2
			],		
			
			eventDidMount: function(info) {
					$(info.el).tooltip({
			        title: info.event.extendedProps.description,
			        placement: 'top',
			        trigger: 'hover',
			        container: 'body'
			      });
			    },

			});

			calendar.render();
			document.getElementsByClassName("fc-custom-button")[0].innerHTML = "顯示班表";
		};
	</script>


<!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
<!-- 資料載入 -->
    <script>
	window.onload = function() {
		
// 		讀取user項目清單
		function initCalendar(){
			let xhrLoad = new XMLHttpRequest();
			xhrLoad.open("GET", "<c:url value='/calendartasks' />");
			xhrLoad.send();
			xhrLoad.onreadystatechange = function(){
				if(xhrLoad.readyState == 4 && xhrLoad.status == 200){
// 				console.log(xhrLoad.responseText);    //original table
					processLoadTaskList(xhrLoad.responseText);
				}
			}
		}
		
		function processLoadTaskList(jsonString){
			let calendarTasks = JSON.parse(jsonString);
// 			console.log(calendarTasks);    //original

			eventsAry = [];		
			for(let n = 0; n < calendarTasks.length; n++){	
				let eventsAryObj = {};
				eventsAryObj["no"] = calendarTasks[n].no;	
				eventsAryObj["start"] = calendarTasks[n].start;
				eventsAryObj["end"] = calendarTasks[n].end;
				eventsAryObj["title"] = calendarTasks[n].title;	
				eventsAryObj["color"] = calendarTasks[n].color;
				eventsAryObj["description"] = calendarTasks[n].description;
				
			
				eventsAry.push(eventsAryObj);
			}
			if(shifeCheck){
				console.log(shifeCheck);
				console.log(eventsAry);    //format for fullcalendar
				newCalendar(eventsAry);
			}else{
				newCalendar(eventsAry, shiftsAry);
			}
			
		}
		
// 		載入行事曆
		initCalendar();		
		
		
		
// 		新增&修改項目
		let taskSumbitBtn = document.getElementById("taskSumbit_");
		taskSumbit_.onclick = function(){
			let taskNoVal = document.getElementById("taskNo_").value;
			let startVal = document.getElementById("start_").value;
			let endVal = document.getElementById("end_").value;
			let colorVal = document.getElementById("color_").value;
			let titleVal = document.getElementById("title_").value;
			let textVal = document.getElementById("message_").value;
			let startArea = document.getElementById("startArea_");
			let endArea = document.getElementById("endArea_");
			let titleArea = document.getElementById("titleArea_");
			let textArea = document.getElementById("messageArea_");
			let inpuCheck = true;
			if(!startVal){
				alertWords(startArea, "※請選擇時間");
				inpuCheck = false;
			}else{
				startArea.innerHTML = "";
			}
			console.log(startVal + " + " + endVal);
			if(!endVal){
				alertWords(endArea, "※請選擇時間");
				inpuCheck = false;			
			}else if(endVal < startVal){
				alertWords(endArea, "※請檢查：結束時間須晚於開始時間");
				inpuCheck = false;
			}else if(endVal == startVal){
				alertWords(endArea, "※請檢查：結束時間不得與開始時間相同");
				inpuCheck = false;
			}else{
				endArea.innerHTML = "";
			}
			if(!titleVal){
				alertWords(titleArea, "※請輸入主旨");
				inpuCheck = false;
			}else if(titleVal.length > 15){
				alertWords(titleArea, "※主旨字數過長，請勿超過15字");
				inpuCheck = false;
			}else{
				titleArea.innerHTML = "";
			}
			if(!textVal){
				alertWords(textArea, "※請輸入內容");
				inpuCheck = false;
			}else if(textVal.length > 60){
				alertWords(textArea, "※內容字數過長，請勿超過60字");
				inpuCheck = false;				
			}else{
				textArea.innerHTML = "";
			}
			if(!inpuCheck){
				return;
			}			
			
			let jsonTask ={
				"start": startVal,
				"end": endVal,
				"color": colorVal,
				"title": titleVal,
				"description": textVal,
				"no": taskNoVal,
			};
			console.log(jsonTask);
			console.log("here=" + jsonTask.no);
			console.log("here=" + jsonTask.title);
						
			
			let xhrNew = new XMLHttpRequest();
			xhrNew.open("POST", "<c:url value='/calendarTaskUpdate' />", true);
			xhrNew.setRequestHeader("Content-Type", "application/json");
			
			
			let taskContent = JSON.stringify(jsonTask);		
			xhrNew.send(taskContent);
			console.log(taskContent);	
				

			xhrNew.onreadystatechange = function(){
				if(xhrNew.readyState == 4){
					if(xhrNew.status == 200 || xhrNew.status == 201){
						console.log(xhrNew.responseText);
						taskResult = JSON.parse(xhrNew.responseText);
						initCalendar();
						$("#AddEvent").modal("hide");
					}else{
						document.getElementById("taskAlertTitle").innerHTML = "新增行程";
						document.getElementById("alertBox_").innerHTML = "【通知】：更新行程失敗";
						$("#taskAlert").modal("show");
					}
				}					
			}
			

		
		}				
		
		
		
		function alertWords(input, alertmsg){
			input.innerHTML = "<font color='red' size='0.9rem'>" + alertmsg + "</font>";
		}
				

// 		刪除項目
		deleteSumbit_.onclick = function(){
			$("#deleteAlert").modal("show");
		}

		deleteCheckBtn_.onclick = function(){
			let jsonTask ={
					"no": document.getElementById("taskNo_").value,
				};
			console.log(jsonTask);
			
			let xhrDelete = new XMLHttpRequest();
			xhrDelete.open("POST", "<c:url value='/calendarTaskDelete' />", true);
			xhrDelete.setRequestHeader("Content-Type", "application/json");
			
			let taskContent = JSON.stringify(jsonTask);
			xhrDelete.send(taskContent);
			console.log(taskContent);
			xhrDelete.onreadystatechange = function(){
				if(xhrDelete.readyState == 4){
					if(xhrDelete.status == 200 || xhrDelete.status == 201){
						console.log(xhrDelete.responseText);
						taskResult = xhrDelete.responseText;						
						initCalendar();
						$("#deleteAlert").modal("hide");
						$("#AddEvent").modal("hide");
					}else{
						$("#taskAlert").modal("show");
					}
				}
				
			}
		}

		
		
// 		公佈欄
		let bDataArea = document.getElementById("BulletinDataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/bulletinListUser'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				bDataArea.innerHTML = processBulletinData(xhr.responseText);
			}
		}
		
		//hr權限判斷
		let xhr2 = new XMLHttpRequest();
		let empno = `${sessionScope.loginModel.getEmpNo()}`;
		xhr2.open("GET", "<c:url value='/bulButton'/>?empno="+`${sessionScope.loginModel.getEmpNo()}`);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				processBulButton(xhr2.responseText);
				console.log("HR權限判斷:"+xhr2.responseText);
			}
		}
		
		
	}
    
	function processBulletinData(jsonString) {		
		$(document).ready(function(){
		    $('#datatableid tr').click(function(){
		        window.location = $(this).attr('href');
		        return false;
		    });
		});
				
		console.log(td);
		
		let posts = JSON.parse(jsonString);
		let segment = "";
		let le=0;
		if (posts.length>10) {
			le = 10;}
		else { le = posts.length;}
		for (let n = 0; n < le; n++) {
			let bulletin = posts[n];
			let link = "href='<c:url value='/bulletinDetail' />?postno=" + bulletin.postno + "''>";
			/* let flag = "<i class=' fas fa-info-circle' style='color: #f6c23e; border-color: #f6c23e;'></i>"; */
			let flag = "<img id='logo' src='img/new.png' style='height:16px'>";
			segment += "<tr  "+link;
			segment += "<td style='text-align:center;'>" + bulletin.type + "</td>";
			if(bulletin.postDate==td){
			segment += "<td>" + bulletin.title +" "+flag+"</td>";}
			else{segment += "<td>" + bulletin.title +"</td>"}
			if(bulletin.type == '公告' ){
				segment += "<td style='text-align:center'>-</td>";
			} else if (bulletin.quotatype == '不限') {
				segment += "<td style='text-align:center'>不限</td>";
			} else {
				segment += "<td style='text-align:center'>" + bulletin.enCount +"&nbsp;/&nbsp;"+ bulletin.quota + "</td>";
			}
			segment += "<td style='text-align:center;'>" + bulletin.postDate + "</td>";
			segment += "</tr>";
		}
		return segment;
		
	}

	
function processBulButton(result) {
	console.log("result:"+!result);
	if (result=='true'){
		console.log("執行true");
	}else{
		document.getElementById("bulbutton").innerHTML= "";
		console.log("執行false");
	}
}
	let ped = `${sessionScope.loginModel.getEmployeePassword()}`;
	console.log(ped);
	</script>

</head>

<body id="page-top">

   <jsp:include page="header.jsp"></jsp:include>
   
                <!-- Begin Page Content -->
                <div id="bgcolor" class="container-fluid">
                    <div class="row">
                        <!-- Area Chart -->
                        <div class="col-12 col-lg-6">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">行事曆</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="contents w-100">
                                        <div id='calendar'></div>

                                        <div class="modal fade" id="AddEvent" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                                            aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="AddEventTitle">編輯行程</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="calendarTaskUpdate" method="POST">
                                                          
                                                            <div class="form-group">
                                                            	<input type="hidden" class="form-control" name="taskNo_" id="taskNo_">
                                                                <label for="" class="col-form-label">起始時間</label><span id="startArea_"></span>
                                                                <input type="datetime-local" class="form-control" name="start_" id="start_">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="" class="col-form-label">結束時間</label><span id="endArea_"></span>
                                                                <input type="datetime-local" class="form-control" name="end_" id="end_">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="color_" class="col-form-label">顏色標籤</label><span id="colorArea_"></span>
                                                                <input type="color" class="form-control" id="color_" value="#7973AE">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="title_" class="col-form-label">主旨</label><span id="titleArea_"></span>
                                                                <input type="text" class="form-control" id="title_" autocomplete="on">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="message_" class="col-form-label">內容</label><span id="messageArea_"></span>
                                                                <textarea class="form-control" id="message_"></textarea>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer justify-content-center">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="backSumbit_">取消</button>
                                                            <button type="submit" class="btn btn-danger" id="deleteSumbit_">刪除</button>
                                                            <button type="submit" class="btn btn-primary" id="taskSumbit_" >送出</button>
                                                            <!-- sumit+click(ajax)     //onclick="insertMessage();"      maxlength="20"-->
                                                    </div>                                                   
													                                                   
                                                </div>
                                            </div>
                                        </div>							

                                    </div>
                                </div>
                            </div>
                        </div>

			<div class="modal fade" id="deleteAlert" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="deleteAlertTitle">刪除行程</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body text-center"><span class="text-danger">【通知】：確定要刪除此項行程嗎？</span></div>
						<div class="modal-footer justify-content-center">
							<button type="button" class="btn btn-secondary"	data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary" id="deleteCheckBtn_">確定</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="taskAlert" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="taskAlertTitle">刪除行程</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body text-center"><span class="text-danger" id="alertBox_">【通知】：刪除行程失敗</span></div>
						<div class="modal-footer justify-content-center">
							<button type="button" class="btn btn-secondary"	data-dismiss="modal" id="taskAlertBtn_">知道了</button>
						</div>
					</div>
				</div>
			</div>

                        <!-- 0419 分隔線分隔線 -->

                        <!-- Pie Chart -->
                        <div class="col-12 col-lg-6" id="bulletindiv">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">公佈欄</h6>
                                    <!--人資公布欄管理區-->
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                        	<a class="dropdown-item" href="<c:url value='/myBulletin' />">我的公佈欄</a>
                                        	<div id=bulbutton><div class="dropdown-divider"></div>                                     
                                            <a class="dropdown-item" href="<c:url value='/bulletinManage' />">公佈欄管理</a></div>
                                        </div>
                                    </div>
                                   <!--人資公布欄管理區end-->
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="contents w-100">
                                        <!-- 內容開始 -->
                                        
                                        <!-- DataTales Example -->
											<div class="table-responsive"  style="height:100%">
                                				<table class="table table-bordered table-hover table-sm" width="100%" cellspacing="0" id="datatableid" style="color:#43454e;" >
                                   					 <thead>
                                       					 <tr style="background-color:#c0bde2">
                                            				<th style='text-align:center'>類型</th>
                                            				<th>主旨</th>
                                            				<th style='text-align:center'>報名人數</th>
                                            				<th style='text-align:center'>刊登日</th>
                                        				</tr>
                                    				</thead>
                                    				
                                    				<tbody id="BulletinDataArea" class="">
                                    				</tbody>
                                				</table> 
                             				</div>   
									
									<!-- 內容結束 -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            
            <jsp:include page="footer.jsp"></jsp:include>
            
            
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>