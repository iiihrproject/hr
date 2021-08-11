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
    
    <!-- 公布欄資料載入 -->
	<script>

    var hasError = false;
    
    window.onload = function () {
    	
    	//送出新增
        let sendData = document.getElementById("sendData");
        sendData.onclick = function () {
            hasError = false;
            let titleValue = document.getElementById("title").value;
            let descriptionValue = $(".ck-content").html();
            let destextValue = $(".ck-content").text();
            let file1Value = document.getElementById("file1").value;
            let quotaValue = $("[name='quotatype']:checked").val();
            let quotanValue = document.getElementById("quotanid").value;
            let postdateValue = document.getElementById("postdate").value;
            let expValue = document.getElementById("exp").value;
            let file = $('#file1')[0].files[0]
            if(!file){
            	let file = null;
            }

            //新增前驗證資料
            let div0 = document.getElementById('result0c');
        	let div1 = document.getElementById('result1c');
        	let div2 = document.getElementById('result2c');
        	let div3 = document.getElementById('result3c');
        	let div4 = document.getElementById('result4c');
        	if (!titleValue){
        	setErrorFor(div0, "請輸入主旨");
        	} 	else {
        	div0.innerHTML = "";
        	}
        	if (!destextValue){
        	setErrorFor(div1, "請輸入內容");
        	} else {
        	div1.innerHTML = "";
        	} 
        	if (!postdateValue){
        	setErrorFor(div2, "請輸入刊登日期");  
        	} else if (postdateValue<td) {
                setErrorFor(div2, "刊登日期已過");
            } else {
        	div2.innerHTML = "";
        	}
        	if (!expValue){
        	setErrorFor(div3, "請輸入刊登日期");  
        	} else if (expValue<postdateValue) {
                setErrorFor(div3, "有效日期不可小於刊登日期");
            } else {
        	div3.innerHTML = "";
        	}
        	if (quotaValue=="限制" && quotanValue==0){
            setErrorFor(div4, "請輸入可報名額");  
            } else {
            div4.innerHTML = "";
            }
            if (hasError) {
                return false;
            }
            console.log(hasError);

            //送出新增資料jQuery
            var formData = new FormData();

            formData.append("title", titleValue);
            formData.append("description", descriptionValue);
            formData.append("desText", destextValue);
            formData.append("file1", file);
            formData.append("quotatype", quotaValue);
            if(!quotanValue){
            	formData.append("quota", 0);
            }else{
            	formData.append("quota", quotanValue);
            }
            formData.append("postdate", postdateValue);
            formData.append("exp", expValue);
            
            if(!file){
            $.ajax({
                type: 'post',
                url: "<c:url value='/insertEventBulletion2' />",
                data: formData,
                cache: false,
                processData: false,
                contentType: false,
            	success: function (data) { 
            		printresult(data);
                	console.log("新增成功");
            	},
                fail: function (data) { 
                	printresult("新增失敗");
                    console.log("新增失敗");
                }
            });
            }else{
            $.ajax({
                type: 'post',
                url: "<c:url value='/insertEventBulletion' />",
                data: formData,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) { 
                	printresult(data);
                    console.log("新增成功");
                },
                fail: function (data) { 
                	printresult("新增失敗");
                    console.log("新增失敗");
                }
            });
            }

            
        }
    }
    
    function printresult(data){
    var divResult = document.getElementById('resultMsg');
        if (data=="新增失敗") {
            divResult.innerHTML = "<font color='red' >" + data + "</font>";
        } else if (data=="新增成功") {
            divResult.innerHTML = "<font color='GREEN'>" + data + "</font>";
            let div0 = document.getElementById('result0c');
            let div1 = document.getElementById('result1c');
            let div2 = document.getElementById('result2c');
            let div3 = document.getElementById('result3c');
            div0.innerHTML = "";
            div1.innerHTML = "";
            div2.innerHTML = "";
            div3.innerHTML = "";
            let tomag="<c:url value='/bulletinManage'/>"
            $("#resultbutton").html("<a class='btn btn-primary' href="+tomag+">確認</a>");
        } else {
        	divResult.innerHTML = "<font color='red' >" + data + "</font>";
        }
    }
    
    function clean(){
    	var obj = document.getElementById('file1') ; 
    	obj.outerHTML=obj.outerHTML;
    	$("#showImg").attr("src","");
    	
    }

    
	</script>

