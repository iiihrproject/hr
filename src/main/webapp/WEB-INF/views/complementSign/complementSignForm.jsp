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
	$(document).ready(function(){
		
	$('#sendData').click(function () {
			hasError = false;
		 	var dateValue = $('#date').val();
			var typeValue = $("select[name='Type']").val();
			var reasonValue = $('#reason').val();
			var today = new Date();
			let span0 = $('#result0c');
			let span1 = $('#result1c');
			let span2 = $('#result2c');
			
			var date = Date.parse(dateValue);
			
			if(date > today){
				setErrorFor(span0 ,"輸入錯誤:填寫日期不可大於當日");
			}else{
				span0.html("");
			}
			if(!dateValue){
				setErrorFor(span2, "補簽日期不可為空白");
			}else{
				span2.html("");
			}
			if(!reasonValue){
				setErrorFor(span1, "請填寫補簽事由");
			}else{
				span1.html("");
			}
			if(hasError){
				return false;
			}
	
			swal({
		        title: "補簽申請!",
		        html: "確定送出嗎?!",
		        type: "question",
		        confirmButtonText: "確定",
		      	cancelButtonText: "取消",
		        showCancelButton: true//顯示取消按鈕
		    }).then(function (result) {
		        if (result.value) {
		            //使用者按下「確定」要做的事
// 		            var dateValue = $('#date').val();
// 					var typeValue = $("select[name='Type']").val();
// 					var reasonValue = $('#reason').val();
					var xhr = new XMLHttpRequest();
		 			xhr.open("POST","<c:url value='/saveEmpComplementSign' />", true);
		 			var jsonPendingComplementSign={
		 				"appliedDate" : dateValue,
		 				"type" : typeValue,
		 				"reason" : reasonValue
		 			}
		 			xhr.setRequestHeader("Content-Type", "application/json");
		 			xhr.send(JSON.stringify(jsonPendingComplementSign));
		 	  		xhr.onreadystatechange = function() {
		 	  			if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201) ) {
		 	  				
				  			
		 	  			}
		 			}
		             
		         swal("新增成功!", "請等待主管簽核", "success");
// 		         window.location.href = "<c:url value='/checkInto'/>";
		         setTimeout('refresh()', 2000);
		     } else if (result.dismiss === "cancel"){
		          //使用者按下「取消」要做的事
		         swal("取消申請", "請再次確認", "error");
		     }//end else  
		  });//end then 
		
		    
		})
		
// 		var sendData = document.getElementById("sendData");
// 		sendData.onclick = function(){
			
// 			var dateValue = $('#date').val();
// 			var typeValue = $("select[name='Type']").val();
// 			var reasonValue = $('#reason').val();
			
// 			var xhr = new XMLHttpRequest();
// 			xhr.open("POST","<c:url value='/saveEmpComplementSign' />", true);
// 			var jsonPendingComplementSign={
// 				"appliedDate" : dateValue,
// 				"type" : typeValue,
// 				"reason" : reasonValue
// 			}
// 			xhr.setRequestHeader("Content-Type", "application/json");
// 			xhr.send(JSON.stringify(jsonPendingComplementSign));
// 	  		xhr.onreadystatechange = function() {
// 	  			if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201) ) {
// 		  			window.location.href = "<c:url value='/xxx'/>";
		  			
// 	  			}
// 			}
// 		}	
		
		$(".slide_toggle").click(function () {
		    $(this).next().slideToggle();
		});
		
		$("#date").blur(function() {
			var dateValue = $('#date').val();
			var today = new Date();
			let span0 = $('#result0c');
			var date = Date.parse(dateValue);
			
			if (date > today) {
				setErrorFor(span0, "輸入日期不可大於當日");
			} else {
				span0.innerHTML = "";
			}
	})
	})
	
	
	
	
	function setErrorFor(input, message) {
		input.html("<font color='red' size='-2'>" + message + "</font>");
		hasError = true;
	}
	
	function refresh(){
		window.location.href = "<c:url value='/EmpSignApply'/>";
	}
	</script>
	
</head>

<body id="page-top"  >

   <jsp:include page="../header.jsp"></jsp:include>
                
             <div class="row  h-75">

                        <!-- First Column -->
                        <div class="col-lg-4 overtime">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">員工補簽系統</h2>
                                </div>
                                <div class="card-body ">
                                
                                    <div class="table-responsive">

								        <table class="table table-bordered" width="100%" cellspacing="0">
								            <tbody>
								                <form enctype="multipart/form-data" id="inserForm">
								                    <tr>
								                        <td style="text-align: right"><label for="pos" class="col-form-label">申請補簽日期 :</label></td>
								                        <td><input type="datetime-local" id="date" name="appliedDate" class="form-control" size="30" maxlength="30"
								                                style="width:200px;" required />
								                            <span id="result0c" class="form-text" style="text-align: right;"></span>
								                            <span id="result2c" class="form-text" style="text-align: right;"></span>
								                        </td>
								                    </tr>
								                  
								                    <tr>
								                        <td style="text-align: right"><label for="type" class="col-form-label">補簽類型 :</label></td>
								                        <td style="text-align: left">
								                        	<select name = "Type" id = type class="btn btn-outline-primary" >
								                            <option value= "CheckIn">上班
								                            </option>  
								                            <option value= "CheckOut">下班
								                            </option>  
								                        </select>  
								                        </td>
								                    </tr>
								                    <tr>
								                        <td style="text-align: right"><label for="reason" class="col-form-label ">補簽事由 :</label></td>
								                        <td>
								                            <input type="text"class="form-control" id="reason" name="reason" style="width:300px;" >
								                            <span id="result1c" class="form-text" style="text-align: right;"></span>
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
                                    <h2 class="m-0 font-weight-bold text-primary">補簽申請紀錄</h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">顯示近三筆</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered" >
                                	<tr>
                                	<th colspan='4' style= text-align:center>未審核</th>
                                	</tr>
									<tr>
									<th>申請日期</th>
									<th>補簽日期</th>
									<th>補簽時間</th>
									<th>審核狀態</th>
									</tr>
										<c:forEach var='pending' items='${pendingComplementSign}'>
										  <tr>
										  	 <td>${fn:substring(pending.date,0, 10)}</td>
										  	 <td>${fn:substring(pending.appliedDate,0, 10)}</td>		
										  	 <td>${fn:substring(pending.appliedDate,11, 16)}</td>		
										  	 <td>${pending.status}</td>
										 </tr>    
										</c:forEach>
								  </table>
								  
								  <table class="table table-hover table-bordered " >
									<tr>
                                	<th colspan='4' style= text-align:center>已審核</th>
                                	</tr>
									<tr>
									<th>申請日期</th>
									<th>補簽日期</th>
									<th>補簽時間</th>
									<th>審核狀態</th>
									</tr>
										<c:forEach var='auditted' items='${audittedComplementSign}'>
										  <tr>
										  	 <td>${fn:substring(auditted.date,0, 10)}</td>
										  	 <td>${fn:substring(auditted.appliedDate,0, 10)}</td>		
										  	 <td>${fn:substring(auditted.appliedDate,11, 16)}</td>		
										  	 <td>${auditted.status}</td>
										 </tr>    
										</c:forEach>
								  </table>
								  <a href="<c:url value='/EmpSignQuery' />" class="text-decoration-none">
		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button>
		                          </a>
								  </div>
                                </div>
                            </div>
                        </div>

                    </div>

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