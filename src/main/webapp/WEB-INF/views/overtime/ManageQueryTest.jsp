<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<!--     載入 Bootstrap -->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous"> -->
<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous"> -->
<!-- <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css"> -->
	
    <!-- checksystem css -->
    <link rel='stylesheet' href="<c:url value='/css/overtimeMange.css' />" type="text/css" />
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    
   
    
    <script src="js/jquery-3.6.0.min.js"></script>
    
    <style type="text/css">
		.currentPage{
			background-color: green;
		}
		table{
			text-align: center;
		}

	</style>
    
    <!-- .js請從此後寫 -->
	<script type="text/javascript">
	$(document).ready(function(){
		
		let managequery = $('#managequery');
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/manageQuery'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				managequery.html(managequeryPending(xhr.responseText));
			}
		}
		
		$('#search').click(function(){
			
			var depart = $("#depart").val();
			var date = $("#date").val();
			
			callAjax(null,depart,date);
				
		});

	});

	function pageClick(e){
		
		var depart = $("#depart").val();
		var date = $("#date").val();
		var page = e.getAttribute("id");
		
		callAjax(page.substring(4,(page.length)),depart,date);
	}
	
	function callAjax(page,depart,date){
		
		depart = depart == '' ? null : depart;
		date = date == '' ? null : date;
		page = page == '' ? 1 : page;
		
		let managequery = $('#managequery');
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/manageQuery'/>?depart=" + depart + "&date=" + date + "&pageNo=" + page);
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				managequery.html(managequeryPending(xhr.responseText));
			}
		}
	}
	
	
	function managequeryPending(jsonString){
		
		let result = JSON.parse(jsonString);
		let managequerys = result.result;
		
		let segment ="<table border='1' align='center'>";
		segment += "<tr><th colspan='11'>管理員審核系統</th></tr>";
		segment += "<tr><th>申請日期</th><th>姓名</th><th>部門</th><th>職位</th><th>加班類型</th><th>加班日期</th><th>開始時間</th><th>結束時間</th><th>加班時數</th><th>加班原因</th><th>審核狀態</th>";
		for(let n = 0 ; n< managequerys.length; n++){
			let managequery = managequerys[n];
			var passid = 'pass' + managequery.id;
			segment += "<tr>";
			segment += "<td>"+ managequery.dateOfApplication + "</td>";
			segment += "<td>"+ managequery.empName + "</td>";
			segment += "<td>"+ managequery.department + "</td>";
			segment += "<td>"+ managequery.position + "</td>";
			segment += "<td>"+ managequery.overtimeCategory + "</td>";
			segment += "<td>"+ managequery.overTimeDate + "</td>";
			segment += "<td>"+ managequery.startingTime + "</td>";
			segment += "<td>"+ managequery.endingTime + "</td>";
			segment += "<td>"+ managequery.overTimeHours + "</td>";
			segment += "<td>"+ managequery.reason + "</td>";
			segment += "<td>"+ managequery.result + "</td>";
			segment += "<td>"+"<button type='button' onclick='passAnDdenyClick(this)' id='" + passid + "' class='btn btn-primary btn-lg b1' value='Pass'>"+"Pass"+"</button>"+" ";
			segment += "<button type='button' onclick='passAnDdenyClick(this)' id='" + passid + "' class='btn btn-primary btn-lg b2' value='Deny'>"+"Deny"+"</button>"+"</td>";
		}
		segment += "</table>";
		
		var totalPage = result.totalPage;
		var currentPage = result.currentPage;
		
		for(let n = 1 ; n<= totalPage; n++){
			
			var isCurrent = "";
			
			if(n == currentPage) isCurrent = "currentPage";
			
			var id = 'page' + n;
			
			segment += "<button onclick='pageClick(this)' class='pageNo " + isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
			
		}
		
		return segment;
		
	}
	
	function refresh(){
		
		var depart = $("#depart").val();
		var date = $("#date").val();
		
		callAjax(null,depart,date)
		
	}
	
	function passAnDdenyClick(e){
		var pass = e.getAttribute('id');
		var passnum = pass.substring(4,(pass.length))
		var type = e.getAttribute('value');
		if (type === "Pass"){
			swal({
		        title: "審核確定通過嗎?",
		        html: "請再次確認!",
		        type: "question",
		        confirmButtonText: "確定",
		      	cancelButtonText: "取消",
		        showCancelButton: true//顯示取消按鈕
		    }).then(function (result) {
		        if (result.value) {
		            //使用者按下「確定」要做的事
		        	
		        	alert(type)
		        	let xhr1 = new XMLHttpRequest();
		        	xhr1.open("POST","<c:url value='/manageAudit'/>");
		        	xhr1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		        	xhr1.send("id=" + passnum + "&type=" + type);
		        	xhr1.onreadystatechange = function(){
		        		if(xhr1.readyState == 4 && xhr1.status == 200){
		        			swal("Thank!", "完成審核", "success");
		        			refresh();
		        		}
		        	}
		     } else if (result.dismiss === "cancel"){
		          //使用者按下「取消」要做的事
		         swal("取消審核", "尚未審核該筆資料", "error");
		     }//end else  
		  });//end then 	
		}else{
		swal({
	        title: "是否確定退件?",
	        html: "請再次確認!",
	        type: "question",
	        confirmButtonText: "確定",
	      	cancelButtonText: "取消",
	        showCancelButton: true//顯示取消按鈕
	    }).then(function (result) {
	        if (result.value) {
	            //使用者按下「確定」要做的事
	        	
	        	alert(type)
	        	let xhr1 = new XMLHttpRequest();
	        	xhr1.open("POST","<c:url value='/manageAudit'/>");
	        	xhr1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	        	xhr1.send("id=" + passnum + "&type=" + type);
	        	xhr1.onreadystatechange = function(){
	        		if(xhr1.readyState == 4 && xhr1.status == 200){
	        			swal("Thank!", "完成審核", "success");
	        			refresh();
	        		}
	        	}
	     } else if (result.dismiss === "cancel"){
	          //使用者按下「取消」要做的事
	         swal("取消審核", "尚未審核該筆資料", "error");
	     }//end else  
	  });//end then 	
		}
	}
	