<style>
	.ck-editor__editable_inline {
	/* 設定最低高度 */
    min-height: 200px;
}
	</style>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <div class="sidebar-brand-icon">
            </div>
            <div class="sidebar-brand-text mx-auto">
                <img id="logo" src="img/logo_frame.png">
            </div>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/' />">
                    <i class='fas fa-home' style='font-size:22px'></i>
                    <span>主頁</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="<c:url value='/pages' />">
                    <i class='fas fa-clock' style='font-size:22px'></i>
                    <span id="listname">出勤管理</span>
                </a>
            </li>
            <li class="nav-item">            
                <a class="nav-link collapsed" href="<c:url value='/pages' />">
                    <i class='fas fa-user-tie' style='font-size:22px'></i>
                    <span id="listname">人員管理</span>
                </a>
            </li>
        </ul>
        <!-- End of Sidebar -->



        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    <!-- Topbar Search -->                    
                        <div class="narbar-brand">
                            <h2 class="font-weight-bold mb-3">HR有限公司 人力資源系統</h2>
                            <span class="text-dark">特休剩餘時數：【】小時&nbsp</span><span class="text-danger warning">(請於 【日期】 前使用完畢)</span><br/>
                            <span class="text-dark">加班剩餘時數：【】小時&nbsp</span><span class="text-danger warning">(請注意到期時間)</span>
                        </div>  

                        <!-- 0419 alert to do -->

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">                   
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="###" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">員編員編員編</span>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    登出
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">新增活動貼文</h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                           
                          <table class="table table-bordered" width="100%" cellspacing="0">
                                    <tbody>
                                    <form enctype="multipart/form-data" id="inserForm">
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">主&emsp;&emsp;旨 :</label></td>
                                            <td><input type="text" id="title" name="title" class="form-control"  size="30" maxlength="30" style="width:600px;" required />
                                            	<span id="result0c" class="form-text"></span></td>
                                        </tr>
                                        <tr>
                                        	<td style="text-align: right"><label for="" class="col-form-label">內&emsp;&emsp;容 :</label></td>
                    						<td style="color:black">
                    						<textarea class="editor" name="description"></textarea>
                    						<!-- <textarea id="description" id="description" class="form-control" cols="50" rows="6" required style="width:600px;" ></textarea> -->
                    						<span id=result1c class="form-text"></span>
                    						</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">圖&emsp;&emsp;檔 :</label></td>
                                            <td><input type="file" id="file1" name="file1" class="btn-sm" onchange="selectImgFile(this.files)"/>
                                            <a class="btn btn-secondary btn-icon-split btn-sm" style="height:30px" onclick="clean()">
                                        	<span class="text">清除檔案</span>
                                    		</a>
                                    		<br>
                                            <img id="showImg" style="max-width:500px"></img>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">名&emsp;&emsp;額 :</label></td>
                                            <td><input type="radio" name="quotatype" id="notlimitid" value="不限"/><label for="">不限</label>&emsp;
                    							<input type="radio" name="quotatype" id="limitid" value="限制" checked/>限制
                                            	<input type="number" name="quota" id="quotanid" min="0" max="1000"/>人
                                            	<span id=result4c class="form-text"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label ">刊登日期 :</label></td>
                							<td>
                    						<input type="date" id="postdate" name="postdate" class="form-control" style="width:200px;" required >
                    						<span id=result2c class="form-text"></span>
                    						</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">有效日期 :</label></td>
                							<td>
                    						<input type="date" id="exp" name="exp" class="form-control" style="width:200px;" required >
                    						<span id=result3c class="form-text"></span>
                    						</td>
                                        </tr>
                                        </form> 
                                        <tr>
                                           <td colspan="2">
                                            <a href="#" class="btn btn-secondary btn-icon-split btn-sm" onclick="history.back()">
                                        	<span class="text">取消／回前頁</span>
                                    		</a>
                                    		&nbsp;
                                    		<a class="btn btn-info btn-icon-split btn-sm" href="#" data-toggle="modal" id="checkinsert" data-target="#checkModal">
                                        	<span class="text">&nbsp;預覽&nbsp;</span>
                                    		</a>
                                    		&nbsp;
                                    		<button type="submit" class="btn btn-success btn-icon-split btn-sm" data-toggle="modal" id="sendData"  data-target="#resultModal">
                                        	<span class="text">&nbsp;新增&nbsp;</span>
                                    		</button>
                                    		</td>
                                    	</tr>
                                    	
                                    </tbody>
                                 </table>
                                 
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->



    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade text-center" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="exampleModalLabel">確定要登出？</h5>
                    <!-- <button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
                        <!-- <span aria-hidden="true">×</span> -->
                    <!-- </button> -->
                </div>
                <div class="modal-body">
                    <span>提醒：未儲存之工作項目將會遺失</span><br/>
                    <span>請確認已完成當前工作，再選擇【登出】。</span>
                </div>
                <div class="modal-footer justify-content-center">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">取消</button>                  
                    <a class="btn btn-primary" href="<c:url value='login' />">登出</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
    
    
    <script> 

	$("#limitid").focus(function(){
		quotanid.disabled=false; 
    });
	
	$("#notlimitid").focus(function(){
		quotanid.disabled=true; 
    }); 
    </script>
    
    <!-- Check Modal-->
    <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="checkModalLabel" aria-hidden="true" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="checkModalLabel">貼文預覽</h5>
                </div>
                <div class="modal-body">
					<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h5 class="m-0 font-weight-bold text-primary"></h5>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <tbody>  
                                    	<tr >
                                            <td><h5 class="m-0 font-weight-bold" style="color:#483ea1" id="chtitle">${bulletin.title}</h5></td>
                                        </tr>
                                        <tr >
                                            <td style="color:black" id="chdescrib"></td>
                                        </tr>
                                        <tr id="tdfile">
                                            <td><img id="showImg2" style="max-width:500px"></img></td>
                                        </tr>
                                        <tr  id="tdqu">
                                            <td>已報名人數：  &nbsp／&nbsp可報名人數：<span id="chqu"></span></td>
                                        </tr>
                                        <tr>
                                            <td>刊登日期：<span id="chpd"></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">關閉預覽</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Check Modal End-->
	
	<!-- Result Modal-->
    <div class="modal fade text-center" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-auto" id="resultModalLabel">活動貼文</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto"><font color='red' ></font></span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="resultbutton">返回編輯</button>
                    <%-- <a class="btn btn-primary" href="<c:url value='/bulletinManage' />">確認</a> --%>
                </div>
            </div>
        </div>
    </div>
	<!-- Result Modal End-->
	
	<!-- ckeditor-->
	<script src="<c:url value='/build/ckeditor.js' />"></script>

	<!-- ckeditor end-->
	
	<script src="<c:url value='/js/check.js' />"></script>
	

	
	

</body>

</html>