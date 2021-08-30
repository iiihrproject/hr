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
	var hasError = false;
	$( document ).ready(function() {
	    
		$('#sendData').click(function () {
			hasError = false;
			var posValue = $('#pos').val();
			var otCategoryValue = $('input[name=Overtime_category]:checked').val()
			var overtimeDateValue = $('#OvertimeDate').val();
			var stimeValue = $('#stime').val();
			var endtimeValue = $('#endtime').val();
			var causeValue = $('#Cause').val();
			var remarksValue = $('#Remarks').val();
			var today = new Date();
			var date = Date.parse(overtimeDateValue);
			var stimeStrHours = stimeValue.substring(0,2);
			var endtimeStrHours = endtimeValue.substring(0,2);
			var stimeStrMin = stimeValue.substring(3,5);
			var endtimeStrMin= endtimeValue.substring(3,5);
			
			let span0 = $('#result0c');
			let span1 = $('#result1c');
			let span2 = $('#result2c');
			let span3 = $('#result3c');
			let span4 = $('#result4c');
			let span5 = $('#result5c');
			let span6 = $('#result6c');
			let span7 = $('#result7c');
			if (!posValue){
				setErrorFor(span0,"請輸入職位")
			} else{
				span0.html(" ");
			}
			if(date > today){
				setErrorFor(span2,"輸入錯誤:填寫日期不可大於當日");
			} else{
				span2.html(" ");
			}
			if(!overtimeDateValue){
				setErrorFor(span7,"加班日期不可為空白");
			}else{
				span7.html(" ");
			}
			if(!otCategoryValue){
				setErrorFor(span1,"請選擇加班類型");
			} else{
				span1.html(" ");
			}
			if(stimeStrMin != "00" && stimeStrMin != "30"){
				setErrorFor(span3,"輸入分鐘必須為0 或 30");
			} else{
				span3.html(" ");
			}
			if(endtimeStrMin != "00" && endtimeStrMin != "30"){
				setErrorFor(span4,"輸入分鐘必須為 0 或 30");
			}else{
				span4.html(" ");
			}
			if(endtimeStrHours < stimeStrHours){
				setErrorFor(span6,"結束時間不可小於開始時間");
			} else{
				span6.html(" ");
			}
			if(!causeValue){
				setErrorFor(span5,"請輸入加班原因");
			} else{
				span5.html(" ");
			}
			if(hasError){
				return false;
			}
			
			swal({
		        title: "加班申請!",
		        html: "確定送出嗎?!",
		        type: "question",
		        confirmButtonText: "確定",
		      	cancelButtonText: "取消",
		        showCancelButton: true//顯示取消按鈕
		    }).then(function (result) {
		        if (result.value) {
		            //使用者按下「確定」要做的事
		            
					var xhr1 = new XMLHttpRequest();
		 			xhr1.open("POST", "<c:url value='/saveOvertime' />", true);
		 			var jsonOverTimePending = {
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
		             
		         swal("新增成功!", "請等待主管簽核", "success");
// 		         window.location.href = "<c:url value='/checkInto'/>";
		         setTimeout('refresh()', 1500);
		     } else if (result.dismiss === "cancel"){
		          //使用者按下「取消」要做的事
		         swal("取消申請", "請再次確認", "error");
		     }//end else  
		  });//end then 
		
		    
		})

		
		$(".slide_toggle").click(function () {
		    $(this).next().slideToggle();
		});
		

	});
	
	
	function setErrorFor(input, message) {
		input.html("<font color='red' size='-2'>" + message + "</font>");
		hasError = true;
	}
	
	function refresh(){
		window.location.href = "<c:url value='/employeeOvertime'/>";
	}
	
	
	</script>
<!-- 	修改radio樣式 -->
	<style type="text/css">
	    .r1{
	    	margin-top: 10px;
	    }
	    
	    .l1{
	    	margin-right: 60px;
		    margin-top: 5px;
		    margin-bottom: 5px;
	    }
	    
	</style>
	
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
                                
                                    <div class="table-responsive">

								        <table class="table table-bordered" width="100%" cellspacing="0">
								            <tbody>
								                <form enctype="multipart/form-data" id="inserForm">
								                    <tr>
								                        <td style="text-align: right"><label for="pos" class="col-form-label">職&emsp;&emsp;稱 :</label></td>
								                        <td><input type="text" id="pos" name="position" class="form-control" size="30" maxlength="30"
								                                style="width:300px;" required />
								                            <span id="result0c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                  
								                    <tr>
								                        <td style="text-align: right"><label for="" class="col-form-label">加班類型 :</label></td>
								                        <td >
								                        	<input style="float:left;" type="radio" class="form-check-input r1" name="Overtime_category"value="平日加班" id="nday"/> 
								                            <label for="nday" class="form-check-label radio_1 l1">平日加班</label> 
								                            <input type="radio" class="form-check-input r1" name="Overtime_category" value="假日加班" id="holiday"/> 
								                            <label for="holiday" class="form-check-label radio_1  l1" >假日加班</label> 
								                            <input type="radio"class="form-check-input r1" name="Overtime_category" value="休假加班" id="break"/>
								                            <label for="break" class="form-check-label radio_1  l1" >休假加班</label>
								                            <span id="result1c" class="form-text" style="text-align: right;" ></span>
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="OvertimeDate" class="col-form-label ">加班日期 :</label></td>
								                        <td>
								                            <input type="date"class="form-control" id="OvertimeDate" name="OvertimeDate" style="width:300px;" required>
								                            <span id="result2c" class="form-text" style="text-align: right;"></span>
								                            <span id="result7c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="stime" class="col-form-label">開始時間 :</label></td>
								                        <td>
								                            <input type="time" class="form-control" id="stime" name="Starting_time" style="width:300px;" required>
								                            <span id="result3c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="endtime" class="col-form-label">結束時間 :</label></td>
								                        <td>
								                            <input type="time" class="form-control " id="endtime" name="Ending_time" style="width:300px;" required>
								                            <span id="result4c" class="form-text" style="text-align: right;"></span><span id="result6c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="Cause" class="col-form-label">加班事由 :</label></td>
								                        <td>
								                            <input type="text" class="form-control" id="Cause" name="reason" style="width:300px;" required>
								                            <span id="result5c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="Remarks" class="col-form-label">備&emsp;&emsp;註 :</label></td>
								                        <td>
								                            <textarea rows="6" cols="20" class="form-control" id="Remarks" name="Remarks" ></textarea>
								                        </td>
								                    </tr>
								                    <tr>
								                    	<td colspan="2" style="text-align: right" >
															<CENTER><button type="button" class="btn btn-primary" id='sendData'>送出</button></CENTER>
														</td>
													</tr>	
								                </form>
								                
								
								            </tbody>
								        </table>

    								</div>
                                </div>
                            </div>


                        </div>

                     

                        <!-- Third Column -->
                        <div class="col-lg-4  overtime">

                            <!-- Grayscale Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">加班申請紀錄</h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">顯示近三筆</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered">
                                	<tr>
                                		<th colspan='7' style= text-align:center>未審核</th>
                                	</tr>
									<tr>
									<th>申請日期</th>
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
										  	 <td>${pending.department}</td>
										  	 <td>${pending.position}</td>			
										  	 <td>${fn:substring(pending.overTimeDate,0, 10)}</td>		
										  	 <td>${pending.overtimeCategory}</td>
										     <td>${pending.overTimeHours}</td>	
										     <td>${pending.result}</td>	
										 </tr>    
										</c:forEach>
								  </table>
								  
								  <table class="table table-hover table-bordered">
								  		<tr>
                                			<th colspan='7' style= text-align:center>已審核</th>
                                		</tr>
										<tr>
										<th>申請日期</th>
										<th>部門</th>
										<th>職位</th>
										<th>加班日期</th>
										<th>加班類型</th>
										<th>加班時數</th>
										<th>審核狀態</th>
										</tr>
											<c:forEach var='auditted' items='${overtimePartAuditted}'>
											  <tr>
											  	 <td>${fn:substring(auditted.dateOfApplication,0, 10)}</td>
											  	 <td>${auditted.department}</td>
											  	 <td>${auditted.position}</td>			
											  	 <td>${fn:substring(auditted.overTimeDate,0, 10)}</td>		
											  	 <td>${auditted.overtimeCategory}</td>
											     <td>${auditted.overTimeHours}</td>	
											     <td>${auditted.result}</td>	
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