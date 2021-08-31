<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	
    <!-- checksystem css -->
    <link rel='stylesheet' href="<c:url value='/css/checksystem.css' />" type="text/css" />
    
    <!--引用SweetAlert2.css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.0.0/sweetalert2.all.js"></script>
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
	<script type="text/javascript">
	$(document).ready(function () {
		var errorMsg = '${errorMsg}';
		
		if(errorMsg != '') {
			swal("貼心提醒",errorMsg,"warning");
		}


		$('#work').click(function () {
		
			swal('打卡上班');
			
			swal({
		        title: "打卡上班!",
		        html: "確定上班嗎?!",
		        type: "question",
		        confirmButtonText: "確定",
		      	cancelButtonText: "取消",
		        showCancelButton: true//顯示取消按鈕
		    }).then(function (result) {
		        if (result.value) {
		            //使用者按下「確定」要做的事
		            
		            var type = $('#work').attr('name');
		            var xhr1 = new XMLHttpRequest();
		            xhr1.open("POST", "<c:url value='/saveCheckSystem'/>", true);
		            xhr1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		            xhr1.send("type=" + type);
		            xhr1.onreadystatechange = function () {
		                // 伺服器請求完成
		                if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201)) {
		                    var response = xhr1.responseText;
		
		                    if ('Success' == response) {
		//                         window.location.href = "<c:url value='/findCheck'/>?type=" + type;
		                    } else {
		                    	swal(response);
		                    }
		                }
		            }
		             
		         swal("打卡成功!", "今日工作加油", "success");
// 		         window.location.href = "<c:url value='/checkInto'/>";
		         setTimeout('refresh()', 1500);
		     } else if (result.dismiss === "cancel"){
		          //使用者按下「取消」要做的事
		         swal("取消打卡", "尚未打卡上班", "error");
		     }//end else  
		  });//end then 
		
		    
		})
		
		$('#offwork').click(function () {
		// 	swal('打卡下班');
		//swal.resetDefaults();//清空自訂預設值
				swal({
		        title: "打卡下班!",
		        html: "確定下班嗎?!",
		        type: "question",
		        confirmButtonText: "確定",
		      	cancelButtonText: "取消",
		        showCancelButton: true//顯示取消按鈕
		    }).then(function (result) {
		        if (result.value) {
		            //使用者按下「確定」要做的事
		           var type = $('#offwork').attr('name');
		           var xhr1 = new XMLHttpRequest();
		           xhr1.open("POST", "<c:url value='/saveCheckSystem'/>", true);
		           xhr1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		           xhr1.send("type=" + type);
		
		           xhr1.onreadystatechange = function () {
		               // 伺服器請求完成
		               if (xhr1.readyState == 4 && (xhr1.status == 200 || xhr1.status == 201)) {
		                   var response = xhr1.responseText;
		                   
		                   if ('Success' == response) {
		               		
  		                    } else {
  		                    	swal(response);
  		                    }
		               }
		
		           }
		             
		         swal("打卡成功!", "今日工作辛苦了", "success");
// 		         window.location.href = "<c:url value='/checkInto'/>";
		         setTimeout('refresh()', 1500);

		     } else if (result.dismiss === "cancel"){
		          //使用者按下「取消」要做的事
		         swal("取消打卡", "尚未打卡下班", "error");
		     }//end else  
		  });//end then 
		
		});
		$(".slide_toggle").click(function () {
		    $(this).next().slideToggle();
		});
		
	
		
		
	})
	
	
	</script>
	
	<script type="text/javascript">
	
	function refresh(){
		window.location.href = "<c:url value='/checkInto'/>";
	}
	
	//畫面效果
	$(function () {
	    $('#switchID1').click(function () {
	        if ($('#offwork').is(':hidden')) {
	            $('#offwork').show();
	            $('#work').hide();
	            //$('#click_event').val('隐藏');
	        }
	        else {
	            // $('#hidden_enent').hide();
	            // $('#click_event').val('顯示');
	            $('#work').show();
	            $('#offwork').hide();
	        }
	    })
	})
	
	function ShowTime() {
	    var NowDate = new Date();
	    var h = NowDate.getHours();
	    var m = NowDate.getMinutes();
	    var s = NowDate.getSeconds();
	    var ampm = h >= 12 ? 'PM' : 'AM';
	    h = h % 12;
	    h = h ? h : 12; // the hour '0' should be '12'
	    h = h < 10 ? '0' + h : h;
	    m = m < 10 ? '0' + m : m;
	    s = s < 10 ? '0' + s : s;
	    document.getElementById('showbox').innerHTML = h + ':' + m + ':' + s + " " + ampm;
	    setTimeout('ShowTime()', 1000);
	}
	
	function week() {
	
	    var d = new Date();
	    var weekday = new Array(7)
	    weekday[0] = "星期天"
	    weekday[1] = "星期一"
	    weekday[2] = "星期二"
	    weekday[3] = "星期三"
	    weekday[4] = "星期四"
	    weekday[5] = "星期五"
	    weekday[6] = "星期六"
	
	    return weekday[d.getDay()];
	}
	
	
	function ShowDate() {
	    var NowDate = new Date();
	    var y = NowDate.getFullYear();
	    var m = NowDate.getMonth() + 1;
	    var d = NowDate.getDate();
	    document.getElementById('showdate').innerHTML = m + '月' + d + '日 ' + week();
	    setTimeout('ShowDate()', 1000);
	}
