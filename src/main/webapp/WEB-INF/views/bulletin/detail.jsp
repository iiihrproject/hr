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
    
    <!-- icon載入 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
    <!-- 留言資料載入 -->
	<script>
	var hasError = false;
	
	window.onload = function() {

		var mDataArea = document.getElementById("BulletinMessageArea");

		var xhr = new XMLHttpRequest();	
		xhr.open("GET", "<c:url value='/bulletinGetMsg'/>?postno=" + ${bulletin.postno});
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				mDataArea.innerHTML = processBulletinMsg(xhr.responseText);
			}
		}

    
	function processBulletinMsg(jsonString) {
		
		let posts = JSON.parse(jsonString);
		let segment = "";
		let le=0;
		if(posts.length==0){
			segment += "<tr>";
			segment += "<td colspan='3'>尚無留言</td>"
			segment += "</tr>";
		}
		else if (posts.length>10) {
			le = 10;
			}
		else { 
			le = posts.length;
		}
		for (let n = 0; n < le; n++) {
			let BulMessage = posts[n];
			
			segment += "<tr>";
			segment += "<td>"+ BulMessage.message +"</td>";
			segment += "<td>"+ BulMessage.empNo +"</td>";
			if(BulMessage.empNo==`${sessionScope.loginModel.getEmpNo()}`){
				let link = "<c:url value='/bulletinDelMsg' />?postno=" + BulMessage.id;
				segment += "<td>"+ BulMessage.messageDate +"&emsp;";
				segment += "<a href='"+link+"' style='color:#ac2c20'>刪除</a></td>";
			}else{
				segment += "<td>"+ BulMessage.messageDate +"</td>";
			}
			segment += "</tr>";
		}
		return segment;
		
	}

	let sendMsg = document.getElementById("sendMsg");
	sendMsg.onclick = function(){

		let messageValue = document.getElementById("message").value;
		
		//新增前驗證資料
		var divResult = document.getElementById('resultMsg');
        let div0 = document.getElementById('result0c');
    	
        if (!messageValue){
			setErrorFor(div0, "請輸入留言");
   		} 	else {
      		div0.innerHTML = "";
   		}

		
		let obj = {
		   "postno": ${bulletin.postno},
		   "message": messageValue,
		   "empNo": `${sessionScope.loginModel.getEmpNo()}`,
		   "messageDate": td,
		};
		
		console.log(obj);
		
		let xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/insertMessage'  />";
		console.log(url);
		xhr2.open("POST", url);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(obj));
		//依結果印出成功或失敗
		xhr2.onreadystatechange = function(){
			if (xhr2.readyState == 4 && xhr2.status == 200){
				let result 		= JSON.parse(xhr2.responseText);
				let divResult = document.getElementById('resultMsg');
				if (result.success) {
					divResult.innerHTML = "<font color='GREEN'>" + result.success + "</font>";
		            let link = "<c:url value='/bulletinDetail' />?postno=" + ${bulletin.postno};
		            $("#resultbutton").html("<a class='btn btn-primary' href="+link+">確認</a>");
		  		} else  if(result.fail){
		            divResult.innerHTML = "<font color='red' >" + result.fail + "</font>";
		  		} else {
		  			divResult.innerHTML = "<font color='red' >" + result.failnull + "</font>";
		  		}
				
			}
		}
	}
	
	$("#like").click(function(){
		
		$("#like").toggleClass("btn-outline-heart")
		$("#like").toggleClass("btn-heart")
    });
	
	
	}
	
	
function setErrorFor(input, message){
	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
    hasError = true;
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

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary"></h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <tbody>
                                    	<tr>
                                            <td style="color:black;"><h5 class="m-0 font-weight-bold" style="color:#483ea1">${bulletin.title}</h5></td>
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
                                    		<a href="#" class="btn btn-info btn-icon-split btn-sm" id="apply">
                                        	<span class="text">報名</span>
                                    		</a>
                                    		&nbsp;&nbsp;
                                        	<span class="icon btn-outline-heart" id="like">
                                            <i class="bi bi-suit-heart-fill" style="font-size:24px; vertical-align:middle"></i>
                                        	</span>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- 留言區 -->
                            
                    		<div class="card mb-4 py-3 border-left-warning">
                    		<!-- fcfaf4 -->
                    			<div class="card-body">
                    				<div class="table-responsive">
                    				
                    					<table class="" width="100%" cellspacing="0" style="border: 0px solid #fff;">
                    						<tr>
                                    			<td>
                                    			
                                    			<input type="text" id="message" name="title" class="form-control" maxlength="30" placeholder="請輸入留言......"/>
                                    			
                                    			</td>
                                        		<td>&nbsp;
                                        		<a href="#" class="btn btn-success btn-icon-split btn-sm" id="sendMsg" data-toggle="modal" data-target="#massgaeModal">
                                        		<span class="text">留言</span>
                                    			</a>
                                    			</td>
                                    		</tr>
                                    		<tr>
                                    			<td><span id="result0c" class="form-text"></span></td>
                                    		</tr>
                                		</table>
                                		<br>
                    				
                                		<table class="table table-bordered" width="100%" cellspacing="0">
                                   			<thead>
                                    			<tr>
                                    				<th width=55%>留言</th>
                                    				<th width=20%>留言者</th>
                                    				<th width=25%>留言日期</th>
                                    			</tr>
                                    		</thead>
                                    				
                                   			<tbody id="BulletinMessageArea" class="">
                                    		</tbody>
                                		</table> 
                                		
                             		</div>   
                    			</div>
                    		</div>
                    		
                    		
                    		<!-- 留言區 End-->
                        </div>
                    </div>
                    <!-- DataTales Example End-->
                    
                    
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
    <!-- Logout Modal End-->
    
    <!-- Result Modal-->
    <div class="modal fade text-center" id="massgaeModal" tabindex="-1" role="dialog" aria-labelledby="massgaeModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="resultModalLabel">留言</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto"><font color='red' ></font></span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="resultbutton">確認</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Result Modal End-->

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


</body>

</html>