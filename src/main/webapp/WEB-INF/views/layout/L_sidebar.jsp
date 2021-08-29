<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Sidebar -->
<ul class="navbar-nav sidebar sidebar-dark accordion"
	id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<div class="sidebar-brand-icon"></div>
	<div class="sidebar-brand-text mx-auto">
		<a href="<c:url value='/index' />"> <img id="logo"
			src="<c:url value='/img/logo_frame.png' />"></a>
	</div>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Pages Collapse Menu -->
	<li class="nav-item"><a class="nav-link"
		href="<c:url value='/index' />"> <i class='fas fa-home'
			style='font-size: 1.5rem'></i> <span style='font-size: 18px'>主頁</span></a></li>
	<li class="nav-item"><a class="nav-link collapsed"
		href="<c:url value='/pages' />"> <i class='fas fa-clock'
			style='font-size: 1.5rem'></i> <span id="listname" style='font-size: 18px'>出勤管理</span>
	</a></li>
	<li class="nav-item"><a class="nav-link collapsed"
		href="<c:url value='/personnel' />"> <i class='fas fa-user-tie'
			style='font-size: 1.5rem'></i> <span id="listname" style='font-size: 18px'>人員管理</span>
	</a></li>
</ul>
<!-- End of Sidebar -->