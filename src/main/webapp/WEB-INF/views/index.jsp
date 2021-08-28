<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="<c:url value='js/jquery-3.6.0.min.js' />"></script>
    <!-- .js請從此後寫 -->
    
    <!-- 行事曆載入 -->
    <link href="<c:url value='css/main.css' />" rel='stylesheet' />
    <link href="<c:url value='css/mymain.css' /> "rel="stylesheet" />
    <script src="<c:url value='js/main.js' />"></script>
    <script src="<c:url value='js/locales-all.js' />"></script>

	<script>
	function newCalendar(eventDatas) {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			themeSystem : "bootstrap4",
			initialView : 'dayGridMonth',
			locale : "zh-tw",
			height : "100%",
			headerToolbar : {
				start : "prevYear,today,nextYear",
					center : "prev,title,next",
				end : "dayGridMonth,listWeek",
			},
			buttonText : {
				list : "項目清單",
			},
			views : {
				dayGridMonth : {
					dayMaxEventRows : 3,
				},
			},		
			
// 				click for modal
				dateClick : function(info) {
					console.log("add");
					$("#AddEvent").modal();
					console.log(info);
				},	
				
// 				click for update
				eventClick : function(info) {
					console.log("edit");
					$("#AddEvent").modal();
					console.log(info);
				},				
				
// 				event			
		eventSources : [ eventDatas 
			],			

			});
			calendar.render();
		};
	</script>


<!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
<!--     公布欄資料載入 -->
    <script>
	window.onload = function() {
// 		載入行事曆
// 		newCalendar();
		
// 		讀取user項目清單
		let xhrLoad = new XMLHttpRequest();
		xhrLoad.open("GET", "<c:url value='/calendartasks' />");
		xhrLoad.send();
		xhrLoad.onreadystatechange = function(){
			if(xhrLoad.readyState == 4 && xhrLoad.status == 200){
				console.log(xhrLoad.responseText);
				processLoadTaskList(xhrLoad.responseText);
			}
		}
		
		function processLoadTaskList(jsonString){
			let calendarTasks = JSON.parse(jsonString);
			console.log(calendarTasks);

			let eventsAry = [];					
			for(let n = 0; n < calendarTasks.length; n++){	
				let eventsAryObj = {};
				eventsAryObj["no"] = calendarTasks[n].no;	
				eventsAryObj["start"] = calendarTasks[n].start;
				eventsAryObj["end"] = calendarTasks[n].end;
				eventsAryObj["title"] = calendarTasks[n].title;	
				eventsAryObj["description"] = calendarTasks[n].description;
				eventsAryObj["color"] = calendarTasks[n].color;
			
				eventsAry.push(eventsAryObj);
			}			
			
// 			console.log(eventsAry);
			newCalendar(eventsAry);
		}

		
		
// 		公佈欄
		let bDataArea = document.getElementById("BulletinDataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/bulletinList'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				bDataArea.innerHTML = processBulletinData(xhr.responseText);
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
			let flag = "<i class=' fas fa-info-circle' style='color: #f6c23e; border-color: #f6c23e;'></i>";
			segment += "<tr "+link;
			segment += "<td>" + bulletin.type + "</td>";
			if(bulletin.postDate==td){
			segment += "<td>" + bulletin.title +" "+flag+"</td>";}
			else{segment += "<td>" + bulletin.title +"</td>"}
			segment += "<td>" + "20/"+ bulletin.quota + "</td>";
			segment += "<td>" + bulletin.postDate + "</td>";
			segment += "</tr>";
		}
		return segment;
		
	}
	
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
                                                        <h5 class="modal-title" id="exampleModalCenterTitle">新增項目</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!-- 最後+required -->
                                                        <form action="calendarTaskUpdate" method="POST">
                                                            <!-- <div class="form-group">
                                                              <label for="date_" class="col-form-label">日期</label>
                                                              <input type="date" class="form-control" id="date_">
                                                             </div>
                                                            <div class="form-group">
                                                              <label for="time_" class="col-form-label">時間</label>
                                                             <input type="time" class="form-control" id="time_">
                                                           </div> -->
                                                            <div class="form-group">
                                                                <label for="" class="col-form-label">起始時間</label>
                                                                <input type="datetime-local" class="form-control" name="start_" id="start_">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="" class="col-form-label">結束時間</label>
                                                                <input type="datetime-local" class="form-control" name="end_" id="end_">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="color_" class="col-form-label">顏色標籤</label>
                                                                <input type="color" class="form-control" id="color_" value="#7973AE">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="title_" class="col-form-label">主旨</label>
                                                                <input type="text" class="form-control" id="title_" autocomplete>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="message_" class="col-form-label">內容</label>
                                                                <textarea class="form-control" id="message_"></textarea>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer justify-content-center">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                            <button type="submit" class="btn btn-primary" id="add_" onclick="insertMessage();">新增</button>
                                                            <!-- sumit+click(ajax) -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 0419 分隔線分隔線 -->

                        <!-- Pie Chart -->
                        <div class="col-12 col-lg-6">
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
                                            <a class="dropdown-item" href="<c:url value='/bulletinManage' />">管理公佈欄</a>
                                        </div>
                                    </div>
                                   <!--人資公布欄管理區end-->
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="contents w-100">
                                        <!-- 內容開始 -->
                                        
                                        <!-- DataTales Example -->
											<div class="table-responsive">
                                				<table class="table table-bordered table-hover" width="100%" cellspacing="0" id="datatableid">
                                   					 <thead>
                                       					 <tr>
                                            				<th>類型</th>
                                            				<th>主旨</th>
                                            				<th>報名人數</th>
                                            				<th>刊登日</th>
                                        				</tr>
                                    				</thead>
                                    				
                                    				<tbody id="BulletinDataArea" class="">
                                    				</tbody>
                                				</table> 
                             				</div>   
                              				<a href="#" style="color:gray">  more</a>   
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