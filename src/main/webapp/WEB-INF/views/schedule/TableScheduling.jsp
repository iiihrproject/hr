<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Scheduling</title>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<script>
	window.onload = function() {
		loadData();
	}
	function loadData() {
		var empName = [];
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/schedule/findAllScheduleAjax'/>");
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processScheduleData(xhr.responseText);
				loadEmps(empName);
				loadCSS();
			}
		}
	}

	function processScheduleData(jsonString) {
		let schedule = JSON.parse(jsonString);
		let segment = "<table id='table_id' class='table form-'>";
		segment += "<thead><tr><th>編號</th><th>人員</th><th>開始</th><th>結束</th><th>職務</th><th>操作</th></tr>"
		segment += "<tr id='enter'><td><input type='text' class='form-control' name='keySchedule' id='keySchedule' readonly style='width:40px;visibility:hidden';'/></td>"
				+ "<td><select name='empList' id='empList' onfocus='setToday (this.id)' class='form-control'></select></td>"
				+ "<td><input type='datetime-local' name='start' id='start' onchange='setEnd (this.id)' step='1800' class='form-control' /></td>"
				+ "<td><input type='datetime-local' name='end' id='end' step='1800'  class='form-control'/></td>"
				+ "<td><input type='text' name='titleList' id='titleList' value='到公司上班' class='form-control' /></td>"
				+ "<td><button id='sendData' onclick='sendData()' class=''>新增</button>"
				+ "<button id='updateData' onclick='updateData()' style='visibility:hidden' class=''>更新</button>"
				+ "<button id='cancelUpdate' onclick='cancelUpdate()' style='visibility:hidden' class=''>取消</button></td>"
				+ "</tr></thead><tbody>"

		for (let i = 0; i < schedule.length; i++) {
			let sche = schedule[i];
			segment += "<tr>";
			segment += "<td>" + sche.keySchedule + "</td>";
			let link = '<a href="#" onclick="editData('+ sche.keySchedule +')">'+ sche.emps.name + '</a>';
			segment += "<td>" + link + "</td>";
			segment += "<td>" + sche.start + "</td>";
			segment += "<td>" + sche.end + "</td>";
			segment += "<td>" + sche.title + "</td>";
			segment += "<td><button class='' onclick='deleteData(" + sche.keySchedule
					+ ")'><i class='far fa-trash-alt'></i></button></td></tr>"
		}
		segment += "</tbody></table>";
		return segment;
	} //end of processScheduleData
	
	function loadEmps(empName){
		let xhr2 = new XMLHttpRequest();
		var myDeptNo = ${sessionScope.loginModel.getDepartmentDetail().getDepartmentNumber()};
		xhr2.open("GET", "<c:url value='/G/findEmpsByDept'/>" + "?departmentNumber=" + myDeptNo, true);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				var emps =JSON.parse(xhr2.responseText);
				for(let i=0;i<emps.length;i++){
					var emp = [emps[i].name,emps[i].pk];
					empName.push(emp);
				}
				addOption(empName);
			}
		}
	}//end of load Emps
	
	//人員的下拉式選單
	function addOption(empName) {
		var selectEmps = document.getElementById('empList');
		var empListDef = document.getElementById('empListDef');
// 		Option物件的方法
		var option = new Option("選擇",-1);
		selectEmps.options[selectEmps.options.length] = option;
		selectEmps.options[0].disabled = true;
		for(let i = 0 ;i<empName.length; i++){
			var option = new Option(empName[i][0],empName[i][1]);
			selectEmps.options[selectEmps.options.length]=option;
			var option2 = new Option(empName[i][0],empName[i][1]);
			empListDef.options[empListDef.options.length]=option2;
		}
		//forEach的方法
// 		empName.forEach(function(element, key) {
// 			selectEmps[key] = new Option(element, key);
// 		})
		//如果職務要做選項的備用
		// 		var selectTitle = document.getElementById('titleList');
		// 		var option = new Option("選擇", -1);
		// 		selectTitle.options[selectTitle.options.length] = option;
		// 		titleList.forEach(function(element, key) {
		// 			titleList[key] = new Option(element, key);
		// 		})
	}
	
	//填好人員會將開始日期預設為今天
	function setToday() {
		var startOclock = parseInt(document.getElementById("defStartH").value);
		var addHours = parseInt(document.getElementById("defPeriod").value);
		var start = document.getElementById("start");
		let end = document.getElementById("end");
		//讓時間從預設時間(addHours)開始 UTCHours會抓甚麼時區?
		const d = new Date().setHours(startOclock, 0, 0, 0);
		//取得時區，*60000 //offset in milliseconds
		let tzOffset = (new Date()).getTimezoneOffset() * 60000;  
		let newD = new Date(d);
		let today = new Date(newD-tzOffset).toISOString().slice(0, 19);
		start.value = today;
		let workingH = new Date(newD.setUTCHours(startOclock+addHours,0,0,0));
		let endTime = workingH.toISOString().substring(0, 19);
		end.value = endTime;
	}
	//改變開始時間時，結束時間跟著變動
	function setEnd() {
		var addHours = parseInt(document.getElementById("defPeriod").value);
		let ns = new Date(start.value);
		let h = new Date(ns.setUTCHours(ns.getHours() + addHours));
		let endTime = h.toISOString().substring(0, 19);
		end.value = endTime;
	}
