<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 載入 Jquery -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<!-- 載入 Datatables -->
<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script> 
<!-- 載入 Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script type="text/javascript">
$(document).ready(function(){
	            
	        	$('#dataTable').DataTable({
					"lengthMenu": [[5, 10, 25, 50, 100], [5, 10, 25, 50, 100]],
					"ajax": {
						"url":"<c:url value='/findAllCheck'/>",
						"type": "GET",
						"dataType": 'json',
						"dataSrc": "",
						
					},
					"columns":[
						{ "data":"empNo"},
						{ "data":"createTime"},
						{ "data":"checkInTime"},
						{ "data":"checkOutTime"},
						{ "data":"isLateCheckIn"},
						{ "data":"isOnTimeCheckOut"},
						{ "data":"workingHours"}
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
				        	  else return data.substring(11, 19);
				          },
				        },
				        {
				          targets: [4,5],
				          render: function (data) {   
				             // return moment(data).format('HH:mm:ss');
				        	  if(data == "Y") return "是";
				        	  else return "否";
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
				
				$.dataTablesSettings = {
	    	        "aLengthMenu": [10, 25, 50, 100],
	    	        "bAutoWidth": false,
	    	        "bDeferRender": true,
	    	        "bLengthChange": true,
	    	        "sAjaxSource": "/ReceivedDoc/AjaxHandler",
	    	        "bPaginate": true,
	    	        "bServerSide": true,
	    	        "bSort": true,
	    	        "iDisplayLength": 10,
	    	        searching: false,//是否显示搜索框
	    	        "aaSorting": [[0, "asc"]], // set first column as a default sort by asc
	    	        "bFilter": true,
	    	        "aoColumnDefs": [{  // define columns sorting options(by default all columns are sortable extept the first checkbox column)
	    	            'bSortable': true,
	    	            'aTargets': [0, 8]
	    	        }],
	    	        "fnServerParams": function (aoData) {
	    	            aoData._rand = Math.random();
	    	        },
	    	        "fnDrawCallback": function () {

	    	        }
	    	}

	    	        dataTable = $(".dataTables-example").dataTable($.dataTablesSettings);
	    	            $('#btn_search').click(function () {
	    	                //这里重新设置参数
	    	                $.dataTablesSettings.fnServerParams = function (aoData) {
	    	                    aoData._rand = Math.random();
	    	                    aoData.push(
	    	                        { "name": "year", "value": $('#year').val() },
	    	                        { "name": "month", "value": $('#month').val() },
	    	                        { "name": "StartTime", "value": $('#StartTime').val() },
	    	                        { "name": "EndTime", "value": $('#EndTime').val() },
	    	                        { "name": "DTMName", "value": $('#DTMName').val() },
	    	                        { "name": "isOnTimeCheckOut", "value": $('#KeyWords').val() }
	    	                        );
	    	                }
	    	                //搜索就是设置参数，然后销毁datatable重新再建一个
	    	                dataTable.fnDestroy(false);
	    	                dataTable = $(".dataTables-example").dataTable($.dataTablesSettings);
	    	                //搜索后跳转到第一页
	    	                dataTable.fnPageChange(0);
	    	            });

	
})




</script>


</head>
<body>
<div class="ibox-tools">
                            <span>年度</span>
                            @Html.DropDownList("year", (List<SelectListItem>)ViewBag.YearDrop, new { @class = "" })
                            <span>月度</span>
                            @Html.DropDownList("month", (List<SelectListItem>)ViewBag.MonthDrop, new { @class = "" })
                            <span>开始日期</span>
                            @Html.TextBox("StartTime", null, new { @class = "m-wrap small" })
                            <span>结束日期</span>
                            @Html.TextBox("EndTime", null, new { @class = "m-wrap small" })

                            <span>发文类型</span>
                            @Html.DropDownList("DTMName", null, new { @class = "m-wrap small" })
                            <span>是否遲到</span>
                            <select id = 'KeyWords'>
                            	<option value="是">是</option>
                            	<option value="否">否</option>
                            </select>

                            <a class="btn btn-primary btn-sm" title='搜索' id="btn_search" href="javascript:void(0)"><i class="fa fa-search"></i>搜索</a>
                            <a class="btn btn-primary btn-sm" title='发文' href="@Url.Action("Create")"><i class="fa fa-plus"></i>添加</a>

                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
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
                                        </tr>
                                    </thead>
                                   <tbody id="BulletinMagList">
                                       
                                    </tbody>
                                </table>
                            </div>
                        </div>

</body>
</html>