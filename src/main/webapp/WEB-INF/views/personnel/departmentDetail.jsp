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
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    <script>
		window.onload = function(){
    		//let submit = $("#edit");
    		let segment="";
    		let xhr = new XMLHttpRequest();
    		xhr.open("GET", "<c:url value='/departmentDetail'/>", true);
    		xhr.send();	
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {	
					let tableInfo = JSON.parse(xhr.responseText);
					
					segment += "<table class='table table-bordered table-hover table-hover-color dataTable no-footer'>";
					segment += "<thead><tr height='50px'><th>部門編號</th><th>部門名稱</th><th>部門主管編號</th><th>部門主管名稱</th><th colspan='2' align='center'>更換部門主管(請輸入員工編號)</th></tr></thead><tbody>";
						segment += "<tr height='50px'><td id='departmentNumberKey" + key + "'>" + tableInfo[key].departmentNumber + "</td><td id='departmentNameKey" + key + "'>" + tableInfo[key].name + "</td><td>" + tableInfo[key].managerEmpId + "</td><td >" + tableInfo[key].managerName + "</td><td><input type='text' maxlength='15' id='managerEmpIdKey" + key + "'/></td><td><button onclick='edit(" + key + ")'>確認</button></td></tr>";
						
					}
					segment += "</tbody></table>";
					
					$("#bgcolor").html(segment);
				}
        	}
		}
		/*
		This responds the change immediately solidly without doublechecking
		*/
		function edit(key){
			let departmentNumber = document.getElementById("departmentNumberKey" + key).innerHTML;
			let departmentName = document.getElementById("departmentNameKey" + key).innerHTML;
			let newManagerId = document.getElementById("managerEmpIdKey" + key).value;
			let newSegment="";
			let obj = {
    				'departmentNumber': departmentNumber,	
    				'name': departmentName,	
    				'managerEmpId': newManagerId
    			}
    		let json = JSON.stringify(obj);
			let xhrInner = new XMLHttpRequest();
			xhrInner.open("PUT", "<c:url value='/departmentManagerIdUpdate'/>", true);
			xhrInner.setRequestHeader("Content-Type", "application/json;charset=UTF-8"); 		
    		xhrInner.send(json);
    		xhrInner.onreadystatechange = function() {
				if (xhrInner.readyState == 4 && xhrInner.status == 200) {	
					let tableInfo = JSON.parse(xhrInner.responseText);
					
					newSegment += "<table border='solid' witdh='1' class='table table-bordered table-hover table-hover-color dataTable no-footer'>";
					newSegment += "<thead><tr height='50px'><th>部門編號</th><th>部門名稱</th><th>部門主管編號</th><th>部門主管名稱</th><th colspan='2' align='center'>更換部門主管(請輸入員工編號)</th></tr></thead><tbody>";
					for(const key in tableInfo){
						newSegment += "<tr height='50px'><td id='departmentNumberKey" + key + "'>" + tableInfo[key].departmentNumber + "</td><td id='departmentNameKey" + key + "'>" + tableInfo[key].name + "</td><td>" + tableInfo[key].managerEmpId + "</td><td >" + tableInfo[key].managerName + "</td><td><input type='text' maxlength='15' id='managerEmpIdKey" + key + "'/></td><td><button onclick='edit(" + key + ")'>確認</button></td></tr>";
						
					}
					newSegment += "</tbody></table>";
					
					$("#bgcolor").html(newSegment);
				}
        	}
		}
		

    </script>

</head>

<body id="page-top">

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
                <a class="nav-link collapsed" href="<c:url value='/pages' />">
                    <i class='fas fa-clock' style='font-size:22px'></i>
                    <span id="listname">出勤管理</span>
                </a>
            </li>
            <li class="nav-item">            
                <a class="nav-link collapsed" href="<c:url value='/personnel' />">
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.loginModel.getEmpNo()}</span>
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
              </div>
            <!-- End of Topbar -->
            <!-- Begin Page Content -->
                <div class="container-fluid h-75">
                    <div class="row fornone">                
                        <div class="col-12 col-md-6 mb-4">
                            <div class="card">
                                <div class="card-body">                                  
                                </div>
                            </div>
                        </div>                
                        <div class="col-12 col-md-6 mb-4">
                            <div class="card">
                                <div class="card-body">                                  
                                </div>
                            </div>
                        </div>
                    </div>
            <!-- /.container-fluid --> 
            <!-- form start -->        
			<div class="container-fluid">
				<span>
					<a href="<c:url value='/addNewDepartment'/>">
						<button>新增</button>
					</a>
				</span>
				<div id="bgcolor">
				</div>             
            </div>
<!-- form end -->     
            <!-- End of Main Content -->
                    <div class="row fornone">                
                        <div class="col-12 col-md-6 mb-4">
                            <div class="card">
                                <div class="card-body">                                  
                                </div>
                            </div>
                        </div>                
                        <div class="col-12 col-md-6 mb-4">
                            <div class="card">
                                <div class="card-body">                                  
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
                    <a class="btn btn-primary" href="<c:url value='/logout' />">登出</a>
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