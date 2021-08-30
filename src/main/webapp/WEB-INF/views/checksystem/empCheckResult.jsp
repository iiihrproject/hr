<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<!-- 載入 Jquery -->
<script src="js/jquery-3.6.0.min.js"></script>

<!-- 載入 Datatables -->
<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />

<!-- 載入 Bootstrap --> 
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!-- checksystem css -->
<link rel='stylesheet' href="<c:url value='css/empchecksystem.css' />" type="text/css" />
<script >
	$(document).ready(function(){
		$('#dataTable').DataTable({
			"lengthMenu": [[5, 10, 25, 50, 100], [5, 10, 25, 50, 100]],
			"ajax": {
				"url":"<c:url value='/findCheckByEmpno'/>",
				"type": "GET",
				"dataType": 'json',
				"dataSrc": "",
				
			},
			"columns":[
				{ "data":"empNo"},
				{ "data":"showTime"},
				{ "data":"checkInTime"},
				{ "data":"checkOutTime"},
				{ "data":"isLateCheckIn"},
				{ "data":"isOnTimeCheckOut"},
				{ "data":"workingHours"},
				{ "data":"isNeedRepair"}
			],
			
			columnDefs:[
		        {
		          targets: [1],
		          render: function (data) {   
		             // return moment(data).format('YYYY-MM-DD');
		             return data.substring(0, 10);
		          },
		        },
		        {
		          targets: [2,3],
		          render: function (data) {   
		             // return moment(data).format('HH:mm:ss');
		        	  if(data == null) return data;
		        	  else return data.substring(11, 16);
		          },
		        },
		        {
		          targets: [4,5],
		          render: function (data) {   
		             // return moment(data).format('HH:mm:ss');
		        	  if(data == "Y") return "是";
		        	  else return "否";
		          },
		        },
		        {
		          targets: [7],
		          render: function (data) {   
		             // return moment(data).format('HH:mm:ss');
		        	  if(data == "Y") return "<a href='<c:url value='/EmpSignApply' />'"+
							"class='text-decoration-none'>" +"<button class='btn btn-outline-danger'>補簽到</button>"+"</a>";
		        	  else return "無需補簽到";
		          },
		        }
		    ],
			
			"language": {
		        "processing": "處理中...",
		        "loadingRecords": "載入中...",
		        "lengthMenu": "顯示 _MENU_ 項結果",
		        "zeroRecords": "沒有符合的結果",
		        "info": "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
		        "infoEmpty": "顯示第 0 至 0 項結果，共 0 項",
		        "infoFiltered": "(從 _MAX_ 項結果中過濾)",
		        "infoPostFix": "",
		        "search": "搜尋:",
		        "paginate": {
		            "first": "第一頁",
		            "previous": "上一頁",
		            "next": "下一頁",
		            "last": "最後一頁"
		        	},
		        "aria": {
		            "sortAscending": ": 升冪排列",
		            "sortDescending": ": 降冪排列"
		        }
		    }
		})
		
		
		
	})





</script>
</head>
<body id="page-top">
	<jsp:include page="../header.jsp"></jsp:include>
    <!-- Page Wrapper -->
    
            <div id="bgcolor" class="container-fluid h-75" >    
	            
            	 <div class="row">
								<!-- 員工查詢  -->
                        <div class="col-lg-4  mycss">

                            
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h3 class="m-0 font-weight-bold text-primary">員工出勤查詢
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
		                                <table class="table table-bordered table-hover" id="dataTable" width="100%" cellspacing="0">
		                                    <thead>
		                                        <tr>
		                                            <th>員工編號</th>
		                                            <th>日期</th>
		                                            <th>上班打卡</th>
		                                            <th>下班打卡</th>
		                                            <th>是否遲到</th>
		                                            <th>是否準時</th>
		                                            <th>出勤時數</th>
		                                            <th>是否需補簽到</th>
		                                        </tr>
		                                    </thead>
		                                   <tbody id="BulletinMagList">
		                                       
		                                    </tbody>
		                                </table>
                                </div>
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

	<!-- 載入 Datatables -->
	<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script> 



</body>
</html>