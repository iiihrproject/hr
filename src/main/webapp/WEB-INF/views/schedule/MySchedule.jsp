<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang='zh-TW'>
<head>
<meta charset='UTF-8' />
<link href="<c:url value='/css/scheduler/main.min.css' />"
	rel='stylesheet' type="text/css" />
<script src="<c:url value='/js/scheduler/main.min.js' />"></script>
<script src="<c:url value='/js/jquery-3.6.0.min.js' />"></script>
<script>
var resources = [];
var events = [];
window.onload = function() {
	loadSchedule();
}//end of windows.onload

//讀取人員資料
function loadEmps(){
	let xhr2 = new XMLHttpRequest();
	var myDeptNo = ${sessionScope.loginModel.getDepartmentDetail().getDepartmentNumber()};
	xhr2.open("GET", "<c:url value='/G/findEmpsByDept'/>" + "?departmentNumber=" + myDeptNo);
	xhr2.send();
	xhr2.onreadystatechange = function() {
		if (xhr2.readyState == 4 && xhr2.status == 200) {
			processEmpData(xhr2.responseText);
			renderScheduler(events, resources);
			console.log(events);
			console.log(resources);
		}
	}
}

//讀取班表資料
function loadSchedule(){
	let xhr = new XMLHttpRequest();
	xhr.open("GET", "<c:url value='/schedule/findAllScheduleAjax'/>");
	xhr.send();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
		 processScheduleData(xhr.responseText);
		 loadEmps();
		}
	}
}

//轉換班表格式
function processScheduleData(jsonString) {
	let roster = JSON.parse(jsonString);
	console.log(roster);
	if (roster.length == 0) {
		events = roster.map((r) =>{
		return {id: 0,
			resourceId: r.emps.empNo,
			start: "2021-01-05",
			end: "2021-01-05",
			title: "test"
			}});
	} else {
	events = roster.map((r) =>{
		return {id: r.keySchedule,
			resourceId: r.emps.empNo,
			start: r.start,
			end: r.end,
			title: r.title
			}
		});}
// 	renderScheduler(events);
}//end of processScheduleData
// 	console.log(processScheduleData(jsonString));

// 轉換人員格式
function processEmpData(jsonString) {
	let emps = JSON.parse(jsonString);
	resources = emps.map((r)=>{
		return {
		id: r.empNo,
		title: r.name
		}
	});
// 	renderScheduler(resources);
}//end of processEmpData

function renderScheduler(events,resources) {

    /* initialize the external events
    -----------------------------------------------------------------*/

    var containerEl = document.getElementById('external-events');
    new FullCalendar.Draggable(containerEl, {
      itemSelector: '.fc-event',
      eventData: function(eventEl) {
        return {
          title: eventEl.innerText.trim()
        }
      }
    });

    /* initialize the calendar
    -----------------------------------------------------------------*/

    var calendarEl = document.getElementById('calendar');
    var d = new Date().toJSON();
    var calendar = new FullCalendar.Calendar(calendarEl, {
      height: 'auto', // enough to active sticky headers
        stickyHeaderDates: true,
        stickyFooterScrollbar: true,
      now: d,
      editable: false, // enable draggable events
      selectable: true,
      droppable: false, // this allows things to be dropped onto the calendar
      aspectRatio: 1.8,
      scrollTime: '08:00', // undo default 6am scrollTime
      slotMinTime: '06:00',
      dayMinWidth: 50,
      headerToolbar: {
        left: 'today prev,next',
        center: 'title',
        right: 'resourceTimelineDay,resourceTimelineThreeDays,resourceTimeGridWeek,resourceTimelineMonth'
      },
      initialView: 'resourceTimelineDay',
      nowIndicator: true,
      views: {
        resourceTimelineThreeDays: {
          type: 'resourceTimeline',
          duration: { days: 5 },
          buttonText: '5 days'
        }
      },
      eventOverlap: false, // will cause the event to take up entire resource height
      navLinks: true,
      resourceAreaWidth: '10%',
      resourceAreaHeaderContent: '${sessionScope.loginModel.departmentDetail.name}',
      allDaySlot: false,
      businessHours:true,
      resourceOrder: 'id,title',
      resources: resources,
      events: events,
      drop: function(arg) {
        console.log('drop date: ' + arg.dateStr)

        if (arg.resource) {
          console.log('drop resource: ' + arg.resource.id)
        }

        // is the "remove after drop" checkbox checked?
        if (document.getElementById('drop-remove').checked) {
          // if so, remove the element from the "Draggable Events" list
          arg.draggedEl.parentNode.removeChild(arg.draggedEl);
        }
      },
      eventReceive: function(arg) { // called when a proper external event is dropped
        console.log('eventReceive', arg.event);
      },
      eventDrop: function(arg) { // called when an event (already on the calendar) is moved
        console.log('eventDrop', arg.event);
      }
    });
    calendar.render();
}

</script>
<style>
body {
	font-size: 14px;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
}

#wrap {
	width: 100%;
	height: 100%;
	margin: 0 auto;
}

#external-events {
	position: fixed;
	bottom: 20px;
	left: 100px;
	z-index: 5;
	/*      float: left;  */
	width: 150px;
	padding: 0 10px;
	border: 1px solid #ccc;
	background: #eee;
	text-align: left;
}

#external-events h4 {
	font-size: 16px;
	margin-top: 0;
	padding-top: 1em;
}

#external-events .fc-event {
	margin: 10px 0;
	cursor: pointer;
}

#external-events p {
	margin: 1.5em 0;
	font-size: 11px;
	color: #666;
}

#external-events p input {
	margin: 0;
	vertical-align: middle;
}

#calendar {
	float: right;
	width: 100%;
	height: 65%;
}
</style>
</head>
<body>
	<div class="container-fluid h-75 pt-4">
		<!-- Basic Card Example -->
		<div class="card shadow mb-4">
			<!-- Begin of card-header -->
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">${sessionScope.loginModel.departmentDetail.name}的班表</h6>
			</div>
			<!-- End of Card-header -->
			<!-- Begin of Card-body -->
			<div class="card-body">
				<div id='wrap'>
					<div id='external-events' style='visibility: hidden'>
						<h4>工作內容</h4>
						<div class='fc-event'>前端</div>
						<div class='fc-event'>後端</div>
						<div class='fc-event'>整合</div>
						<div class='fc-event'>管理</div>
						<p>
							<input type='checkbox' id='drop-remove' /> <label
								for='drop-remove'>remove after drop</label>
						</p>
					</div>
					<div id='calendar'></div>
					<div style='clear: both'></div>
				</div>
				<!-- End of Card-body -->
			</div>
			<!-- End of Card -->
		</div>
	</div>
</body>
</html>