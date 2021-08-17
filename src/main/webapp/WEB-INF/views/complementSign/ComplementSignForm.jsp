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
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	
    <!-- overtime css -->
    <link rel='stylesheet' href="<c:url value='/css/overTime.css' />" type="text/css" />
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
	<script type="text/javascript">
	$(document).ready(function(){
		
		var sendData = document.getElementById("sendData");
		sendData.onclick = function(){
			
			var dateValue = $('#date').val();
			var typeValue = $("select[name='Type']").val();
			var reasonValue = $('#reason').val();
			
			var xhr = new XMLHttpRequest();
			xhr.open("POST","<c:url value='/saveEmpComplementSign' />", true);
			var jsonPendingComplementSign={
				"appliedDate" : dateValue,
				"type" : typeValue,
				"reason" : reasonValue
			}
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify(jsonPendingComplementSign));
	  		xhr.onreadystatechange = function() {
	  			if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201) ) {
		  			window.location.href = "<c:url value='/xxx'/>";
		  			
	  			}
			}
		}	
		
		$(".slide_toggle").click(function () {
		    $(this).next().slideToggle();
		});
		
	})
	
	
	</script>
	
</head>

<body id="page-top"  >

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
                
             <div class="row">

                        <!-- First Column -->
                        <div class="col-lg-4 overtime">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">員工補簽系統</h2>
                                </div>
                                <div class="card-body ">
                                
                                    <fieldset class="f1">
										<legend>員工補簽申請表</legend>
										
										<div class="form-group">
											<label for="date" class="t1">申請補簽日期:</label> <input type="datetime-local"
												class="form-control form1" id="date" name="appliedDate">
										</div>
								
								<!--         <div class="form-group"> -->
								<!-- 			<label for="time" class="t1">申請補簽時間:</label> <input type="time" -->
								<!-- 				class="form-control form1" id="time" name="appliedTime"> -->
								<!-- 		</div> -->
								
										<div class="form-group">
											<label for="dep" class="t1">補簽類型:</label> 
								            <select name = "Type" id = type>
								                <option value= "CheckIn" >上班
								                </option>  
								                <option value= "CheckOut">下班
								                </option>  
								            </select>  
										</div>
										<div class="form-group">
											<label for="Cause" class="t1">補簽事由:</label> <input type="text"
												class="form-control form1" id="reason" name="reason">
										</div>
									</fieldset>
									<div class="d2">
										<button type="button" class="btn btn-primary" id='sendData'>送出</button>
									</div>
                                </div>
                            </div>

                            <!-- Custom Font Size Utilities -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">請確認上班型態是否正確</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body gowork"> -->
<!-- 								    <fieldset class="f2"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label for="Remarks" class="t1">備註:</label> <input type="text" -->
<!-- 												class="form-control form2" id="Remarks" name="Remarks"> -->
<!-- 										</div> -->
<!-- 									</fieldset> -->
<!-- 									<br> -->
<!-- 									<div class="d2"> -->
<!-- 										<button type="button" class="btn btn-primary" id='sendData'>送出</button> -->
<!-- 									</div> -->
<!--                                 </div> -->
<!--                             </div> -->

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
                        <div class="col-lg-4  overtime">

                            <!-- Grayscale Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">補簽申請紀錄</h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">展開近五筆</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered">
									<tr>
									<th>申請日期</th>
<!-- 									<th>姓名</th> -->
									<th>部門</th>
									<th>職位</th>
									<th>加班日期</th>
									<th>加班類型</th>
									<th>加班時數</th>
									<th>審核狀態</th>
									</tr>
										<c:forEach var='pending' items='${overtimePartPending}'>
										  <tr>
										  	 <td>${fn:substring(pending.dateOfApplication,0, 10)}</td>
<%-- 										  	 <td>${pending.empName}</td>	 --%>
										  	 <td>${pending.department}</td>
										  	 <td>${pending.position}</td>			
										  	 <td>${fn:substring(pending.overTimeDate,0, 10)}</td>		
										  	 <td>${pending.overtimeCategory}</td>
										     <td>${pending.overTimeHours}</td>	
										     <td>${pending.result}</td>	
										 </tr>    
										</c:forEach>
								  </table>
								  <a href="<c:url value='/employeeQuery' />" class="text-decoration-none">
		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button>
		                          </a>
								  </div>
                                </div>
                            </div>
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

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>