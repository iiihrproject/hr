<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<!--     載入 Bootstrap -->
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	
    <!-- overtime css -->
    <link rel='stylesheet' href="<c:url value='/css/overTime.css' />" type="text/css" />
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
	<script type="text/javascript">
	$( document ).ready(function() {
	    

		var sendData = document.getElementById("sendData");
		sendData.onclick = function(){
			
			alert($('#empname').val());
			
			var empnameValue = $('#empname').val();  
			var dateValue = $('#date').val();
			var depValue = $('#dep').val();
			var posValue = $('#pos').val();
			var otCategoryValue = $('input[name=Overtime_category]:checked').val()
			var overtimeDateValue = $('#OvertimeDate').val();
			var stimeValue = $('#stime').val();
			var endtimeValue = $('#endtime').val();
			var causeValue = $('#Cause').val();
			var remarksValue = $('#Remarks').val();
			
			var xhr1 = new XMLHttpRequest();
			xhr1.open("POST", "<c:url value='/saveOvertime' />", true);
			var jsonOverTimePending = {
					"empName": empnameValue, 	
					"dateOfApplication": dateValue,
					"department": depValue,
					"position": posValue,
					"overtimeCategory": otCategoryValue,
					"overTimeDate": overtimeDateValue,
					"startingTime": stimeValue,
					"endingTime": endtimeValue,
					"reason": causeValue,
					"remarks": remarksValue
		   		}
			xhr1.setRequestHeader("Content-Type", "application/json");
	  		xhr1.send(JSON.stringify(jsonOverTimePending));
	  		xhr1.onreadystatechange = function() {
				// 伺服器請求完成
				if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201) ) {
		  			window.location.href = "<c:url value='/xxx'/>";
		  			
		  			
				}
	  		}
			
		}
		
		
		$(".slide_toggle").click(function () {
		    $(this).next().slideToggle();
		});
		

	});
	
	
	</script>
	
</head>

<body id="page-top"  >

    <jsp:include page="../header.jsp"></jsp:include>
                <!-- End of Topbar -->
                
             <div class="row">

                        <!-- First Column -->
                        <div class="col-lg-4 overtime">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">員工請假系統</h2>
                                </div>
                                <div class="card-body ">
                                
                                    <fieldset class="f1">
										<legend>員工請假申請表</legend>
								
										
										<div class="form-group">
											<label for="pos" class="t1">職稱:</label> <input type="text"
												class="form-control form1" id="pos" name="position">
										</div>
								
								
										<div class="form-group">
											<label class="t1">加班類型:</label>
										</div>
								
										<div class="form-group d1 ">
											<input type="radio" class="form-check-input" name="Overtime_category"value="平日加班" id="nday"> 
											<label for="nday" class="form-check-label radio_1">平日加班</label> 
											<input type="radio" class="form-check-input" name="Overtime_category" value="假日加班" id="holiday"> 
											<label for="holiday" class="form-check-label radio_1" >假日加班</label> 
											<input type="radio"class="form-check-input" name="Overtime_category" value="休假加班" id="break">
											<label for="break" class="form-check-label radio_1" >休假加班</label>
										</div>
										<div class="form-group">
											<label for="Overtime" class="t1">加班日期:</label> <input type="date"
												class="form-control form1" id="OvertimeDate" name="OvertimeDate">
										</div>
										<div class="form-group">
											<label for="stime" class="t1">開始時間:</label> <input type="time"
												class="form-control form1" id="stime" name="Starting time">
										</div>
										<div class="form-group">
											<label for="endtime" class="t1">結束時間:</label> <input type="time"
												class="form-control form1" id="endtime" name="Ending time">
										</div>
										<div class="form-group">
											<label for="Cause" class="t1">加班事由:</label> <input type="text"
												class="form-control form1" id="Cause" name="reason">
										</div>
									</fieldset>
                                </div>
                            </div>

                            <!-- Custom Font Size Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary"></h6>
                                </div>
                                <div class="card-body gowork">
								    <fieldset class="f2">
										<div class="form-group">
											<label for="Remarks" class="t1">備註:</label> <input type="text"
												class="form-control form2" id="Remarks" name="Remarks">
										</div>
									</fieldset>
									<br>
									<div class="d2">
										<button type="button" class="btn btn-primary" id='sendData'>送出</button>
									</div>
                                </div>
                            </div>

                        </div>

                        <!-- Second Column -->
<!--                         <div class="col-lg-4"> -->

<!--                             Background Gradient Utilities -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Custom Background Gradient Utilities -->
<!--                                     </h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="px-3 py-5 bg-gradient-primary text-white">.bg-gradient-primary</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-secondary text-white">.bg-gradient-secondary</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-success text-white">.bg-gradient-success</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-info text-white">.bg-gradient-info</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-warning text-white">.bg-gradient-warning</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-danger text-white">.bg-gradient-danger</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-light text-white">.bg-gradient-light</div> -->
<!--                                     <div class="px-3 py-5 bg-gradient-dark text-white">.bg-gradient-dark</div> -->
<!--                                 </div> -->
<!--                             </div> -->

<!--                         </div> -->

                        <!-- Third Column -->
                        <div class="col-lg-4  overtime">

                            <!-- Grayscale Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">加班申請紀錄</h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">展開近五筆</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered">
									<tr>
									<th>申請日期</th>
<!-- 									<th>姓名</th> -->
									<th>部門</th>
									<th>職位</th>
									<th>加班日期</th>
									<th>加班類型</th>
									<th>加班時數</th>
									<th>審核狀態</th>
									</tr>
										<c:forEach var='pending' items='${overtimePartPending}'>
										  <tr>
										  	 <td>${fn:substring(pending.dateOfApplication,0, 10)}</td>
<%-- 										  	 <td>${pending.empName}</td>	 --%>
										  	 <td>${pending.department}</td>
										  	 <td>${pending.position}</td>			
										  	 <td>${fn:substring(pending.overTimeDate,0, 10)}</td>		
										  	 <td>${pending.overtimeCategory}</td>
										     <td>${pending.overTimeHours}</td>	
										     <td>${pending.result}</td>	
										 </tr>    
										</c:forEach>
								  </table>
								  <a href="<c:url value='/employeeQuery' />" class="text-decoration-none">
		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button>
		                          </a>
								  </div>
                                </div>
                            </div>
                        </div>

                    </div>

            <!-- Footer -->
            <jsp:include page="../footer.jsp"></jsp:include>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>