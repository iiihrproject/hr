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
    
    <script src="js/jquery-3.6.0.min.js"></script>
    <!-- .js請從此後寫 -->
    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
    <script>
    window.onload = function () {
    
	$("#delclick").click(function(){

        let pn = `${bulletin.postno}`;
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "<c:url value='/bulletin/DelEventPage?postno=' />" +`${bulletin.postno}`);
    	xhr.send();
    	xhr.onreadystatechange = function(){
    		if (xhr.readyState == 4 && xhr.status == 200){
    			console.log(xhr.responseText);
    			printresult(xhr.responseText);
    		}
    	}
        
        function printresult(data){
		$("#resultMsg").html("<font color='red' >" + data + "</font>");
		let li = "<c:url value='/bulletinManage' />";
 		$("#delclick").remove(); 
		$("#cancelBut").remove(); 
		$("#resultbutton").html('<button class="btn btn-secondary btn-sm" type="button" data-dismiss="modal" id="cancelBut" onclick="history.back()">回公布欄管理</button>')	
        }
		
	}) 
	
	//留言
		msgData();
		
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
			   "empName": "人資管理員",
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
 			console.log("type:"+`${bulletin.type}`)
 		}
	
    } // end of window.onload = function
    
    
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
			segment += "<td colspan='4'>尚無留言</td>"
			segment += "</tr>";
			console.log("null");
			console.log("segment:"+segment);
		}else { 
			le = posts.length;
			console.log("le:"+le)
			for (let n = 0; n < le; n++) {
				let BulMessage = posts[n];
			
				segment += "<tr>";
				if(BulMessage.msgStatus=="已刪除"){
					segment += "<td style='font-style:italic; color:#BEBEBE'>"+ BulMessage.message +"</td>";
					segment += "<td style='font-style:italic; color:#BEBEBE'>"+ BulMessage.empNo +"</td>";
					segment += "<td style='font-style:italic; color:#BEBEBE'>"+ BulMessage.messageDate +"</td>";
					segment += "<td style='font-style:italic; color:#BEBEBE'>（此筆留言已刪除）</td>";
					
				}else{
					segment += "<td>"+ BulMessage.message +"</td>";
					segment += "<td>"+ BulMessage.empNo +"</td>";
					segment += "<td>"+ BulMessage.messageDate +"</td>";
					segment += "<td><a onclick='delMsg("+BulMessage.id+")' style='color:#ac2c20' data-toggle='modal' data-target='#massgaeModal'>刪除</a></td>";
					
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
    	xhr3.open("GET", "<c:url value='/bulletinDelMsg' />/?id=" + id);
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
                            <h6 class="m-0 font-weight-bold">編輯貼文</h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <tbody>
                                    	<tr>
                                            <td style="color:black;"><h5 class="m-0 font-weight-bold" style="color:#4c3fc4">${bulletin.title}</h5></td>
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
                                            <td>已報名人數：10&nbsp;／&nbsp;可報名人數：${bulletin.quota}</td>
                                        </tr>
                                        </c:otherwise>
                                        </c:choose>
                                        
                                        <c:choose>
                                        	<c:when test="${bulletin.quotatype==null}">
                                        	</c:when>
                                        	<c:otherwise>
                                        	<tr>
                                        		<td>
                                    			報名截止：${bulletin.endDate}
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
                                    		<%-- <c:choose>
                                        	<c:when test="${bulletin.type == '活動'}"> --%>
                                        	<a href="<c:url value='/bulletinEditEventPage?postno=${bulletin.postno}'/>" class="btn btn-warning btn-icon-split btn-sm" style="color:black">
                                        	<span class="text">修改</span>
                                    		</a>
                                        	<%-- </c:when>
                                       	 	<c:otherwise>
                                        	<a href="#" class="btn btn-warning btn-icon-split btn-sm" style="color:black">
                                        	<span class="text">修改</span>
                                    		</a>
                                        	</c:otherwise>
                                        	</c:choose> --%>
                                    		&nbsp;
                                    		<c:choose>
                                        	<c:when test="${bulletin.type == '活動'}">
                                        		<a href="#" class="btn btn-danger btn-icon-split btn-sm" data-toggle="modal" id="sendDel" data-target="#comfirmDelModal">
                                        		<span class="text">刪除</span>
                                    			</a>
                                        	</c:when>
                                       	 	<c:otherwise>
                                        		<a href="#" class="btn btn-danger btn-icon-split btn-sm">
                                        		<span class="text">刪除</span>
                                    			</a>
                                        	</c:otherwise>
                                        	</c:choose>
                                    		
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 留言區 -->
                            <div  id="messageArea">
                    		<div class="card mb-4 py-3 border-left-danger">
                    		
                    			<div class="card-body">
                    				<div class="table-responsive">
                    				
                    					<table class="" width="100%" cellspacing="0" style="border: 0px solid #fff;">
                    						<tr>
                                    			<td>
                                    			
                                    			<input type="text" id="message" name="title" class="form-control" maxlength="30" placeholder="請輸入留言......"/>
                                    			
                                    			</td>
                                        		<td>&nbsp;
                                        		<button class="btn btn-success btn-icon-split btn-sm" id="sendMsg">
                                        		<span class="text">管理者留言</span>
                                    			</button>
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
                                    				<th width=40%>留言</th>
                                    				<th width=20%>留言者</th>
                                    				<th width=20%>留言日期</th>
                                    				<th width=20%>刪除</th>
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
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            
            <jsp:include page="../footer.jsp"></jsp:include>


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
    
    <!-- Result Modal-->
    <div class="modal fade text-center" id="comfirmDelModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="resultModalLabel">刪除貼文</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto">請確認是否刪除貼文</span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button id="delclick" class="btn btn-danger btn-sm">確認</button>
                <button class="btn btn-secondary btn-sm" type="button" data-dismiss="modal" id="cancelBut">取消</button>
                </div>
            </div>
        </div>

    </div>
	<!-- Result Modal End-->



</body>

</html>