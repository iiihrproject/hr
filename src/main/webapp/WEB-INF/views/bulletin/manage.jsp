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
	    	"bFilter": true,
	    	"lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
	        "ajax": {
	        "url":'<c:url value='/bulletinListMag'/>',
	        "dataSrc": "",
	        },
	        "order": [[ 0, "desc" ]],
	        "columns": [
	            { "data": "postno" },
	            { "data": "type" },
	            { "data": "title" },
	            { "data": "desText" ,
	            	"render": function (data, type, row) {
	            		let dText="";
	            		if(data!=null){
	            		if (data.length>=8){
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
	            { "data": "exp" },
	            
	            
	            { "data": "enCount" ,
		            	"render": function (data, type, row) {
		            		if(row.type=="公告"){
		            		return "-";
		            		}else{
		            			return data;
		            		}
		                }},
		                
		                { "data": "quota" ,
			            	"render": function (data, type, row) {
			            		if(row.type=="公告"){
				            		return "-";
			            		}else if(row.quotatype=="不限"){
			            		return "*";
			            		}else{
			            			return data;
			            		}
			                }},
			                
		        { "data": "endDate" ,
			            	"render": function (data, type, row) {
			            		if(row.type=="公告"){
			            		return "-";
			            		}else{
			            			return data;
			            		}
			                }},
	            { "data": "likeCount" },
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
	        
	        initComplete: function () {
				this.api().columns().every( function () {
					let column = this;
					let select = $('<select><option value="">全部</option></select>').appendTo( $("#statuschoose").empty() ).on( 'change', function () {
						let val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							console.log(column);
							column.search( val ? '^'+val+'$' : '', true, false ).draw();
							console.log( val ? '^'+val+'$' : '')
						} );

					
						select.append( '<option value="刊登中">刊登中</option><option value="未刊登">未刊登</option><option value="已過期">已過期</option>' );
				} );	

				this.api().columns([4]).every( function () {
					let column2 = this;
					let select2 = $('<select><option value="">全部</option></select>').appendTo( $("#pdchoose").empty() ).on( 'change', function () {
						let val2 = $.fn.dataTable.util.escapeRegex(
								$(this).val()
						);
							console.log(column2);
							console.log(val2);
							column2.search( val2 ? '^'+val2 : '', true, false ).draw();
							console.log('val:'+ val2 ? '^'+val2+'$' : '')
						} );

					
						select2.append( '<option value="2021-06">2021-06</option><option value="2021-07">2021-07</option><option value="2021-08">2021-08</option><option value="2021-09">2021-09</option>' );
					
				} );
			},  
	        
	    
            createdRow: function (row, data, index) {
                if (data.postDate<=td && data.exp>=td) {
                   $('td', row).eq(10).css('color', 'green')
                }
            }, 
            
            rowCallback: function(row, data){
            	console.log("連結：<c:url value='/bulletinDetailMsg'/>?postno=" + data.postno );
            	$(row).attr("href","<c:url value='/bulletinDetailMsg'/>?postno=" + data.postno);
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
	
<!-- <style>
	.table-striped tbody tr:nth-of-type(odd) {
  background-color: rgba(236, 225, 74, 0.267);
}
	</style> -->

</head>

<body id="page-top">

	<jsp:include page="../header.jsp"></jsp:include>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
<!--                     <h4 class="h4 mb-2 text-gray-800">公佈欄管理</h4> -->
<!--                     <p class="mb-4">刊登貼文請依循公司規定</p> -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header d-flex flex-row align-items-center justify-content-between" style="padding-top: 8px;padding-bottom:8px">
                            <h6 class="m-0 font-weight-bold">公布欄貼文管理</h6>
                            <!--人資公布欄管理區-->
                            <div class="dropdown">
                            	<a href="#" class="btn btn-outline-primary btn-sm dropdown-toggle" id="navbarDropdown" 
                                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >

                                    <span class="text">新增貼文</span>
                                </a>
                                
                                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <a class="dropdown-item" href="<c:url value='bulletinAnnoInsert' />">公告</a>
                                    <a class="dropdown-item" href="<c:url value='bulletinEventInsert' />">活動</a>
                                </div>
                            </div>
                             <!--人資公布欄管理區end-->
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">

							<div class="table ">
							刊登時間：<span id="pdchoose"></span>&emsp;
                        	刊登狀態：<span id="statuschoose"></span>
                        	</div>
                        	
                            <div class="table-responsive">
                            
                                <table class="table table-bordered table-hover table-hover-color table-sm " id="dataTable" width="100%" cellspacing="0" style="color:#43454e" >
                                    <thead>
                                        <tr style="background-color:#f7ebce">
                                            
                                            <th width=5%>NO.</th>
                                            <th width=6%>類型</th>
                                            <th width=14%>主旨</th>
                                            <th width=12%>內容</th>
                                            <th width=9%>貼文刊登</th>
                                            <th width=9%>貼文下架</th>
                                            <th width=7%>報名數</th>
                                            <th width=6%>名額</th>
                                            
                                            <th width=9%>報名截止</th>
                                            <th width=7%>愛心數</th>
                                            <th width=7%>狀態</th>

                                                                                         
                                        </tr>
                                    </thead>
                                   <tbody id="BulletinMagList">
                                       
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