// 	function denyClick(e){
// 		swal({
// 	        title: "審核確定通過嗎?",
// 	        html: "請再次確認!",
// 	        type: "question",
// 	        confirmButtonText: "確定",
// 	      	cancelButtonText: "取消",
// 	        showCancelButton: true//顯示取消按鈕
// 	    }).then(function (result) {
// 	        if (result.value) {
// 	            //使用者按下「確定」要做的事

// 	        	let managequerys2 = JSON.parse(jsonString);
// 	        	let id2 = managequerys[n];
// 	        	let type2 = $(this).val;
// 	        	let xhr2 = new XMLHttpRequest();
// 	        	xhr2.open("POST","<c:url value='/manageAudit'/>");
// 	        	xhr2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
// 	        	xhr2.send("id=" + id2.id & "type" + type2);
// 	        	xhr2.onreadystatechange = function(){
// 	        		if(xhr2.readyState == 4 && xhr2.status == 200){
// 	        			swal("Thank!", "完成審核", "success");
// 	        		}
// 	        	}
// 	     } else if (result.dismiss === "cancel"){
// 	          //使用者按下「取消」要做的事
// 	         swal("取消審核", "尚未審核該筆資料", "error");
// 	     }//end else  
// 	  });//end then 	
	
	
	
	</script>
	
	
</head>

<body id="page-top" >

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <div class="sidebar-brand-icon">
            </div>
            <div class="sidebar-brand-text mx-auto">
                <img id="logo" src="img/logo_frame.png">
            </div>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/' />">
                    <i class='fas fa-home' style='font-size:22px'></i>
                    <span>主頁</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="<c:url value='pages' />">
                    <i class='fas fa-clock' style='font-size:22px'></i>
                    <span id="listname">出勤管理</span>
                </a>
            </li>
            <li class="nav-item">            
                <a class="nav-link collapsed" href="<c:url value='pages' />">
                    <i class='fas fa-user-tie' style='font-size:22px'></i>
                    <span id="listname">人員管理</span>
                </a>
            </li>
        </ul>
        <!-- End of Sidebar -->



        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    <!-- Topbar Search -->                    
                        <div class="narbar-brand">
                            <h2 class="font-weight-bold mb-3">HR有限公司 人力資源系統</h2>
                            <span class="text-dark">特休剩餘時數：【】小時&nbsp</span><span class="text-danger warning">(請於 【日期】 前使用完畢)</span><br/>
                            <span class="text-dark">加班剩餘時數：【】小時&nbsp</span><span class="text-danger warning">(請注意到期時間)</span>
                        </div>  

                        <!-- 0419 alert to do -->

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">                   
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="###" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">員編員編員編</span>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    登出
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->
           <div id="bgcolor" class="container-fluid h-75" >  
             <div class="row">

                        <!-- First Column -->
                        <div class="col-lg-4 overtimeManage">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4" >
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">管理員查詢系統</h2>
                                </div>
                                
                                <div>
                                	<select  id="depart" >
									    <option value>請選擇部門</option>
									    <option value="行銷部門">行銷部門</option>
									    <option value="行政部門">行政部門</option>
									    <option value="業務部門">業務部門</option>
									</select>
									
									<select  id="date">
									    <option value>請選擇</option>
									    <option value="2021-05">2021-05</option>
									    <option value="2021-06">2021-06</option>
									    <option value="2021-07">2021-07</option>
									    <option value="2021-08">2021-08</option>
									    <option value="2021-09">2021-09</option>
									</select>
									
									<button id="search">搜尋</button>
                                
                                </div>
                                
                                <div class="card-body " id="managequery" data-toggle='table'>
                                
                                      
                                </div>
                            </div>

                            <!-- Custom Font Size Utilities -->
                            

                        </div>

                        <!-- Second Column -->
