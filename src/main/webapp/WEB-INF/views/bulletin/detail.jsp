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
    <link rel="stylesheet" href="<c:url value='css/bulcss.css' />">
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    
    <!-- icon載入 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
    <!-- 留言資料載入 -->
	<script>
	var hasError = false;
	var enrollNum = 0;

	
	window.onload = function() {
 		msgData();
 		if(`${bulletin.type}` =='公告'){
 		} else {
 			loadenrollnum();
 	 		/* loadenrollment(); */
 		}
 		loadLike();
 		
 		
 		
 		var sendMsg = document.getElementById("sendMsg")
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
 			  "empName": `${sessionScope.loginModel.getName()}`,
 			   "messageDate": td,
 			};
 			
 			console.log(obj);
 			
 			let xhr2 = new XMLHttpRequest();
 			let url = "<c:url value='/insertMessage'  />";
 			console.log(url);
 			xhr2.open("POST", url);
 			xhr2.setRequestHeader("Content-Type", "application/json");
 			xhr2.send(JSON.stringify(obj));

 			xhr2.onreadystatechange = function(){
 				if (xhr2.readyState == 4 && xhr2.status == 200){
 					let result 		= JSON.parse(xhr2.responseText);
 					let divResult = document.getElementById('result0c');
 					if (result.success) {
 						divResult.innerHTML = "<font color='GREEN'>" + result.success + "</font>";
 			  		} else  if(result.fail){
 			            divResult.innerHTML = "<font color='red' >" + result.fail + "</font>";
 			  		} else {
 			  			divResult.innerHTML = "<font color='red' >" + result.failnull + "</font>";
 			  		}
 				msgData();
 				}
 				
 			}

 		}
 		
 		if(`${bulletin.type}` =='公告'){
 			$("#messageArea").html("");
 			console.log("type:"+`${bulletin.type}`);
 		}
 		



	} 
		
	function msgData() {
		var mDataArea = document.getElementById("BulletinMessageArea");

		var xhr = new XMLHttpRequest();	
		xhr.open("GET", "<c:url value='/bulletinGetMsg'/>?postno=" + ${bulletin.postno});
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				mDataArea.innerHTML = processBulletinMsg(xhr.responseText);
			}
		}
		console.log("msgData執行")
		}

    
	function processBulletinMsg(jsonString) {
		
		let posts = JSON.parse(jsonString);
		let segment = "";
		let le=0;
		if(posts.length==0){
			segment += "<tr>";
			segment += "<td colspan='3'>尚無留言</td>"
			segment += "</tr>";
			console.log("null");
			console.log("segment:"+segment);
		}else { 
			le = posts.length;
			console.log("le:"+le)
			for (let n = 0; n < le; n++) {
				let BulMessage = posts[n];
			
				segment += "<tr style=' color:#484a55'>";
				if(BulMessage.msgStatus=="已刪除"){
					segment += "<td  colspan='2' style='font-style:italic; color:#BEBEBE'>（這筆留言已刪除）</td>";
					segment += "<td></td>";
				}else{

					segment += "<td>"+ BulMessage.empName +"</td>";
					segment += "<td>"+ BulMessage.message +"</td>";
					if(BulMessage.empNo==`${sessionScope.loginModel.getEmpNo()}`){
						segment += "<td>"+ BulMessage.messageDate +"&emsp;";
						segment += "<a onclick='delMsg("+BulMessage.id+")' style='color:#ac2c20' data-toggle='modal' data-target='#massgaeModal'>刪除</a></td>";
					}else{
						segment += "<td>"+ BulMessage.messageDate +"</td>";
					}
				}
				segment += "</tr>";
			}
		}
		return segment;

		
		console.log("processBulletinMsg執行")
		}
	

	
function setErrorFor(input, message){
	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
    hasError = true;
}

