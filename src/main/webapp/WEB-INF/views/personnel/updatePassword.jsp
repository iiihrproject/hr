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

    

	<script>

    var hasError = false;
    
    window.onload = function () {
    	
        let sendData = document.getElementById("sendData");
        sendData.onclick = function () {
            hasError = false;
            let newpwd = document.getElementById("newpwd").value;
            let newpwdcheck = document.getElementById("newpwdcheck").value;

            let div0 = document.getElementById('result0c');
        	let div1 = document.getElementById('result1c');
        	let div2 = document.getElementById('result2c');
        	
        	if (!newpwd){
        	setErrorFor(div0, "請輸入新密碼");
        	} 	else {
        	div0.innerHTML = "";
        	}
        	if (!newpwdcheck){
        	setErrorFor(div1, "請再次輸入新密碼");
        	} else if (newpwd!=newpwdcheck){
        	setErrorFor(div1, "兩次輸入密碼不相符");  
        	}  else {
        	div1.innerHTML = "";
        	}
            if (hasError) {
                return false;
            }


            let xhr = new XMLHttpRequest();
			let url = "<c:url value='/updateNewPassword'  />";
			xhr.open("PUT", url, true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("newPassword=" + newpwd);
			
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
					let result = JSON.parse(xhr.responseText);
					console.log(result.password);
 					 if (result.result == 'password update is successful') {
						div2.innerHTML = "<font color='green'>" + result.result + "</font>"; 
 					 } else {
			  			div2.innerHTML = "<font color='red' >" + result.result+ "</font>";
			  		}
				}
            
        	
    	}

    }
    }
    
    function setErrorFor(input, message) {
    	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
    	hasError = true;
    }

    
	</script>


</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

                <!-- Begin Page Content -->
                <div class="container-fluid h-75">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="col-12 col-lg-6">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">修改密碼</h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                           
                          <table class="table table-bordered" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">請輸入新密碼 :</label></td>
                                            <td ><input type="password" id="newpwd" name="newpwd" class="form-control"  size="20" maxlength="20" required />
                                            	<span id="result0c" class="form-text"></span></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">再次輸入新密碼  :</label></td>
                                            <td><input type="password" id="newpwdcheck" name="newpwdcheck" class="form-control"  size="20" maxlength="20" required />
                                            	<span id="result1c" class="form-text"></span></td>
                                        </tr>
                                        <tr>
                                           <td colspan="2">
                                            <a href="#" class="btn btn-secondary btn-icon-split btn-sm" onclick="history.back()">
                                        	<span class="text">取消／回前頁</span>
                                    		</a>
                                    		&nbsp;
                                    		<button type="submit" class="btn btn-success btn-icon-split btn-sm" data-toggle="modal" id="sendData"  data-target="#resultModal">
                                        	<span class="text">&nbsp;修改密碼&nbsp;</span>
                                    		</button><span id="result2c" class="form-text"></span>
                                    		</td>
                                    	</tr>
                                    	
                                    </tbody>
                                 </table>
                                 
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <!-- /.container-fluid -->

            
            <!-- End of Main Content -->
            
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