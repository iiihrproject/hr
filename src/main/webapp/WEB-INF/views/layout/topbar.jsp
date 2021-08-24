<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



		<!-- Sidebar -->
		<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">
		
		    <!-- Sidebar - Brand -->
		    <div class="sidebar-brand-icon">
		    </div>
		    <div class="sidebar-brand-text mx-auto">
		        <a href="<c:url value='/index' />">
		        <img id="logo" src="<c:url value='/img/logo_frame.png' />"></a>
		    </div>
		
		    <!-- Divider -->
		    <hr class="sidebar-divider my-0">
		
		    <!-- Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link" href="<c:url value='/index' />">
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
							<img class="img-profile rounded-circle" src="<c:url value='/img/undraw_profile.svg' />">
						</a>
						<!-- Dropdown - User Information -->
						<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"	aria-labelledby="userDropdown">
							<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
								<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								登出
							</a>
						</div>
					</li>
				</ul>
			</nav>
			<!-- End of Topbar -->
<!-- Logout Modal-->
<div class="modal fade text-center" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title mx-auto" id="exampleModalLabel">確定要登出？</h5>
				<!-- <button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
				<!-- <span aria-hidden="true">×</span> -->
				<!-- </button> -->
			</div>
			<div class="modal-body">
				<span>提醒：未儲存之工作項目將會遺失</span><br/> <span>請確認已完成當前工作，再選擇【登出】。</span>
			</div>
			<div class="modal-footer justify-content-center">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">取消</button>
				<a class="btn btn-primary" href="<c:url value='/logout' />">登出</a>
			</div>
		</div>
	</div>
</div>