function delMsg (id){
	let resultMsg = document.getElementById("resultMsg")
	resultMsg.innerHTML = "<font color='red' >請確認是否刪除留言</font>";
	
	$("#delCheck").click(function(){

	let xhr3 = new XMLHttpRequest();
	xhr3.open("GET", "<c:url value='/bulletinDelMsg' />?id=" + id);
	xhr3.send();
	xhr3.onreadystatechange = function() {
		if (xhr3.readyState == 4 && xhr3.status == 200){
			result =xhr3.responseText;
			if (result=='刪除失敗') {
				console.log("留言刪除失敗");
				msgData();
			} else if (result=='刪除成功') {
				console.log("留言已刪除");
				msgData();
			}
			else {
				console.log("留言未刪除");
				msgData();
			}
			
		}

	}
	
	})

}


function loadLike (){
	let xhr4 = new XMLHttpRequest();
	let url = "<c:url value='/bulletinFindLike' />";
	let empnoo = `${sessionScope.loginModel.getEmpNo()}`;
	xhr4.open("POST", url);
	xhr4.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr4.send("postno=" + ${bulletin.postno} + "&empNo=" + `${sessionScope.loginModel.getEmpNo()}`);
	console.log("執行loadLike載入")

	let likeS = "";
	let bulLike ="";
	xhr4.onreadystatechange = function(){
		if (xhr4.readyState == 4 && xhr4.status == 200){
			if(xhr4.responseText){
				bulLike = JSON.parse(xhr4.responseText);
				console.log("有回傳bulLike:"+bulLike);
				console.log("bulLike.likeStatus:"+bulLike.likeStatus);
			}
			
			if (!bulLike){
				likeS += '<span class="icon btn-outline-heart" id="like" onclick="changelike()">';
				likeS += '<i class="bi bi-suit-heart-fill" style="font-size:24px; vertical-align:middle"></i></span>';
				$("#likespan").html(likeS);
				console.log("likeS1");	
			}
			else if (bulLike.likeStatus=='喜歡'){
				likeS += '<span class="icon btn-heart" id="like" onclick="changelike()">';
				likeS += '<i class="bi bi-suit-heart-fill" style="font-size:24px; vertical-align:middle"></i></span>';
				$("#likespan").html(likeS);
				console.log("likeS2");	
				
			} else{
				likeS += '<span class="icon btn-outline-heart" id="like" onclick="changelike()">';
				likeS += '<i class="bi bi-suit-heart-fill" style="font-size:24px; vertical-align:middle"></i></span>';
				$("#likespan").html(likeS);
				console.log("likeS3");	
			}
			console.log("likeS:"+bulLike.likeStatus);
		}
	}
}

function changelike() {
	$("#like").toggleClass("btn-outline-heart");
	$("#like").toggleClass("btn-heart");
	let xhr5 = new XMLHttpRequest();
	let url = "<c:url value='/bulletinChangeLike' />";
	let empnoo = `${sessionScope.loginModel.getEmpNo()}`;
	xhr5.open("POST", url);
	xhr5.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr5.send("postno=" + ${bulletin.postno} + "&empNo=" + `${sessionScope.loginModel.getEmpNo()}`);
}