</script>

	

</head>

<body id="page-top" onload="ShowTime() , ShowDate() " >

    <jsp:include page="../header.jsp"></jsp:include>
    
    <!-- header刪掉 start-->

    

                <!-- header刪掉 End-->
                
             <div class="row pt-4"  >
                        <!-- First Column -->
                        <div class="col-lg-4 mycss">

                            <!-- Custom Text Color Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
<%--                                  <a href="<c:url value='/checkInto' />" class="text-decoration-none"> --%>
<!--                                 	<button class="btn btn-outline-primary">refresh</button> -->
<!--                                  </a> -->
                                    <h2 class="m-0 font-weight-bold text-primary">員工打卡系統</h2>
                                </div>
                                <div class="card-body "style="background-image: url('<c:url value="/img/clock.png" />');  background-size: cover;">
                                
                                      <div class="gowork ">
							            <h5 id="showdate" style="color:black;"></h5>
							            <h1 id="showbox" style="color:black;font-size: 50px;"></h1>
							            <br> <br> <br> <br> <br> <br> <br><br><br>
							            
							            
							            <c:choose>
							            	
								            <c:when test="${factSchedule.start != null}" > 
								            
									            <h4 id="worktime"style="float:left; margin-left: 120px;font-weight: bold;font-size: 30px;"><nobr>上班時間:${fn:substring(factSchedule.start,11,16)}</nobr></h4>
									            <h4 id="offworktime" style="float:right; margin-right: 120px; font-weight: bold;font-size: 30px;"><nobr>下班時間:${fn:substring(factSchedule.end,11,16)}</nobr></h4>
								            
								            </c:when>
								            <c:when test="${factSchedule.start == null}">
								            	<h2 style="color:red;font-weight: bold;">今日休假<img src='<c:url value="/img/sleep.png" />' width=25%></h2>
								            </c:when>
							            </c:choose>
							            
        							   </div>																	
                                </div>
                            </div>

                            <!-- Custom Font Size Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">請確認上班型態是否正確</h6>
                                </div>
                                <div class="card-body gowork">
								     <button type="button" class="work btn btn-primary" id="work" name="checkIn">上班打卡</button>
								     <button type="button" class="offwork btn btn-primary" id="offwork" name="checkOut"
								                style="display: none;">下班打卡</button><br><br>
        								                        
                                     <div class="switch">
							            <input class="switch-checkbox" id="switchID1" type="checkbox" name="switch-checkbox"> 
							            <label class="switch-label" for="switchID1"> <span class="switch-txt" turnOn="下班" turnOff="上班"></span>
							            <span class="switch-Round-btn"></span>
							            </label>
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
                        <div class="col-lg-4 mycss ">

                            <!-- Grayscale Utilities -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h2 class="m-0 font-weight-bold text-primary">我的出勤紀錄
                                    </h2>
                                </div>
                                <div class="card-body">
                                    <div class="slide_toggle" id="showCheck">顯示近五天記錄</div>
                                <!-- 展開 -->
                                <div id="showFile" align='center'>
                                <table class="table table-hover table-bordered">
									<tr><th>日期</th><th>上班時間</th><th>下班時間</th><th>上班是否遲到</th><th>下班是否準時</th><th>是否需補簽到</th></tr>
										<c:forEach var='checksystem' items='${Checksystem}'>
										  <tr>
										  	 <td>
										  	 	<c:choose>
										     	  <c:when test="${checksystem.checkInTime == null}" > ${fn:substring(checksystem.checkOutTime,0, 10)}</c:when>
										     	  <c:otherwise>${fn:substring(checksystem.checkInTime,0, 10)}</c:otherwise>
						       					</c:choose>
						       				</td>
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
						       				 <td>
						       				 <c:choose>
										     	  <c:when test="${checksystem.isNeedRepair == 'Y'}" ><a href="<c:url value='/EmpSignApply' />"
													class="text-decoration-none"><button class='btn btn-outline-danger'>補簽到</button></a></c:when>
										     	  <c:when test="${checksystem.isNeedRepair == 'N'}" >無須補簽到</c:when>
						       				</c:choose>
						       				 </td>
										     
										 </tr>    
										</c:forEach>
								  </table>
								  <a href="<c:url value='/empCheck' />" class="text-decoration-none">
		                            <button type="button" class="btn btn-outline-primary">查看完整資訊</button>
		                          </a>
								  </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    
             			

            <jsp:include page="../footer.jsp"></jsp:include>
            
            <!-- footer刪掉 start -->

    <!-- footer刪掉 end -->

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
	
</body>

</html>