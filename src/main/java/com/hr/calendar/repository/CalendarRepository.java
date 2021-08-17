package com.hr.calendar.repository;

import java.sql.Date;
import java.util.List;

import com.hr.calendar.model.CalendarTask;

public interface CalendarRepository {
	
	void newTask(CalendarTask task);
	
	void edit(CalendarTask task);

	void delete(CalendarTask task);

	List<CalendarTask> showTasksByEmpNo(String empNo);
	
	CalendarTask findTheTask(Date startTime, String taskTitle);
}
