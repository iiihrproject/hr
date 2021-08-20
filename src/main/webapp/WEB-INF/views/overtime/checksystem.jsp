<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	
    <!-- checksystem css -->
    <link rel='stylesheet' href="<c:url value='/css/checksystem.css' />" type="text/css" />
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
	<script type="text/javascript">
	$(document).ready(function(){
		let pending = $('#overtimepending');
		let xhr = new XMLHttpRequest();
		xhr.open("GET","<c:url value='/empPendoingQuery'/>");
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				pending.html(findEmpSignPending(xhr.response));
				
			}
		}
		
		let auditted = $('#overtimeauditted');
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET","<c:url value='/empAudittedQuery'/>");
		xhr1.send();
		xhr1.onreadystatechange = function(){
			if(xhr1.readyState == 4 && xhr1.status == 200){
				auditted.html(findEmpSignAuditted(xhr1.response));
			}
		}
		
		
		
		
	});

	function findEmpSignPending(jsonString){
		
		let pending = $('#signpending');
		
		let result = JSON.parse(jsonString);
		let signpendings = result.result;
		let segment ="<table border='1'class='table table-bordered' >";
		
		if(signpendings != null){
			segment += "<tr><th colspan='6'>員工補簽查詢系統(待審核)</th></tr>";
			segment += "<tr><th>申請日期</th><th>員編</th><th>補簽日期</th><th>補簽時間</th><th>審核狀態</th><th>原由</th></tr>";
			
			for(let n = 0 ; n< signpendings.length; n++){
				let signpending = signpendings[n];
				segment += "<tr>";
				segment += "<td>"+ (signpending.date).substring(0,10) + "</td>";
				segment += "<td>"+ signpending.empNo + "</td>";
				segment += "<td>"+ (signpending.appliedDate).substring(0,10) + "</td>";
				segment += "<td>"+ (signpending.appliedDate).substring(11,16) + "</td>";
				segment += "<td>"+ signpending.status + "</td>";
				segment += "<td>"+ signpending.reason + "</td>";
			}
			segment += "</table>";
			
//	 		var totalPage = result.totalPage;
//	 		var currentPage = result.currentPage;
			
//	 		for(let n = 1 ; n<= totalPage; n++){
				
//	 			var isCurrent = "";
				
//	 			if(n == currentPage) isCurrent = "currentPage";
				
//	 			var id = 'page' + n;
				
//	 			segment += "<button onclick='pendPageClick(this)' class='pendPageNo " + isCurrent + "'  id='" + id + "' " + ">" + n + "</button>";
				
//	 		}
		}
		
		pending.html(segment);
		
	}


	function findEmpSignAuditted(jsonString){
		
		let auditted = $('#signauditted');
		
		let result = JSON.parse(jsonString);
		
		let signauditteds = result.result;
		let segment ="<table border='1'class='table table-bordered' >";
		if(signauditteds !== null){
			segment += "<tr><th colspan='6'>員工加班查詢系統(已審核)</th></tr>";
			segment += "<tr><th>申請日期</th><th>員編</th><th>補簽日期</th><th>補簽時間</th><th>審核狀態</th><th>原由</th></tr>";
			for(let n = 0 ; n< signauditteds.length; n++){
				let signauditted = signauditteds[n];
				segment += "<tr>";
				segment += "<td>"+ (signauditted.date).substring(0,10) + "</td>";
				segment += "<td>"+ signauditted.empNo + "</td>";
				segment += "<td>"+ (signauditted.appliedDate).substring(0,10) + "</td>";
				segment += "<td>"+ (signauditted.appliedDate).substring(11,16) + "</td>";
				segment += "<td>"+ signauditted.status + "</td>";
				segment += "<td>"+ signauditted.reason + "</td>";
			}
//	 		segment += "</table>";
			
//	 		var totalPage = result.totalPage;
//	 		var currentPage = result.currentPage;
			
//	 		for(let n = 1 ; n<= totalPage; n++){
				
//	 			var isCurrent = "";
				
//	 			if(n == currentPage) isCurrent = "currentPage";
				
//	 			var id = 'page' + n;
				
//	 			segment += "<button onclick='audiPageClick(this)' class='audiPageNo " + isCurrent + "'  id='" + id + "' " +">" + n + "</button>";
				
//	 		}
		}
		
		auditted.html(segment);
		
	}
	
	
	</script>
	
	
	






