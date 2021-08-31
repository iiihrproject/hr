<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!-- Topbar -->
<nav
	class="navbar navbar-expand navbar-light bg-white topbar static-top shadow">
	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop"
		class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>
	<!-- Topbar Search -->
	<div class="narbar-brand">
		<h2 class="font-weight-bold mb-3">HR有限公司 人力資源系統</h2>
            <span class="text-dark">特休剩餘：<strong id="annivLDay"></strong>日</span><span class="text-danger warning"> (請於 <strong id="anniDate"></strong> 前使用完畢)</span><br/>
            <span class="text-dark">加班總計時數：【${sessionScope.sumHours}】小時&nbsp</span><span class="text-danger warning">(請注意加班時數是否正確)</span><br/>
            <span class="text-dark">加班剩餘時數：【${sessionScope.remainingHours}】小時&nbsp</span><span class="text-danger warning">(請注意剩餘時數)</span>
	</div>

	<!-- 0419 alert to do -->

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">
		<div class="topbar-divider d-none d-sm-block"></div>

		<!-- Nav Item - User Information -->
		<li class="nav-item dropdown no-arrow"><a
			class="nav-link dropdown-toggle" href="###" id="userDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <span
				class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.loginModel.getEmpNo()}</span>
				<img class="img-profile rounded-circle"
				src="<c:url value='/img/undraw_profile.svg' />">
		</a> <!-- Dropdown - User Information -->
			<div
				class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				<a class="dropdown-item" href="#" data-toggle="modal"
					data-target="#logoutModal"> <i
					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 登出
				</a>
			</div></li>
	</ul>
</nav>
<!-- End of Topbar -->
<!-- Logout Modal-->
<div class="modal fade text-center" id="logoutModal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title mx-auto" id="exampleModalLabel">確定要登出？</h5>
				<!-- <button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
				<!-- <span aria-hidden="true">×</span> -->
				<!-- </button> -->
			</div>
			<div class="modal-body">
				<span>提醒：未儲存之工作項目將會遺失</span><br /> <span>請確認已完成當前工作，再選擇【登出】。</span>
			</div>
			<div class="modal-footer justify-content-center">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">取消</button>
				<a class="btn btn-primary" href="<c:url value='/logout' />">登出</a>
			</div>
		</div>
	</div>
</div>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<script>
	let recruitD = new Date("${sessionScope.loginModel.employedDate}");
	let todayD = new Date();
	let annivD = new Date("${sessionScope.loginModel.employedDate}");
	annivD.setFullYear(new Date().getFullYear());
	
	diff = (annivD.setTime(annivD.getTime())-recruitD.setTime(recruitD.getTime()))/1000/60/60/24/365;
	annivLDay = Math.ceil(Math.round(diff))*7;
	$("#annivLDay").text(annivLDay);
	if(new Date > annivD){
		console.log("到職日：${sessionScope.loginModel.employedDate}, 年資周年紀念 已過去, 今年特休總額："+annivLDay+"天");
		annivD.setFullYear(annivD.getFullYear()+1);
	} else{
		console.log("到職日：${sessionScope.loginModel.employedDate}, 年資周年紀念 還沒到, 今年特休總額："+annivLDay+"天");
	}
	let due = annivD.toISOString().slice(0,10);
	$("#anniDate").text(due);
</script>