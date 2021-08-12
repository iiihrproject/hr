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
                <!-- 0419連結待修改 -->
                <a class="nav-link collapsed" href="<c:url value='/pages' />">
                    <i class='fas fa-clock' style='font-size:22px'></i>
                    <span id="listname">出勤管理</span>
                </a>
            </li>
            <li class="nav-item">            
                <!-- 0419連結待修改 -->
                <a class="nav-link collapsed" href="<c:url value='/pages' />">
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
                            <span class="text-dark">特休剩餘時數：{}小時&nbsp</span><span class="text-danger warning">(請於 ${日期} 前使用完畢)</span><br/>
                            <span class="text-dark">加班剩餘時數：{}小時&nbsp</span><span class="text-danger warning">(請注意到期時間)</span>
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
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    登出
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->

		

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold">編輯貼文</h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <tbody>
                                    	<tr>
                                            <td style="color:black;"><h5 class="m-0 font-weight-bold" style="color:#4c3fc4">${bulletin.title}</h5></td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="color:black">${bulletin.description}</td>
                                        </tr>
                                        
                                        <c:choose>
                                        <c:when test="${bulletin.file1==null}">
                                        </c:when>
                                        <c:otherwise>
                                        <tr>
                                            <td><img src="<c:url value='/bulletin/getImage?postno=${bulletin.postno}'/>" style="max-width:500px"/></td>
                                        </tr>
                                        </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                        <c:when test="${bulletin.quotatype == '不限'}">
                                        </c:when>
                                        <c:otherwise>
                                        <tr>
                                            <td>已報名人數：10&nbsp;／&nbsp;可報名人數：${bulletin.quota}</td>
                                        </tr>
                                        </c:otherwise>
                                        </c:choose>
                                        <tr>
                                            <td>刊登日期：${bulletin.postDate}</td>
                                        </tr>
                                        <tr>
                                            <td>
                                            <a href="#" class="btn btn-secondary btn-icon-split btn-sm" onclick="history.back()">
                                        	<span class="text">回前頁</span>
                                    		</a>
                                    		&nbsp;
                                    		<c:choose>
                                        	<c:when test="${bulletin.type == '活動'}">
                                        	<a href="<c:url value='/bulletinEditEventPage?postno=${bulletin.postno}'/>" class="btn btn-warning btn-icon-split btn-sm" style="color:black">
                                        	<span class="text">修改</span>
                                    		</a>
                                        	</c:when>
                                       	 	<c:otherwise>
                                        	<a href="#" class="btn btn-warning btn-icon-split btn-sm" style="color:black">
                                        	<span class="text">修改</span>
                                    		</a>
                                        	</c:otherwise>
                                        	</c:choose>
                                    		&nbsp;
                                    		<c:choose>
                                        	<c:when test="${bulletin.type == '活動'}">
                                        	<a href="#" class="btn btn-danger btn-icon-split btn-sm" data-toggle="modal" id="sendDel"  data-target="#delModal">
                                        	<span class="text">刪除</span>
                                    		</a>
                                        	</c:when>
                                       	 	<c:otherwise>
                                        	<a href="#" class="btn btn-danger btn-icon-split btn-sm">
                                        	<span class="text">刪除</span>
                                    		</a>
                                        	</c:otherwise>
                                        	</c:choose>
                                    		
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

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
                    <a class="btn btn-primary" href="<c:url value='login.jsp' />">登出</a>
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
    
    <!-- Page level plugins -->
    <!-- <script src="<c:url value='/vendor/datatables/jquery.dataTables.min.js' />"></script>
    <script src="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.js' />"></script> -->
    
    <!-- Result Modal-->
    <div class="modal fade text-center" id="delModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="resultModalLabel">刪除貼文</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto">請確認是否刪除貼文</span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button href="<c:url value='/bulletin/DelEventPage?postno=${bulletin.postno}'/>" class="btn btn-danger" type="button" data-dismiss="modal" id="comfirmBut">確認</button>
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="cancelBut">取消</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Result Modal End-->


</body>

</html>