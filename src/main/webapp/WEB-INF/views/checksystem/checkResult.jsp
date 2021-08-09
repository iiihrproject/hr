<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>員工打卡結果</title>
<style>
*{
text-align:center;
font-family:Microsoft JhengHei;
background-color:#7973AE;
color:white}

.pageNo{
	text-decoration:none;
	margin-right: 10px;
	background-color: darkgray;
}

</style>

</head>
<body>
<h1>員工出勤明細</h1>
		<table border='1' align='center' >
			<tr><th>日期</th><th>上班時間</th><th>下班時間</th><th>上班是否遲到</th><th>下班是否準時</th></tr>
				<c:forEach var='checksystem' items='${Checksystem}'>
				  <tr>
				     <td>${fn:substring(checksystem.createTime,0,10)}</td>
				     <td>${fn:substring(checksystem.checkInTime,11,19)}</td>
				     <td>${fn:substring(checksystem.checkOutTime,11,19)}</td>
				     <td>
				     	<c:choose>
				     	  <c:when test="${checksystem.isLateCheckIn == 'Y'}" > 是</c:when>
				     	  <c:when test="${checksystem.isLateCheckIn == 'N'}" > 否</c:when>
       					</c:choose>
				     </td>
				     <td> 
				     	<c:choose>
				     	  <c:when test="${checksystem.isOnTimeCheckOut == 'Y'}" > 是</c:when>
				     	  <c:when test="${checksystem.isOnTimeCheckOut == 'N'}" > 否</c:when>
       					</c:choose>
       				 </td>
				     
				 </tr>    
				</c:forEach>
		  </table>
		<div>
		<c:forEach var="i" begin="1" end="${ totalPage }" varStatus="loop">
            	<a href="<c:url value='/findCheckByEmp'/>?pageNo=${i}" class="pageNo" >${i}</a>
        </c:forEach>
        
        </div>

<br>
<a href="http://localhost:8080/HR/frame/index.html"><button type="button" class="btn btn-primary">Return</button></a>



</body>
</html>