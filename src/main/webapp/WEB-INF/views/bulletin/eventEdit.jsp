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

    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
    <!-- 公布欄資料載入 -->
	<script>

    var hasError = false;
    var ofile = "notchange";
   
    
    window.onload = function () {
    	let divResult = document.getElementById('resultMsg');
    	//送出修改
        let sendData = document.getElementById("sendData");
        sendData.onclick = function () {
            hasError = false;
            let titleValue = document.getElementById("title").value;
            let descriptionValue = $(".ck-content").html();
            let destextValue = $(".ck-content").text();
            let file1Value = document.getElementById("file1").value;
            let quotaValue = $("[name='quotatype']:checked").val();
            let quotanValue = "";
        	if(quotaValue!=null){
        	quotanValue = document.getElementById("quotanid").value;
        	var enddateValue = document.getElementById("enddate").value;
        	}
        	
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
        	let div5 = document.getElementById('result5c');
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
        	/* if (!postdateValue){
        	setErrorFor(div2, "請輸入刊登日期");  
        	} else if (postdateValue<td) {
                setErrorFor(div2, "刊登日期已過");
            } else {
        	div2.innerHTML = "";
        	} */
        	if (!expValue){
        	setErrorFor(div3, "請輸入刊登日期");  
        	} else if (expValue<postdateValue) {
                setErrorFor(div3, "有效日期不可小於刊登日期");
            } else {
        	div3.innerHTML = "";
        	}
        	
        	if(`${bulletin.type}` == '公告'){
        		
        	} else {
        		
        		if (quotaValue=="限制" && quotanValue==0){
                	setErrorFor(div4, "請輸入可報名額");  
                	} else {
                	div4.innerHTML = "";
                	}
            	if (!enddateValue){
                	setErrorFor(div5, "請輸入報名截止日期");  
                	} else if (enddateValue<postdateValue) {
                        setErrorFor(div5, "報名截止日期不可小於貼文刊登日期");
                	} else if (enddateValue>expValue) {
                        setErrorFor(div5, "報名截止日期不可大於貼文下架日期");
                    } else {
                	div5.innerHTML = "";
                	}
        	}
            	
            if (hasError) {
            	divResult.innerHTML = "<font color='red' >請確認資料是否正確輸入</font>";
                return false;
            }
            console.log(hasError);

            //送出新增資料jQuery
            var formData = new FormData();
            
            formData.append("postno", `${bulletin.postno}`);
            formData.append("title", titleValue);
            formData.append("description", descriptionValue);
            formData.append("desText", destextValue);
            formData.append("file1", file);
            if(!quotaValue){
            	formData.append("quotatype", "");
            }else{
            	formData.append("quotatype", quotaValue);
            }
            if(!quotanValue){
            	formData.append("quota", 0);
            }else{
            	formData.append("quota", quotanValue);
            }
            if(`${bulletin.type}` == '公告'){
            	
            } else {
            formData.append("endDate", enddateValue);
            }
            formData.append("postDate", postdateValue);
            formData.append("exp", expValue);
            
            console.log("---postdate:"+postdateValue);
            console.log("file:"+file);
            
            if(ofile=="notchange"){
            $.ajax({
                type: 'post',
                url: "<c:url value='/bulletin/EditEventop' />",
                data: formData,
                cache: false,
                processData: false,
                contentType: false,
            	success: function (data) { 
            		printresult(data);
                	console.log("送出成功");
            	},
                fail: function (data) { 
                	printresult("送出失敗");
                    console.log("送出失敗");
                }
            });
            }else{
            $.ajax({
                type: 'post',
                url: "<c:url value='/bulletin/EditEvent' />",
                data: formData,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) { 
                	printresult(data);
                    console.log("送出成功:"+data);
                },
                fail: function (data) { 
                	printresult("送出失敗:"+data);
                    console.log("送出失敗:"+data);
                }
            });
            }

            
        }
    }
    
    function printresult(data){
     var divResult = document.getElementById('resultMsg'); 
        if (data=="修改失敗") {
            divResult.innerHTML = "<font color='red' >" + data + "</font>";
        } else if (data=="修改成功") {
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
    	ofile = "change";
    	console.log("ofile(clean):"+ofile);
    	
    }
    
  //載入圖片
    function selectImgFile(files) {
    	if (!files.length) {
    		return false;
    	}

    	let file = files[0];
    	let reader = new FileReader();
    	reader.onload = function() {
    		document.getElementById('showImg').src = this.result;
    	};

    	reader.readAsDataURL(file);
    	ofile = "change";
    	console.log("ofile(selectImgFile):"+ofile);
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

	<jsp:include page="../header.jsp"></jsp:include>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">修改${bulletin.type}貼文</h6>
                        </div>
                        <div class="card-body">
                           <div class="table-responsive">
                           
                          <table class="table table-bordered" width="100%" cellspacing="0">
                                    <tbody>
                                    <form enctype="multipart/form-data;charset=utf-8" id="inserForm">
                                        <tr>
                                            <td style="text-align: right" ><label for="" class="col-form-label"  >主&emsp;&emsp;旨 :</label>
                                            </td>
                                            <td><input type="text" id="title" name="title" class="form-control"  size="30" maxlength="30" style="width:600px;" value="${bulletin.title}" required />
                                            	<span id="result0c" class="form-text"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                        	<td style="text-align: right"><label for="" class="col-form-label">內&emsp;&emsp;容 :</label>
                                        	</td>
                    						<td style="color:black">
                    						<textarea class="editor" name="description">${bulletin.description}</textarea>
                    						<!-- <textarea id="description" id="description" class="form-control" cols="50" rows="6" required style="width:600px;" ></textarea> -->
                    						<span id=result1c class="form-text"></span>
                    						</td>
                                        </tr>
                                        
                                        <c:choose>
                                        <c:when test="${bulletin.file1==null}">
                                        	<tr>
                                            	<td style="text-align: right"><label for="" class="col-form-label">上傳圖檔 :</label>
                                            	</td>
                                            	<td>
                                            		<input type="file" id="file1" name="file1" class="btn-sm" onchange="selectImgFile(this.files)" >
                                            		<a class="btn btn-secondary btn-icon-split btn-sm" style="height:30px" onclick="clean()">
                                        			<span class="text">清除檔案</span>
                                    				</a>
                                    				<br>
                                            		<img id="showImg" style="max-width:500px"></img>
                                            	</td>
                                        	</tr>
                                        </c:when>
                                        <c:otherwise>
                                        	<tr>
                                        		<td style="text-align: right"><label for="" class="col-form-label">圖&emsp;&emsp;檔 :</label>
                                        		</td>
                                            	<td>
                                            		<img id="showImg" src="<c:url value='/bulletin/getImage?postno=${bulletin.postno}'/>" style="max-width:500px"/>
                                            	</td>
                                        	</tr>
                                        	<tr>
                                            	<td style="text-align: right"><label for="" class="col-form-label">變更圖檔 :</label>
                                            	</td>
                                            	<td>
                                            		<input type="file" id="file1" name="file1" class="btn-sm" onchange="selectImgFile(this.files)">
                                            		<a class="btn btn-secondary btn-icon-split btn-sm" style="height:30px" onclick="clean()">
                                        			<span class="text">清除檔案</span>
                                    				</a>
                                    			</td>
                                        	</tr>
                                        </c:otherwise>
                                        </c:choose>
                                        
                                        <c:choose>
                                        <c:when test="${bulletin.quotatype==''||bulletin.type == '公告'}">
                                        </c:when>
                                        <c:otherwise>
                                        	<tr>
                                        	<c:choose>
                                        	<c:when test="${bulletin.quotatype=='限制'}">
                                        		<td style="text-align: right"><label for="" class="col-form-label">名&emsp;&emsp;額 :</label></td>
                                            	<td><input type="radio" name="quotatype" id="notlimitid" value="不限"/><label for="">不限</label>&emsp;
                    								<input type="radio" name="quotatype" id="limitid" value="限制" checked/>限制
                                            		<input type="number" name="quota" id="quotanid" min="0" max="1000" value="${bulletin.quota}" />人
                                            		<span id=result4c class="form-text"></span>
                                            	</td>
                                        	</c:when>
                                        	<c:otherwise>
                                        		<td style="text-align: right"><label for="" class="col-form-label">名&emsp;&emsp;額 :</label></td>
                                            	<td><input type="radio" name="quotatype" id="notlimitid" value="不限" checked/><label for="">不限</label>&emsp;
                    								<input type="radio" name="quotatype" id="limitid" value="限制" />限制
                                            		<input type="number" name="quota" id="quotanid" min="0" max="1000" disabled />人
                                            		<span id=result4c class="form-text"></span>
                                            	</td>
                                        	</c:otherwise>
                                        	</c:choose>
                                        	</tr>
                                        </c:otherwise>
                                        </c:choose>
                                        
                                        <c:choose>
                                        <c:when test="${bulletin.quotatype==''||bulletin.type == '公告'}">
                                        </c:when>
                                        <c:otherwise>
                                        
                                        <tr>
                                           <td style="text-align: right">
                                            	<label for="" class="col-form-label ">報名截止 :</label>
                                            </td>
                                            <td>
                                            	<input type="date" id="enddate" name="enddate" class="form-control" style="width:200px;" value="${bulletin.endDate}" required>
                    							<span id=result5c class="form-text"></span>
                                            </td>
                                        </tr>
                                        
                                        </c:otherwise>
                                        </c:choose>
                                        
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label ">貼文刊登 :</label></td>
                							<td>
                    						<input type="date" id="postdate" name="postdate" class="form-control" style="width:200px;" value="${bulletin.postDate}" required >
                    						<span id=result2c class="form-text"></span>
                    						</td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right"><label for="" class="col-form-label">貼文下架 :</label></td>
                							<td>
                    						<input type="date" id="exp" name="exp" class="form-control" style="width:200px;" value="${bulletin.exp}" required >
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
                                    		<a class="btn btn-info btn-icon-split btn-sm" href="#" data-toggle="modal" id="checkinsert" data-target="#checkModal" onclick="checkinsertbutton(`${bulletin.type}`)">
                                        	<span class="text">&nbsp;預覽&nbsp;</span>
                                    		</a>
                                    		&nbsp;
                                    		<button type="submit" class="btn btn-warning btn-icon-split btn-sm" style="color:black" data-toggle="modal" id="sendData"  data-target="#resultModal">
                                        	<span class="text">&nbsp;修改&nbsp;</span>
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
            
            <jsp:include page="../footer.jsp"></jsp:include>


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
                                        <tr>
                                            <td>貼文刊登：<span id="chpd"></span></td>
                                        </tr>
                                        <tr  id="tdqu">
                                            <td>已報名人數：&nbsp;／&nbsp;可報名人數：<span id="chqu"></span></td>
                                        </tr>
                                        <tr id="trenddate">
                                            <td >報名截止：<span id="ched"></span></td>
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
                    <h5 class="modal-title mx-auto" id="resultModalLabel">貼文修改</h5>
                </div>
                <div class="modal-body">
                    <span id="resultMsg" style="margin:3px auto"><font color='red' ></font></span><br/>
                </div>
                <div class="modal-footer justify-content-center" id="resultbutton">
                <button class="btn btn-secondary" type="button" data-dismiss="modal" id="resultbutton">返回編輯</button>
                </div>
            </div>
        </div>
    </div>
	<!-- Result Modal End-->
	
	<!-- ckeditor-->
	<script src="<c:url value='/build/ckeditor.js' />"></script>

	<!-- ckeditor end-->
	
	<script src="<c:url value='/js/bEventEdit.js' />"></script>
	

	
	

</body>

</html>