package com.hr.calendar.service;

import java.util.List;

import com.hr.calendar.model.CalendarTask;

public interface CalendarService {
	
	void newTask(CalendarTask task);

	void edit(CalendarTask task);

	void delete(Integer no);

	List<CalendarTask> showTasksByEmpNo(String empNo);

	CalendarTask findTheTask(Integer no);

}
