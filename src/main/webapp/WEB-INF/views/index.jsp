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
	window.onload = function() {
		let bDataArea = document.getElementById("BulletinDataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/bulletinList'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				bDataArea.innerHTML = processBulletinData(xhr.responseText);
			}
		}
	}
    
	function processBulletinData(jsonString) {
		
		$(document).ready(function(){
		    $('table tbody tr').click(function(){
		        window.location = $(this).attr('href');
		        return false;
		    });
		});
				
		console.log(td);
		
		let posts = JSON.parse(jsonString);
		let segment = "";
		let le=0;
		if (posts.length>10) {
			le = 10;}
		else { le = posts.length;}
		for (let n = 0; n < le; n++) {
			let bulletin = posts[n];
			let link = "href='<c:url value='/bulletinDetail' />?postno=" + bulletin.postno + "''>";
			/* let flag = "<i class=' fas fa-info-circle' style='color: #f6c23e; border-color: #f6c23e;'></i>"; */
			let flag = "<img id='logo' src='img/new.png' style='height:16px'>";
			segment += "<tr "+link;
			segment += "<td>" + bulletin.type + "</td>";
			if(bulletin.postDate==td){
			segment += "<td>" + bulletin.title +" "+flag+"</td>";}
			else{segment += "<td>" + bulletin.title +"</td>"}
			segment += "<td>" + "20/"+ bulletin.quota + "</td>";
			segment += "<td>" + bulletin.postDate + "</td>";
			segment += "</tr>";
		}
		return segment;
		
	}
	
	</script>

</head>

<body id="page-top">

   <jsp:include page="header.jsp"></jsp:include>
   
                <!-- Begin Page Content -->
                <div id="bgcolor" class="container-fluid">
                    <div class="row">
                        <!-- Area Chart -->
                        <div class="col-12 col-lg-6">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">行事曆</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="contents w-100">
                                        <!-- <iframe src="https://calendar.google.com/calendar/embed?src=d43m79ddllr6j2psmaqblv1iec%40group.calendar.google.com&ctz=Asia%2FTaipei" style="border: 0" width="100%" height="100%" frameborder="0" scrolling="no"></iframe> -->
                                        ##內容寫這裡
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 0419 分隔線分隔線 -->

                        <!-- Pie Chart -->
                        <div class="col-12 col-lg-6">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">公佈欄</h6>
                                    <!--人資公布欄管理區-->
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">                                     
                                            <a class="dropdown-item" href="<c:url value='/bulletinManage' />">管理公佈欄</a>
                                        </div>
                                    </div>
                                   <!--人資公布欄管理區end-->
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="contents w-100">
                                        <!-- 內容開始 -->
                                        
                                        <!-- DataTales Example -->
											<div class="table-responsive">
                                				<table class="table table-bordered table-hover" width="100%" cellspacing="0">
                                   					 <thead>
                                       					 <tr>
                                            				<th>類型</th>
                                            				<th>主旨</th>
                                            				<th>報名人數</th>
                                            				<th>刊登日</th>
                                        				</tr>
                                    				</thead>
                                    				
                                    				<tbody id="BulletinDataArea" class="">
                                    				</tbody>
                                				</table> 
                             				</div>   
                              				<a href="#" style="color:gray">  more</a>   
                                        <!-- 內容結束 -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            
            <jsp:include page="footer.jsp"></jsp:include>
            
            
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>