</script>

</head>

<body id="page-top" onload="ShowTime() , ShowDate() " >

    <jsp:include page="../header.jsp"></jsp:include>
    
    <!-- header刪掉 start-->

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

                <!-- header刪掉 End-->
                
             <div class="row">

                        <!-- First Column -->
                        <div class="col-lg-4 mycss">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                 <a href="<c:url value='/checkInto' />" class="text-decoration-none">
                                	<button class="btn btn-outline-primary">refresh</button>
                                 </a>
                                    <h2 class="m-0 font-weight-bold text-primary">員工打卡系統</h2>
                                </div>
                                <div class="card-body ">
                                
                                      <div class="gowork ">
							            <h5 id="showdate"></h5>
							            <h1 id="showbox"></h1>
							            <br> <br> <br> <br> <br> <br> <br>
							            <br> <br> <br>
        							   </div>
                                </div>
                            </div>

                            <!-- Custom Font Size Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">請確認上班型態是否正確</h6>
                                </div>
                                <div class="card-body gowork">
								     <button type="button" class="work btn btn-primary" id="work" name="checkIn">上班打卡</button>
								     <button type="button" class="offwork btn btn-primary" id="offwork" name="checkOut"
								                style="display: none;">下班打卡</button><br><br>
        								                        
                                     <div class="switch">
							            <input class="switch-checkbox" id="switchID1" type="checkbox" name="switch-checkbox"> 
							            <label class="switch-label" for="switchID1"> <span class="switch-txt" turnOn="下班" turnOff="上班"></span>
							            <span class="switch-Round-btn"></span>
							            </label>
        							</div>
                                </div>
                            </div>

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
                        <div class="col-lg-4 mycss ">

                            <!-- Grayscale Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">我的出勤紀錄
                                    </h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">展開近五筆</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered">
									<tr><th>日期</th><th>上班時間</th><th>下班時間</th><th>上班是否遲到</th><th>下班是否準時</th><th>是否需補簽到</th></tr>
										<c:forEach var='checksystem' items='${Checksystem}'>
										  <tr>
										  	 <td>${fn:substring(checksystem.createTime,0, 10)}</td>
										     <td>${fn:substring(checksystem.checkInTime,11,19)}</td>
										     <td>${fn:substring(checksystem.checkOutTime,11,19)}</td>
										     <td>
										     	<c:choose>
										     	  <c:when test="${checksystem.isLateCheckIn == 'Y'}" > 是</c:when>
										     	  <c:when test="${checksystem.isLateCheckIn == 'N'}" > 否</c:when>
						       					</c:choose>
										     </td>
										     <td> 
										     	<c:choose>
										     	  <c:when test="${checksystem.isOnTimeCheckOut == 'Y'}" > 是</c:when>
										     	  <c:when test="${checksystem.isOnTimeCheckOut == 'N'}" > 否</c:when>
						       					</c:choose>
						       				 </td>
						       				 <td>
						       				 <c:choose>
										     	  <c:when test="${checksystem.isNeedRepair == 'Y'}" ><button>補簽到</button></c:when>
										     	  <c:when test="${checksystem.isNeedRepair == 'N'}" >補簽到</c:when>
						       				</c:choose>
						       				 </td>
										     
										 </tr>    
										</c:forEach>
								  </table>
								  <a href="<c:url value='/empCheck' />" class="text-decoration-none">
		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button>
		                          </a>
								  </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    
             			

            <jsp:include page="../footer.jsp"></jsp:include>
            
            <!-- footer刪掉 start -->

               

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

    <!-- footer刪掉 end -->

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>