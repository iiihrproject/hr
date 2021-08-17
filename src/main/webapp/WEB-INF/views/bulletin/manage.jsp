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
    
    
    <!-- Custom styles for this page -->
    <link href="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.css' />" rel="stylesheet">
    
    <!-- jQuery導入 -->
    <script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
	<!-- 公布欄資料載入 -->
	<script>
	window.onload = function() {
	
		$("#dataTable tbody").on("click", "tr", function () {
	        	window.location = $(this).attr('href');
	        	return false;
		});

	};


		
	$(document).ready(function() {		
	    $('#dataTable').DataTable( {
	    	"lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
	        "ajax": {
	        "url":'<c:url value='/bulletinListMag'/>',
	        "dataSrc": "",
	        },
	        "order": [[ 0, "desc" ]],
	        "columns": [
	            { "data": "postno" },
	            { "data": "type" },
	            { "data": "title" },
	            { "data": "desText" ,
	            	"render": function (data, type, row) {
	            		let dText="";
	            		if(data!=null){
	            		if (data.length>8){
	            			dText = data.substr(0,7)+"...";
	            		} else {
	            			dText = data;
	            		}
	            		return dText;
	            		}else{
	            			return data;
	            		}
	                }},
	            { "data": "postDate" },
	            { "data": "exp" },
	            { "data": "quotatype" },
	            { "data": "quota" ,
	            	"render": function (data, type, row) {
	            		if(row.quotatype=="不限"){
	            		return "*";
	            		}else{
	            			return data;
	            		}
	                }},
	            { "data": "quota" ,
		            	"render": function (data, type, row) {
		            		if(row.quotatype=="不限"){
		            		return "*";
		            		}else{
		            			return data;
		            		}
		                }},
	            { "data": "quota" },
	            { "data": "postStatus",
	            	"render": function (data, type, row, meta) {
	            		let status="";
	            		if (row.postDate<=td && row.exp>=td) {
	            			status += "刊登中";
	            			}else if(row.postDate>td){
	            				status += "未刊登";
	            			}else if (row.exp<td) {
	            				status += "已過期";
	            			}else{status +="其他";}
	            		
	            		return status;
	                }},
	        ],
	    
            createdRow: function (row, data, index) {
                if (data.postDate<=td && data.exp>=td) {
                   $('td', row).eq(10).css('color', 'green')
                }
            }, 
            
            rowCallback: function(row, data){
            	console.log("連結：<c:url value='/bulletinDetailMsg'/>?postno=" + data.postno );
            	$(row).attr("href","<c:url value='/bulletinDetailMsg'/>?postno=" + data.postno);
            },
            
            "language": {
            	"emptyTable": "表中資料為空",
                "lengthMenu": "顯示 _MENU_ 則貼文",
                "zeroRecords": "沒有符合的貼文",
                "info": "顯示第 _START_ 至 _END_ 則貼文，共 _TOTAL_ 則",
                "infoEmpty": "顯示第 0 至 0 則貼文，共 0 則",
                "infoFiltered": "(由 _MAX_ 則貼文過濾)",
                "search": "搜尋貼文:",
                "oPaginate": {
                    "sFirst": "首頁",
                    "sPrevious": "上一頁",
                    "sNext": "下一頁",
                    "sLast": "末頁"
                 },
              }
            
	    } );
	    
           		
                   
	} )
		//);
	
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.loginModel.getEmpNo()}</span>
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
                    <h1 class="h3 mb-2 text-gray-800">公佈欄管理</h1>
                    <p class="mb-4">刊登貼文請依循公司規定</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold">貼文列表</h6>
                            <!--人資公布欄管理區-->
                            <div class="dropdown no-arrow">
                                <a href="#" class="btn btn-outline-primary btn-icon-split btn-sm" id="navbarDropdown" 
                                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="text">新增貼文</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <a class="dropdown-item" href="<c:url value='###' />">公告</a>
                                    <a class="dropdown-item" href="<c:url value='bulletinEventInsert' />">活動</a>
                                </div>
                            </div>
                             <!--人資公布欄管理區end-->
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-hover-color" id="dataTable" width="100%" cellspacing="0" style="color:#43454e">
                                    <thead>
                                        <tr>
                                            <th>NO.</th>
                                            <th>類型</th>
                                            <th>主旨</th>
                                            <th>內容</th>
                                            <th>刊登日期</th>
                                            <th>有效日期</th>
                                            <th>名額</th>
                                            <th>可報名額</th>  
                                            <th>已報名額</th>
                                            <th>瀏覽人數</th>
                                            <th>狀態</th>
                                                                                         
                                        </tr>
                                    </thead>
                                   <tbody id="BulletinMagList">
                                       
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
    <script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>
    <script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

    <!-- Core plugin JavaScript-->
    <script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

    <!-- Custom scripts for all pages-->
    <script src="<c:url value='/js/sb-admin-2.min.js' />"></script>
    
    <!-- Page level plugins -->
    <script src="<c:url value='/vendor/datatables/jquery.dataTables.min.js' />"></script>
    <script src="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.js' />"></script>

    <!-- Page level custom scripts -->
    <%-- <script src="<c:url value='/js/demo/datatables-demo.js' />"></script> --%>

    <!-- Page level plugins -->
    <!-- <script src="vendor/chart.js/Chart.min.js"></script> -->

    <!-- Page level custom scripts -->
    <!-- <script src="js/demo/chart-area-demo.js"></script> -->
    <!-- <script src="js/demo/chart-pie-demo.js"></script> -->
    
    
</body>

</html>