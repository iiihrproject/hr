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
    
    
    <!-- Custom styles for this page -->
    <link href="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.css' />" rel="stylesheet">
    
    <!-- jQuery導入 -->
    <script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
    
    <!-- 使用today.js -->
    <script src="<c:url value='/js/today.js' />"></script>
    
	<!-- 公布欄資料載入 -->
	<script>
	window.onload = function() {
	
		$("#dataTable tbody").on("click", "tr", function () {
	        	window.location = $(this).attr('href');
	        	return false;
		});

	};


		
	$(document).ready(function() {		
	    $('#dataTable').DataTable( {
	    	"searching": false,
	    	"scrollCollapse": false, 
	    	"ordering": false, 
	    	/* "lengthMenu": [10, 20], */
	    	"paging": false,
	    	"bFilter": true,
	        "ajax": {
	        "url":'<c:url value='/bulletinListMag'/>',
	        "dataSrc": "",
	        },
	        "order": [[ 0, "desc" ]],
	        "columns": [

	            { "data": "type" },
	            { "data": "title" },
	            { "data": "desText" ,
	            	"render": function (data, type, row) {
	            		console.log(data);
	            		let dText="";
	            		if(data!=null){
	            		if (data.length>8){
	            			dText = data.substr(0,7)+"...";
	            		} else {
	            			dText = data;
	            		}
	            		return dText;
	            		}else{
	            			return data;
	            		}
	                }},
	            { "data": "postDate" },
	            { "data": "enCount" ,
		            	"render": function (data, type, row) {
		            		if(row.type=="公告"){
		            		return "-";
		            		}else{
		            			return data;
		            		}
		                }},
	            { "data": "postStatus",
	            	"render": function (data, type, row, meta) {
	            		let status="";
	            		if (row.postDate<=td && row.exp>=td) {
	            			status += "刊登中";
	            			}else if(row.postDate>td){
	            				status += "未刊登";
	            			}else if (row.exp<td) {
	            				status += "已過期";
	            			}else{status +="其他";}
	            		
	            		return status;
	            	
	                }},
	                
	        ],
	         
            
            rowCallback: function(row, data){
            	console.log("連結：<c:url value='/bulletinDetail'/>?postno=" + data.postno );
            	$(row).attr("href","<c:url value='/bulletinDetail'/>?postno=" + data.postno);
            },
            
            "language": {
            	"emptyTable": "表中資料為空",
                "lengthMenu": "顯示 _MENU_ 則貼文",
                "zeroRecords": "沒有符合的貼文",
                "info": "顯示第 _START_ 至 _END_ 則貼文，共 _TOTAL_ 則",
                "infoEmpty": "顯示第 0 至 0 則貼文，共 0 則",
                "infoFiltered": "(由 _MAX_ 則貼文過濾)",
                "search": "搜尋貼文:",
                "oPaginate": {
                    "sFirst": "首頁",
                    "sPrevious": "上一頁",
                    "sNext": "下一頁",
                    "sLast": "末頁"
                 },
              }
            
	    } );
	    
           		
                  
	} )
	


		

	
	</script>
	
   <script>
	window.onload = function() {

// 		公佈欄
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
		    $('#datatableid tr').click(function(){
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
			let flag = "<i class=' fas fa-info-circle' style='color: #f6c23e; border-color: #f6c23e;'></i>";
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

	<jsp:include page="../header.jsp"></jsp:include>

		<!-- Begin Page Content -->
		<div id="bgcolor" class="container-fluid">
			<div class="row">
                    
				<!-- 左Area Chart -->
				<div class="col-12 col-lg-6">
					<div class="card shadow mb-4">
                        <!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold">公佈欄貼文</h6>
                        </div>
                        
                        <!-- Card Body -->
                        <div class="card-body">
                        	<div class="contents w-100">
							<!-- <div class="table ">
								刊登時間：<span id="pdchoose"></span>&emsp;
                        		刊登狀態：<span id="statuschoose"></span>
                        	</div> -->
                        	
                            <div class="table-responsive"  style="height:100%">       
                                <table class="table table-bordered table-hover table-hover-color " id="dataTable" width="100%" cellspacing="0" style="color:#43454e" >
                                    <thead>
                                        <tr>
                                            <th width=10%>類型</th>
                                            <th width=20%>主旨</th>
                                            <th width=20%>內容</th>
                                            <th width=20%>貼文刊登</th>
                                            <th width=15%>報名人數</th> 
                                            <th width=15%>報名狀態</th>                                        
                                        </tr>
                                    </thead>
									<tbody id="BulletinMagList">
									</tbody>    
                                </table>
                            </div>
                        </div>
                        </div>
                        <!-- End of Card Body -->
                    </div>
				</div>
				<!-- End of 左Area Chart -->
				
				<!-- 右Area Chart -->
				<div class="col-12 col-lg-6">
					<div class="card shadow mb-4">
                        <!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold">公佈欄貼文</h6>
                        </div>
                        
                        <!-- Card Body -->
                        <div class="card-body">
                        	<div class="contents w-100">
							<!-- <div class="table ">
								刊登時間：<span id="pdchoose"></span>&emsp;
                        		刊登狀態：<span id="statuschoose"></span>
                        	</div> -->
                        	
                            <!-- DataTales Example -->
								<div class="table-responsive"  style="height:100%">
                                	<table class="table table-bordered table-hover table-hover-color " id="dataTable" width="100%" cellspacing="0" style="color:#43454e" >
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
                              	<a href="<c:url value='myBulletin' />" style="color:gray">我的活動</a>   
                                <!-- DataTales結束 -->
                        	</div>
                        </div>
                        <!-- End of Card Body -->
                    </div>
				</div>
					<!-- End of 右chart -->

				</div>
			</div>
            
            <!-- End of Main Content (Page Content) -->
            
            <jsp:include page="../footer.jsp"></jsp:include>

           
    <!-- Bootstrap core JavaScript-->
    <script src="<c:url value='/vendor/jquery/jquery.min.js' />"></script>
    <script src="<c:url value='/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

    <!-- Core plugin JavaScript-->
    <script src="<c:url value='/vendor/jquery-easing/jquery.easing.min.js' />"></script>

    <!-- Custom scripts for all pages-->
    <script src="<c:url value='/js/sb-admin-2.min.js' />"></script>
    
    <!-- Page level plugins -->
    <script src="<c:url value='/vendor/datatables/jquery.dataTables.min.js' />"></script>
    <script src="<c:url value='/vendor/datatables/dataTables.bootstrap4.min.js' />"></script>

    <!-- Page level custom scripts -->
    <%-- <script src="<c:url value='/js/demo/datatables-demo.js' />"></script> --%>

    <!-- Page level plugins -->
    <!-- <script src="vendor/chart.js/Chart.min.js"></script> -->

    <!-- Page level custom scripts -->
    <!-- <script src="js/demo/chart-area-demo.js"></script> -->
    <!-- <script src="js/demo/chart-pie-demo.js"></script> -->
    
    
</body>

</html>