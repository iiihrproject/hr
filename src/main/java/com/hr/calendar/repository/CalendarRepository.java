package com.hr.calendar.repository;

import java.util.List;

import com.hr.calendar.model.CalendarTask;

public interface CalendarRepository {
	
	void newTask(CalendarTask task);
	
	void edit(CalendarTask task);

	void delete(Integer no);

	List<CalendarTask> showTasksByEmpNo(String empNo);
	
	CalendarTask findTheTask(Integer no);
	
}
