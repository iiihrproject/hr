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
                <!-- End of Topbar -->
                
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


                    <div class="row h-25">
                
                        <div class="col-12 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">左上</div>                                          
                                            <!-- 模板一：module(有不同模塊可用標頭搜尋程式碼區塊) -->
                                            <a href="<c:url value='/editPersonalInfo' />" class="text-decoration-none">
                                                <div class="h4 mb-0 font-weight-bold text-center">編輯個人資料</div>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                      </div>
                    
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