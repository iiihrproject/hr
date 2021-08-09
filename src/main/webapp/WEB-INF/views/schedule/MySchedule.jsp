<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8' />
<link href="<c:url value='/css/scheduler/main.min.css' />"
	rel='stylesheet' type="text/css" />
<script src="<c:url value='/js/scheduler/main.min.js' />"></script>
<script src="<c:url value='/webjars/jquery/3.1.1-1/jquery.min.js' />"></script>
<script>
// //  get emp data from DB
window.onload = function() {
	//讀取人員資料
// // 	let dataArea = document.getElementById("dataArea");
// 	let xhr = new XMLHttpRequest();
// 	xhr.open("GET", "<c:url value='/schedule/getEmp/findAll'/>");
// 	xhr.send();
// 	xhr.onreadystatechange = function() {
// 		if (xhr.readyState == 4 && xhr.status == 200) {
// 			let emp = processEmpData(xhr.responseText);
// 		}
// 	}
	
//讀取班表資料
	let xhr = new XMLHttpRequest();
	xhr.open("GET", "<c:url value='/schedule/findAllScheduleAjax'/>");
	xhr.send();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			processScheduleData(xhr.responseText);
		}
	}
}//end of windows.onload
//轉換班表格式
	function processScheduleData(jsonString) {
		let roster = JSON.parse(jsonString);
		console.log(roster.length);
		
		const events = roster.map((r) =>{
			return {id: r.keySchedule,
				resourceId: r.empNo,
				start: r.start,
				end: r.end,
				title: r.title
				}
			});
		
		
		console.log(events);
		
		renderScheduler(events);
	}//end of processScheduleData

// function processEmpData(jsonString) {
// 	let emps = JSON.parse(jsonString);
// console.log(emp)}
	
function renderScheduler(events) {

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
    var d = new Date().toJSON().substring(0,10);
    var calendar = new FullCalendar.Calendar(calendarEl, {
      now: d,
      editable: false, // enable draggable events
      droppable: false, // this allows things to be dropped onto the calendar
      aspectRatio: 1.8,
      scrollTime: '06:00', // undo default 6am scrollTime
      headerToolbar: {
        left: 'today prev,next',
        center: 'title',
        right: 'resourceTimelineDay,resourceTimelineThreeDays,timeGridWeek,dayGridMonth'
      },
      initialView: 'resourceTimelineDay',
      views: {
        resourceTimelineThreeDays: {
          type: 'resourceTimeline',
          duration: { days: 5 },
          buttonText: '5 days'
        }
      },
      eventOverlap: false, // will cause the event to take up entire resource height
      resourceAreaWidth: '10%',
      resourceAreaHeaderContent: 'Employee',
      resources: [
        { id: '100001', title: '人員 A', eventColor: 'red'  },
        { id: '1001', title: '人員 B', eventColor: 'orange' },
        { id: '400001', title: '人員 C', eventColor: 'yellow' },
        { id: '457895', title: '人員 D', eventColor: 'green' },
        { id: '747272', title: '人員 E'},
        { id: 'f', title: '人員 F', eventColor: 'indigo' },
        { id: 'g', title: '人員 G', eventColor: 'purple'   }
      ],
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
	margin-top: 40px;
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
	height: 580px;
}
</style>
</head>
<body>
	<div id='wrap'>

		<div id='external-events' style='visibility: hidden'>
			<h4>工作內容</h4>
			<div class='fc-event'>前端</div>
			<div class='fc-event'>後端</div>
			<div class='fc-event'>整合</div>
			<div class='fc-event'>管理</div>
			<p>
				<input type='checkbox' id='drop-remove' /> <label for='drop-remove'>remove
					after drop</label>
			</p>
		</div>

		<div id='calendar'></div>

		<div style='clear: both'></div>

	</div>
</body>
</html>