//刪除資料
	function deleteData(pk) {
		if (!confirm("確定刪除第"+pk+"筆記錄?")) {
			return false;
		}
		let xhr3 = new XMLHttpRequest();
		xhr3.open("DELETE", "<c:url value='/schedule/' />" + pk,true);
		//	xhr3.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr3.send();
		xhr3.onreadystatechange = function() {
			// 伺服器請求完成
			if (xhr3.readyState == 4 && (xhr3.status == 200 || xhr3.status == 204)) {
				result = JSON.parse(xhr3.responseText);
				if (result.fail) {
					messageBox.innerHTML = "<font color='red' >"
							+ result.fail + "</font>";
				} else if (result.success) {
					messageBox.innerHTML = "<font color='green' >"
							+ result.success + "</font>";
					loadData();
				}
			}
		}
	}
//取消修改資料
	function cancelUpdate(){
		document.getElementById("messageBox").innerHTML="";
		loadData();
	}
//送出修改資料
	function updateData() {
		document.getElementById("sendData").disabled = false;
		document.getElementById("updateData").style.visibility = "hidden";
		var hasError =false;
		let messageBox = document.getElementById("messageBox");
		let ks = document.getElementById("keySchedule").value;
		let empList = document.getElementById("empList");
		let empNo = empList.options[empList.selectedIndex].value;
		let start = document.getElementById("start").value;
		let end = document.getElementById("end").value;
		let title = document.getElementById("titleList").value;
		if (empList.selectedIndex == 0) {
			hasError = true;
			messageBox.innerHTML = "<font color='red'>請選擇人員</font>";
		} else if(start > end) {
			hasError = true;
			messageBox.innerHTML = "<font color='red'>日期錯誤，結束早於開始，是在哈囉?</font>";
		} else if(title == ""){
			hasError = true;
			messageBox.innerHTML = "<font color='red'>請填入職務</font>";
		}
		if (hasError) {return false;}
		if (start.length == 16) {
			start += ":00";
		}
		if (end.length == 16) {
			end += ":00";
		}
		let obj={
				"keySchedule":ks,
				"emps" : {
					"pk" : empNo
				},
				"start" : start,
				"end" : end,
				"title" : title,
		};
		var xhr5 = new XMLHttpRequest();
		xhr5.open("PUT", "<c:url value='/schedule/'/>"+ks, true);
		xhr5.setRequestHeader("Content-Type", "application/json");
		xhr5.send(JSON.stringify(obj));
		xhr5.onreadystatechange = function() {
			// 伺服器請求完成
			if (xhr5.readyState == 4
					&& (xhr5.status == 200 || xhr5.status == 201)) {
				let result = JSON.parse(xhr5.responseText);
				if(result.fail){
					console.log("result.fail: " + result.fail)
					messageBox.innerHTML = "<font color='red' >"
						+ result.fail + "</font>";
			} else if (result.success) {
				messageBox.innerHTML = "<font color='green' >"
						+ result.success + "</font>";
						loadData();
// 				window.location.assign(window.location.href);
				}
			}
		}
	}