function loadenrollment (enrollNum){
	
	let xhr6 = new XMLHttpRequest();
	let url = "<c:url value='/bulletinFindEnroll' />";
	let empnoo = `${sessionScope.loginModel.getEmpNo()}`;
	xhr6.open("POST", url);
	xhr6.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr6.send("postno=" + ${bulletin.postno} + "&empNo=" + `${sessionScope.loginModel.getEmpNo()}`);

	let enrollS = "";
	let bulEnroll ="";
	xhr6.onreadystatechange = function(){
		if (xhr6.readyState == 4 && xhr6.status == 200){
			if(xhr6.responseText){
				bulEnroll = JSON.parse(xhr6.responseText);
				console.log("有回傳bulEnroll.enrollStatus:"+bulEnroll.enrollStatus);
			}

 			let num = $("#numspan").text();
			console.log("--bulletin.quota:"+`${bulletin.quota}`);
			console.log("--enrollNum:"+enrollNum);
			if (!bulEnroll){
				if (enrollNum>=${bulletin.quota} && `${bulletin.quotatype}` =='限制') {
					enrollS += '報名額滿';
					$("#applyspan").html(enrollS);
					$("#apply").removeAttr("data-toggle");
					console.log("bulEnroll4:"+enrollS);	
				} else {
				enrollS += '報名';
				$("#applyspan").html(enrollS);
				$("#applyMsg").html("請確認是否<font color='red' >報名</font>這項活動");
				$("#enStatus").html("");
				console.log("bulEnroll1:"+enrollS);	
				}
			} else if (bulEnroll.enrollStatus=='參加'){
				enrollS += '取消報名';
				$("#applyspan").html(enrollS);
				$("#applyMsg").html("請確認是否<font color='red' >取消報名</font>這項活動");
				$("#enStatus").html("<font color='green' ><i class='bi bi-check2-square'></i>&nbsp;已報名</font>");
				console.log("bulEnroll2:"+enrollS);	
				
			} else if (enrollNum>=${bulletin.quota}) {
				enrollS += '報名額滿';
				$("#applyspan").html(enrollS);
				$("#apply").removeAttr("data-toggle");
				console.log("bulEnroll4:"+enrollS);	
			}
			else{
				enrollS += '報名';
				$("#applyspan").html(enrollS);
				$("#applyMsg").html("請確認是否<font color='red' >報名</font>這項活動");
				$("#enStatus").html("");
				console.log("bulEnroll3:"+enrollS);	
			}


 			if( `${bulletin.endDate}` <= td ){
				enrollS = '報名截止';
				$("#applyspan").html(enrollS);
				$("#apply").removeAttr("data-toggle");
				console.log("bulEnroll5:"+enrollS);	
	 		}  
			
			console.log("bulEnroll:"+bulEnroll.enrollStatus);
		}
	}
}

function sendEnroll () {
	let xhr7 = new XMLHttpRequest();
	let url = "<c:url value='/bulletinInsertEnroll' />";
	let empnoo = `${sessionScope.loginModel.getEmpNo()}`;
	xhr7.open("POST", url);
	xhr7.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr7.send("postno=" + ${bulletin.postno} + "&empNo=" + `${sessionScope.loginModel.getEmpNo()}`);
	xhr7.onreadystatechange = function(){
		if (xhr7.readyState == 4 && xhr7.status == 200){
		loadenrollment();
		loadenrollnum()
		}
	}
}


function loadenrollnum(){
	let numspan = document.getElementById("numspan");
	let xhr8 = new XMLHttpRequest();

	xhr8.open("GET", "<c:url value='/findEnrollNumByNo'/>?postno=" + ${bulletin.postno});
	xhr8.send();
	xhr8.onreadystatechange = function() {
		if (xhr8.readyState == 4 && xhr8.status == 200) {
			enrollNum = xhr8.responseText;
			if(`${bulletin.quotatype}` =='不限'){
				console.log("執行loadenrollment前enrollNum:"+enrollNum)
				loadenrollment(enrollNum);
			} else {
			numspan.innerHTML = enrollNum;
			console.log("執行完enrollNum:"+enrollNum)
			loadenrollment(enrollNum);
			}

		}
	}

}
	
