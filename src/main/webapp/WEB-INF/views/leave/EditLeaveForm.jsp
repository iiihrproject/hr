<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Leave Of Absence Form</title>
<!-- Rounded Input -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- myCss -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkform.css">
<style>
</style>
</head>

<body>
	<div class="containerform">
		<jsp:useBean id="leave" scope="request"
			class="com.hr.leaveapplication.model.LeaveBean" />
		<h1>請假申請表 編輯</h1>
		<form method="post" action="${pageContext.request.contextPath}/LeavaApplication/Update">
			<div>
				<span>申請人：</span> <span class="w3-codespan">${leave.empNo }</span>
				<span style="position: absolute; right: 0;"> <span>申請日：</span><span
					id="requestDate"><%=leave.getRequestDate()%></span><span> 申請編號：${leave.applicationNo}</span></span>
			</div>
			<label for="reason">請假事由</label>
			<div id="reasonresult">${leave.reason}</div>
			<select class="w3-input w3-border w3-round-large" autofocus
				id="reason" name="reason">
				<option value="tips">如須修改請選擇</option>
<!-- 				<option value="1" -->
<%-- 					<%= "1".equals(leave.getReason_id()) ? "selected" : ""%>>病假</option> --%>
<!-- 				<option value="2" -->
<%-- 					<%= "2".equals(leave.getReason_id()) ? "selected" : ""%>>事假</option> --%>
<!-- 				<option value="3" -->
<%-- 					<%="3".equals(leave.getReason_id()) ? "selected" : ""%>>特休</option> --%>
<!-- 				<option value="4" -->
<%-- 					<%="4".equals(leave.getReason_id()) ? "selected" : ""%>>公假</option> --%>
<!-- 				<option value="5" -->
<%-- 					<%="5".equals(leave.getReason_id()) ? "selected" : ""%>>產假</option> --%>
<!-- 				<option value="6" -->
<%-- 					<%="6".equals(leave.getReason_id()) ? "selected" : ""%>>陪產假</option> --%>
<!-- 				<option value="7" -->
<%-- 					<%="7".equals(leave.getReason_id()) ? "selected" : ""%>>婚假</option> --%>
<!-- 				<option value="8" -->
<%-- 					<%="8".equals(leave.getReason_id()) ? "selected" : ""%>>喪假</option> --%>
<!-- 				<option value="9" -->
<%-- 					<%="9".equals(leave.getReason_id()) ? "selected" : ""%>>育嬰假</option> --%>
<!-- 				<option value="10" -->
<%-- 					<%="10".equals(leave.getReason_id()) ? "selected" : ""%>>生理假</option> --%>
<!-- 				<option value="11" -->
<%-- 					<%="11".equals(leave.getReason_id()) ? "selected" : ""%>>無薪假</option> --%>
			</select>
			<label for="starDate">起始日期、時間</label>
			<input type="date" class="myinput w3-border w3-round-large"
				id="starDate" name="startDate" required
				value="<%=leave.getStartDate()%>">
			<input type="time" class="myinput w3-border w3-round-large"
				name="startTime" required value="<%=leave.getStartTime()%>" step="900">
			<br>
			<label for="endDate">結束日期、時間</label>
			<input type="date" class="myinput w3-border w3-round-large"
				id="endDate" name="endDate" required
				value="<%=leave.getEndDate()%>">
			<input type="time" class="myinput w3-border w3-round-large"
				name="endTime" required value="${leave.endTime}" step="900">
			<br>
			<label for="comments">備註</label>
			<textarea class="w3-input w3-border w3-round-large" id="comments"
				name="comments" rows="2"><%=leave.getComments()%></textarea>
			<label for="hand-off">職務代理人</label>
			<input type="text" class="w3-input w3-border w3-round-large"
				id="hand-off" name="hand-off" value="<%=leave.getHandOff()%>">
			<input type="email" class="w3-input w3-border w3-round-large"
				name="hand-offemail" value="<%=leave.getHandOffEmail()%>">
			<label for="supportingDoc">相關檔案上傳</label>
			<input type="file" class="w3-input w3-border w3-round-large"
				id="supportingDoc" name="supportingDoc" multiple>
			<input type="submit"
				class="my-button w3-input w3-border w3-round-large w3-btn w3-button"
				value="修改" onclick="return confirm('確定要修改？');">
			<a href="${pageContext.request.contextPath}/LeavaApplication/GetList"
				class="my-button w3-input w3-border w3-round-large w3-btn w3-button">取消</a>
			<input type="hidden" name="applicationNo"
				value="<%= request.getParameter("applicationNo")%>" />
			</form>

			<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
			<script>
				
			</script>
	</div>
</body>

</html>