<!--                         <div class="col-lg-4"> -->

<!--                             Background Gradient Utilities -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Custom Background Gradient Utilities -->
<!--                                     </h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="px-3 py-5 bg-gradient-primary text-white">.bg-gradient-primary</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-secondary text-white">.bg-gradient-secondary</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-success text-white">.bg-gradient-success</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-info text-white">.bg-gradient-info</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-warning text-white">.bg-gradient-warning</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-danger text-white">.bg-gradient-danger</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-light text-white">.bg-gradient-light</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-dark text-white">.bg-gradient-dark</div> -->
<!--                                 </div> -->
<!--                             </div> -->

<!--                         </div> -->

                        <!-- Third Column -->
<!--                         <div class="col-lg-4 mycss "> -->

<!--                             Grayscale Utilities -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h2 class="m-0 font-weight-bold text-primary">我的出勤紀錄 -->
<!--                                     </h2> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="slide_toggle" id="showCheck">展開近五筆</div> -->
<!--                                 展開 -->
<!--                                 <div id="showFile" align='center'> -->
<!--                                 <table class="table table-hover table-bordered"> -->
<!-- 									<tr><th>日期</th><th>上班時間</th><th>下班時間</th><th>上班是否遲到</th><th>下班是否準時</th></tr> -->
<%-- 										<c:forEach var='checksystem' items='${Checksystem}'> --%>
<!-- 										  <tr> -->
<%-- 										  	 <td>${fn:substring(checksystem.createTime,0, 10)}</td> --%>
<%-- 										     <td>${fn:substring(checksystem.checkInTime,11,19)}</td> --%>
<%-- 										     <td>${fn:substring(checksystem.checkOutTime,11,19)}</td> --%>
<!-- 										     <td> -->
<%-- 										     	<c:choose> --%>
<%-- 										     	  <c:when test="${checksystem.isLateCheckIn == 'Y'}" > 是</c:when> --%>
<%-- 										     	  <c:when test="${checksystem.isLateCheckIn == 'N'}" > 否</c:when> --%>
<%-- 						       					</c:choose> --%>
<!-- 										     </td> -->
<!-- 										     <td>  -->
<%-- 										     	<c:choose> --%>
<%-- 										     	  <c:when test="${checksystem.isOnTimeCheckOut == 'Y'}" > 是</c:when> --%>
<%-- 										     	  <c:when test="${checksystem.isOnTimeCheckOut == 'N'}" > 否</c:when> --%>
<%-- 						       					</c:choose> --%>
<!-- 						       				 </td> -->
										     
<!-- 										 </tr>     -->
<%-- 										</c:forEach> --%>
<!-- 								  </table> -->
<%-- 								  <a href="<c:url value='/empCheck' />" class="text-decoration-none"> --%>
<!-- 		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button> -->
<!-- 		                          </a> -->
<!-- 								  </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->

                    </div>
                  </div>
                    
                    
             			

                

               

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->



    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade text-center" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="exampleModalLabel">確定要登出？</h5>
                    <!-- <button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
                        <!-- <span aria-hidden="true">×</span> -->
                    <!-- </button> -->
                </div>
                <div class="modal-body">
                    <span>提醒：未儲存之工作項目將會遺失</span><br/>
                    <span>請確認已完成當前工作，再選擇【登出】。</span>
                </div>
                <div class="modal-footer justify-content-center">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">取消</button>
                    <a class="btn btn-primary" href="<c:url value='login' />">登出</a>
                </div>
            </div>
        </div>
    </div>

<!--     Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!--     Core plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!--     Custom scripts for all pages -->
    <script src="js/sb-admin-2.min.js"></script>
 <!-- 引入bootstrap js  and table -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script> -->
<!-- <script src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script> -->

</body>

</html>