//讀取欲修改資料
	function editData(keySchedule) {
		$("#enter td").children("*").slice(1,5).css("background-color","#afa5fa")
		.css("transition-duration","3s");
		document.getElementById("keySchedule").style.visibility = "visible";
		document.getElementById("sendData").disabled = true;
		document.getElementById("updateData").style.visibility = "visible";
		document.getElementById("cancelUpdate").style.visibility = "visible";
		let messageBox = document.getElementById("messageBox");
		messageBox.innerHTML = "您正在修改資料中...";
		var xhr4 = new XMLHttpRequest();
		xhr4.open("GET", "<c:url value='/schedule/"+keySchedule+"'/>", true);
		xhr4.send();

		xhr4.onreadystatechange = function() {
			// 伺服器請求完成

			if (xhr4.readyState == 4
					&& (xhr4.status == 200 || xhr4.status == 201)) {
				let sched = JSON.parse(xhr4.responseText);
				document.getElementById("keySchedule").value = sched.keySchedule;
				document.getElementById("empList").value = sched.emps.pk;
				document.getElementById("start").value = sched.start;
				document.getElementById("end").value = sched.end;
				document.getElementById("titleList").value = sched.title;
			}
		}
	}

	//新增資料
	function sendData() {
		var hasError = false;
		var messageBox = document.getElementById("messageBox");
		let empList = document.getElementById("empList");
		let empNo = empList.options[empList.selectedIndex].value;
		let start = document.getElementById("start").value;
		let end = document.getElementById("end").value;
		let title = document.getElementById("titleList").value;
		if (empList.selectedIndex == 0) {
			hasError = true;
			messageBox.innerHTML = "<font color='red'>請選擇人員</font>";
		} else if(start > end) {
			hasError = true;
			messageBox.innerHTML = "<font color='red'>日期錯誤，結束早於開始，累了嗎?</font>";
		} else if(title == ""){
			hasError = true;
			messageBox.innerHTML = "<font color='red'>請填入職務</font>";
		}
		if (hasError) {return false;}
		//前端把秒移除，後端須加回去
		if (start.length == 16) {
			start += ":00"
		}
		if (end.length == 16) {
			end += ":00"
		}
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST", "<c:url value='/schedule/addSchedule'/>", true);
		var jsonSchedule = 
		{
			"emps" : {
				"pk" : empNo
			},
			"start" : start,
			"end" : end,
			"title" : title,
		}
		xhr1.setRequestHeader("Content-Type", "application/json");
		xhr1.send(JSON.stringify(jsonSchedule));
		xhr1.onreadystatechange = function() {
			// 伺服器請求完成
			if (xhr1.readyState == 4
					&& (xhr1.status == 200 || xhr1.status == 201)) {
				result = JSON.parse(xhr1.responseText);
				if (result.fail) {
					console.log("result.fail: " + result.fail)
					messageBox.innerHTML = "<font color='red'>出現錯誤，請詢問相關人員</font>";
				} else if (result.success) {
					messageBox.innerHTML = "<font color='Green'>新增成功</font>";
					loadData();
				}
			}
		}
	}
	function loadCSS() {
		$("button").addClass("btn btn-sm");
		$("#sendData").addClass("btn-secondary");
		$("#updateData").addClass("btn-secondary");
		$("tbody button").addClass("btn-light");
		$("#cancelUpdate").addClass("btn-light");
	}
	
</script>
</head>
<body>
	<div class="container-fluid h-75 pt-4">
		<!-- Basic Card Example -->
		<div class="card shadow mb-4">
			<!-- Begin of card-header -->
			<div class="card-header py-3">
				<div class="row">
						<div class="col-auto"><h6
								class="m-0 font-weight-bold text-primary">排班表</h6></div>
						<div class="col-auto"><strong>今天想要預設...</strong>
							<input type="number" value="9" id="defStartH" style="width: 45px;" />點開始，工作+休息共<input
							type="number" value="9" id="defPeriod" style="width: 45px;" />小時，專心排
							<select name='empListDef' id='empListDef' onfocus='setToday (this.id)'></select>的班，職務都寫
							<input type="text" value="到公司上班"/>
							</div>
						<div class="col-auto" id="messageBox"></div>
				</div>

			</div>
			<!-- End of Card-header -->
			<!-- Begin of Card-body -->
			<div id ="cardBody" class="card-body navbar-nav-scroll">
				<div id="dataArea"></div>
			</div>
			<!-- End of Card-body -->
		</div>
		<!-- End of Card -->
	</div>
<script>
$("#empListDef").mouseover(function(){
	$("#empListDef").val("4");
	$("#empList").val($("#empListDef" ).val());
	setToday();
});
$(window).resize(function() {
    var winH = $(this).height();
    $("#cardBody").height(winH*0.6);
}).resize();
</script>
</body>
</html>