function titleEnter() {
 	 document.getElementById('message').value = '截止了好可惜，'; 
   }
	
	</script>

    

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

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
                                        
                                        
                                        
                                        <tr>
                                            <td>貼文刊登：${bulletin.postDate}</td>
                                        </tr>
                                        
                                        <c:choose>
                                        <c:when test="${bulletin.quotatype == '不限'||bulletin.type == '公告'}">
                                        </c:when>
                                        <c:otherwise>
                                        	<tr>
                                            	<td style=' color:#5a5c69'>已報名人數：<span id="numspan">0</span>&nbsp;／&nbsp;可報名人數：${bulletin.quota}</td>
                                        	</tr>
                                        </c:otherwise>
                                        </c:choose>

                                    		<c:choose>
                                        	<c:when test="${bulletin.quotatype==null||bulletin.type == '公告'}">
                                        	</c:when>
                                        	<c:otherwise>
                                        	<tr>
                                        		<td>
                                    			報名截止：${bulletin.endDate}&emsp;<span id="enStatus"></span>
                                    			</td>
                                        	</tr>
                                        	</c:otherwise>
                                        	</c:choose>
                                        	
                                        
                                        <tr>
                                            <td>
                                            <a href="#" class="btn btn-secondary btn-icon-split btn-sm" onclick="history.back()">
                                        	<span class="text">回前頁</span>
                                    		</a>
                                    		&nbsp;
                                    		<c:choose>
                                        	<c:when test="${bulletin.quotatype==null||bulletin.quotatype=='null'||bulletin.type == '公告'}">
                                        	</c:when>
                                        	<c:otherwise>
                                        		
                                        		<a  class="btn btn-info btn-icon-split btn-sm" id="apply" data-toggle="modal" data-target="#applyModal">
                                        		<span class="text" id="applyspan" >報名</span>
                                    			</a>
                                        	</c:otherwise>
                                        	</c:choose>
                                    		
                                    		&nbsp;&nbsp;
                                    		
                                    		<span id="likespan" >
                                        	</span>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 留言區 -->
                            <div  id="messageArea">
                            
                    		<div class="card mb-4 py-3 border-left-warning"  style="width:80%">
                    			<div class="card-body" >
                    				<div class="table-responsive">
                    				
                    					<table class="" width="100%" cellspacing="0" style="border: 0px solid #fff;">
                    						<tr>
                                    			<td>
                                    			
                                    			<input type="text" id="message" name="title" class="form-control" maxlength="30" placeholder="請輸入留言......"/>
                                    			
                                    			</td>
                                        		<td>
                                        			&nbsp;
                                        			<button class="btn btn-success btn-icon-split btn-sm" id="sendMsg">
                                        			<span class="text">留言</span>
                                    				</button>
                                    				<span onclick="titleEnter()" style="color:white">輸入</span>
                                    			</td>
                                    		</tr>
                                    		<tr>
                                    			<td><span id="result0c" class="form-text" style="font-size:14px"></span></td>
                                    		</tr>
                                		</table>
                                		<br>
                    				
                                		<table class="table table-bordered" width="100%" cellspacing="0">
                                   			<thead>
                                    			<tr>
                                    				<th width=20%>留言者</th>
                                    				<th width=55%>留言</th>
                                    				<th width=25%>留言日期</th>
                                    			</tr>
                                    		</thead>
                                    				
                                   			<tbody id="BulletinMessageArea" class="">
                                    		</tbody>
                                		</table> 
                                		
                             		</div>   
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
            
            <jsp:include page="../footer.jsp"></jsp:include>
            

    <!-- Result Modal-->
    <div class="modal fade text-center" id="massgaeModal" tabindex="-1" role="dialog" aria-labelledby="massgaeModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="resultModalLabel">刪除留言</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto"><font color='red' >請確認是否刪除留言</font></span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="delCal" onclick="history.back()">取消</button>
                <button class="btn btn-danger" type="button" data-dismiss="modal" id="delCheck">確認</button>
                
                </div>
            </div>
        </div>
    </div>
	<!-- Result Modal End-->
	
	<!-- Apply Modal-->
    <div class="modal fade text-center" id="applyModal" tabindex="-1" role="dialog" aria-labelledby="applyModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="applyModalLabel">報名活動</h5>
                </div>
                <div class="modal-body">
                    <span id="applyMsg" style="margin:3px auto">請確認是否<font color='red' >報名</font>這項活動</span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="applybutton">
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="applyCal">取消</button>
                <button class="btn btn-info" type="button" data-dismiss="modal" id="applyCheck" onclick="sendEnroll()">確認</button>
                
                </div>
            </div>
        </div>
    </div>
	<!-- Apply Modal End-->

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